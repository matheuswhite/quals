#include <stdio.h>
#include <pthread.h>

static float g_setpoint = 0.0f;

static void *comm_task(void *arg) {
    (void)arg;
    for (int i = 1; i <= 1000000; ++i) {
        g_setpoint = (float)i;
    }
    return NULL;
}

static void *control_loop(void *arg) {
    (void)arg;
    float last = 0.0f;
    for (int i = 0; i < 1000000; ++i) {
        float sp = g_setpoint;
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
