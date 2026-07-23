use std::cell::Cell;
use std::io::BufRead;
use std::thread;
use std::time::Duration;

static SETPOINT: Cell<f32> = Cell::new(0.0);

fn main() {
    let comm = thread::spawn(|| {
        let stdin = std::io::stdin();

        for line in stdin.lock().lines() {
            let line = line.unwrap();

            let Ok(v) = line.trim().parse::<f32>() else {
                continue;
            };

            SETPOINT.set(v);
        }
    });

    let ctrl = thread::spawn(|| {
        let mut last_printed = 0.0f32;

        loop {
            let sp = SETPOINT.get();
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
