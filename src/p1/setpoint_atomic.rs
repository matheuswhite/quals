// author: Claude (claude-opus-4-8)
// created: 2026-07-23
//
// Caso P1 -- a forma SEGURA que COMPILA: setpoint escalar via AtomicU32.
// ANDAIME p/ o Matheus testar/adaptar.
//
//   rustc -O setpoint_atomic.rs -o setpoint_atomic && ./setpoint_atomic
//
// AtomicU32 e Sync -> pode ser um `static` compartilhado. store/load atomicos com
// Ordering tornam o data race INEXPRIMIVEL. O f32 viaja como bits (to_bits/from_bits),
// porque nao ha AtomicF32. Aqui Relaxed basta: um escalar independente, sem publicar
// outra memoria junto (se houvesse, reavaliar a Ordering -- ver 4.2/4.3 no cap. 4).
//
// No ESP32/ESP32-S3, store/load atomicos rebaixam p/ instrucao nativa (barato); no
// ESP32-S2 viram libcall. Ver o achado (a confirmar no disassembly) em
// plan/cap_5_resultados.md.
//
// Testado em 2026-07-23 (rustc 1.93.1, edition padrao): compila e roda.

use std::sync::atomic::{AtomicU32, Ordering};
use std::thread;

// estado compartilhado mutavel COM sincronizacao: AtomicU32 e Sync.
static SETPOINT: AtomicU32 = AtomicU32::new(0);

fn main() {
    let comm = thread::spawn(|| {
        for i in 1..=1_000_000u32 {
            SETPOINT.store((i as f32).to_bits(), Ordering::Relaxed);
        }
    });

    let ctrl = thread::spawn(|| {
        let mut last = 0.0f32;
        for _ in 0..1_000_000 {
            last = f32::from_bits(SETPOINT.load(Ordering::Relaxed));
        }
        last
    });

    comm.join().unwrap();
    let last = ctrl.join().unwrap();
    println!("ultimo setpoint: {}", last);
}
