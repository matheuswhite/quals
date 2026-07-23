// author: Claude (claude-opus-4-8)
// created: 2026-07-23
//
// Caso P1 -- a MESMA intencao do setpoint.c, em Rust safe: NAO COMPILA (de proposito).
// ANDAIME p/ o Matheus: rode e SALVE a mensagem real do rustc num arquivo p/ colar.
//
//   rustc setpoint_safe.rs 2> setpoint_safe.rustc.txt    # captura a recusa (E0277)
//
// Um setpoint escalar mutavel compartilhado (aqui como `static`) precisa ser Sync;
// `Cell<f32>` NAO e Sync -> o compilador recusa na declaracao do static. O data
// race do C fica INEXPRIMIVEL em safe Rust: nao ha como declarar o estado
// compartilhado mutavel sem sincronizacao.
//
// Testado em 2026-07-23 (rustc 1.93.1, edition padrao): recusa com exatamente
//   error[E0277]: `Cell<f32>` cannot be shared between threads safely
//   = help: the trait `Sync` is not implemented for `Cell<f32>`
//   = note: shared static variables must have a type that implements `Sync`
// (confirme a mensagem na SUA toolchain -- e a evidencia primaria do caso.)

use std::cell::Cell;
use std::thread;

// estado compartilhado mutavel SEM sincronizacao -- recusado: `static` exige Sync.
static SETPOINT: Cell<f32> = Cell::new(0.0);

fn main() {
    // tarefa de comunicacao: publica novas referencias
    let comm = thread::spawn(|| {
        for i in 1..=1_000_000 {
            SETPOINT.set(i as f32);
        }
    });

    // laco de controle: le o setpoint a cada ciclo
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
