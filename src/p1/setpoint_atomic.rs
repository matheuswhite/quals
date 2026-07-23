// author: Claude (claude-opus-4-8)
// created: 2026-07-23
// modified:
//   2026-07-23 (Claude): static AtomicU32 -> Arc<AtomicU32> (a pedido do Matheus),
//     p/ prefigurar Mirror::Primitive32 { Arc<AtomicU32> } da Aule (tier1/sync/mirror.rs).
//
// Caso P1 -- a forma SEGURA que COMPILA: setpoint escalar compartilhado via AtomicU32.
// ANDAIME p/ o Matheus testar/adaptar.
//
//   rustc -O setpoint_atomic.rs -o setpoint_atomic && ./setpoint_atomic
//
// AtomicU32 e Sync -> pode ser compartilhado entre threads. Aqui o compartilhamento e por
// Arc (contagem de referencia), NAO por `static` -- de proposito: e a mesma forma que a
// Aule usa (Mirror::Primitive32 { data: Arc<AtomicU32> }), entao o exemplo prefigura como
// o setpoint aparece no artefato. store/load atomicos com Ordering tornam o data race
// INEXPRIMIVEL. O f32 viaja como bits (to_bits/from_bits), porque nao ha AtomicF32 (a Aule
// faz o mesmo, via T: Into<AtomicU32>). Aqui Relaxed basta: um escalar independente, sem
// publicar outra memoria junto (se houvesse, reavaliar a Ordering -- ver 4.2/4.3 no cap. 4).
//
// Nota (tradeoff da escolha): Arc exige `alloc`/heap; o `static AtomicU32` da versao
// anterior e core puro (sem heap). Os dois tornam o DR inexprimivel -- a troca aqui e so
// por fidelidade a Aule, nao por correcao.
//
// No ESP32/ESP32-S3, store/load atomicos rebaixam p/ instrucao nativa (barato); no
// ESP32-S2 viram libcall. Ver o achado (a confirmar no disassembly) em
// plan/cap_5_resultados.md.
//
// Testado em 2026-07-23 (rustc 1.93.1, edition padrao): compila e roda.

use std::sync::Arc;
use std::sync::atomic::{AtomicU32, Ordering};
use std::thread;

fn main() {
    // estado compartilhado mutavel COM sincronizacao: Arc<AtomicU32>.
    // AtomicU32 e Sync; o Arc da o compartilhamento entre threads (como Mirror::Primitive32).
    let setpoint = Arc::new(AtomicU32::new(0));

    // tarefa de comunicacao: publica novas referencias
    let comm_sp = Arc::clone(&setpoint);
    let comm = thread::spawn(move || {
        for i in 1..=1_000_000u32 {
            comm_sp.store((i as f32).to_bits(), Ordering::Relaxed);
        }
    });

    // laco de controle: le o setpoint a cada ciclo
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
