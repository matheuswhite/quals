use std::sync::Arc;
use std::sync::atomic::{AtomicU32, Ordering};
use std::thread;

fn main() {
    let setpoint = Arc::new(AtomicU32::new(0));

    let comm_sp = Arc::clone(&setpoint);
    let comm = thread::spawn(move || {
        for i in 1..=1_000_000u32 {
            comm_sp.store((i as f32).to_bits(), Ordering::Relaxed);
        }
    });

    let ctrl_sp = Arc::clone(&setpoint);
    let ctrl = thread::spawn(move || {
        let mut last = 0.0f32;
        for _ in 0..1_000_000 {
            last = f32::from_bits(ctrl_sp.load(Ordering::Relaxed));
        }
        last
    });

    comm.join().unwrap();
    let last = ctrl.join().unwrap();
    println!("ultimo setpoint: {}", last);
}
