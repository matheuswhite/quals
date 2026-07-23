use std::cell::Cell;
use std::thread;

static SETPOINT: Cell<f32> = Cell::new(0.0);

fn main() {
    let comm = thread::spawn(|| {
        for i in 1..=1_000_000 {
            SETPOINT.set(i as f32);
        }
    });

    let ctrl = thread::spawn(|| {
        let mut last = 0.0f32;
        for _ in 0..1_000_000 {
            last = SETPOINT.get();
        }
        last
    });

    comm.join().unwrap();
    let last = ctrl.join().unwrap();
    println!("ultimo setpoint: {}", last);
}
