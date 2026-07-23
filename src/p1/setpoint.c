// author: Claude (claude-opus-4-8)
// created: 2026-07-23
//
// Caso P1 (setpoint escalar compartilhado) do cap. 5 -- micro-exemplo em C (host).
// ANDAIME p/ o Matheus testar/adaptar; NAO e a versao final -- os numeros de linha
// mudam quando voce editar, entao regenere as saidas antes de citar.
//
// Cenario: a tarefa de comunicacao (writer) e o laco de controle (reader)
// compartilham um setpoint escalar SEM sincronizacao. Em C isso COMPILA e RODA;
// o data race fica latente (a leitura pode ver um valor obsoleto/rasgado). O
// ThreadSanitizer o detecta quando o caminho concorrente e exercitado.
//
// Testado em 2026-07-23 (host, clang/arm64): plain compila limpo (-Wall -Wextra)
// e roda; a variante -fsanitize=thread reporta "data race" em g_setpoint.
//
//   make run-plain   -> compila e roda (DR latente, sem erro do compilador)
//   make run         -> compila com TSan e roda (reporta o data race se exercitado)

#include <stdio.h>
#include <pthread.h>

/* setpoint compartilhado: escrito pela tarefa de comm, lido pelo laco de controle.
   nenhum mutex, nenhum atomic -> data race. */
static float g_setpoint = 0.0f;

/* tarefa de comunicacao: recebe novas referencias e as publica no setpoint */
static void *comm_task(void *arg) {
    (void)arg;
    for (int i = 1; i <= 1000000; ++i) {
        g_setpoint = (float)i;   /* ESCRITA sem sincronizacao */
    }
    return NULL;
}

/* laco de controle: le o setpoint a cada ciclo para computar a acao de controle */
static void *control_loop(void *arg) {
    (void)arg;
    float last = 0.0f;
    for (int i = 0; i < 1000000; ++i) {
        float sp = g_setpoint;   /* LEITURA sem sincronizacao (concorrente c/ a escrita) */
        last = sp;
    }
    printf("ultimo setpoint lido pelo laco de controle: %.1f\n", (double)last);
    return NULL;
}

int main(void) {
    pthread_t comm, ctrl;
    pthread_create(&comm, NULL, comm_task, NULL);
    pthread_create(&ctrl, NULL, control_loop, NULL);
    pthread_join(comm, NULL);
    pthread_join(ctrl, NULL);
    return 0;
}
