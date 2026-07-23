#![no_std]
#![no_main]

use core::cell::RefCell;

use critical_section::Mutex;
use esp_backtrace as _;
use esp_hal::{
    analog::adc::{Adc, AdcConfig, AdcPin, Attenuation},
    gpio::GpioPin,
    handler,
    peripherals::ADC1,
    time::Duration,
    timer::timg::{Timer, TimerGroup},
};
use heapless::spsc::{Producer, Queue};
use static_cell::StaticCell;

type Sample = u16;
const CAP: usize = 32;

struct Sampler {
    timer: Timer,
    adc: Adc<'static, ADC1>,
    pin: AdcPin<GpioPin<34>, ADC1>,
    tx: Producer<'static, Sample, CAP>,
}

static SAMPLER: Mutex<RefCell<Option<Sampler>>> = Mutex::new(RefCell::new(None));
static QUEUE: StaticCell<Queue<Sample, CAP>> = StaticCell::new();

#[handler]
fn on_tick() {
    critical_section::with(|cs| {
        let mut guard = SAMPLER.borrow(cs).borrow_mut();
        let Some(s) = guard.as_mut() else {
            return;
        };

        s.timer.clear_interrupt();

        if let Ok(sample) = nb::block!(s.adc.read_oneshot(&mut s.pin)) {
            let _ = s.tx.enqueue(sample);
        }
    });
}

#[esp_hal::main]
fn main() -> ! {
    let p = esp_hal::init(esp_hal::Config::default());

    let mut adc_config = AdcConfig::new();
    let pin = adc_config.enable_pin(p.GPIO34, Attenuation::_11dB);
    let adc = Adc::new(p.ADC1, adc_config);

    let timg0 = TimerGroup::new(p.TIMG0);
    let mut timer = timg0.timer0;
    timer.set_interrupt_handler(on_tick);
    timer.load_value(Duration::from_millis(1)).unwrap();
    timer.enable_interrupt(true);
    timer.start();

    let (tx, mut rx) = QUEUE.init(Queue::new()).split();

    critical_section::with(|cs| {
        SAMPLER
            .borrow(cs)
            .borrow_mut()
            .replace(Sampler { timer, adc, pin, tx });
    });

    loop {
        while let Some(sample) = rx.dequeue() {
            let _action = control_step(sample);
        }
    }
}

fn control_step(sample: Sample) -> Sample {
    sample
}
