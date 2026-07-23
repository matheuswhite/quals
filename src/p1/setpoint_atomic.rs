use std::io::BufRead;
use std::sync::Arc;
use std::sync::atomic::{AtomicU32, Ordering};
use std::thread;
use std::time::Duration;

fn main() {
    let setpoint = Arc::new(AtomicU32::new(0));

    let comm_sp = setpoint.clone();
    let comm = thread::spawn(move || {
        let stdin = std::io::stdin();

        for line in stdin.lock().lines() {
            let line = line.unwrap();

            let Ok(v) = line.trim().parse::<f32>() else {
                continue;
            };

            comm_sp.store(v.to_bits(), Ordering::Relaxed);
        }
    });

    let ctrl_sp = setpoint.clone();
    let ctrl = thread::spawn(move || {
        let mut last_printed = 0.0f32;

        loop {
            let sp = f32::from_bits(ctrl_sp.load(Ordering::Relaxed));
            if sp != last_printed {
                println!("controle: setpoint = {:.1}", sp);
                last_printed = sp;
            }

            thread::sleep(Duration::from_millis(1));
        }
    });

    comm.join().unwrap();
    ctrl.join().unwrap();
}
