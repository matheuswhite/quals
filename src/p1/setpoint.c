#include <stdio.h>
#include <pthread.h>
#include <time.h>

static float g_setpoint = 0.0f;

static void *comm_task(void *arg) {
    (void)arg;

    char line[64];
    float v;

    while (fgets(line, sizeof line, stdin)) {
        if (sscanf(line, "%f", &v) != 1) {
            continue;
        }

        g_setpoint = v;
    }

    return NULL;
}

static void *control_loop(void *arg) {
    (void)arg;

    struct timespec period = {0, 1000000L,};
    float last_printed = 0.0f;
    float sp;

    while (1) {
        sp = g_setpoint;
        if (sp != last_printed) {
            printf("controle: setpoint = %.1f\n", (double)sp);
            last_printed = sp;
        }

        nanosleep(&period, NULL);
    }

    return NULL;
}

int main(void) {
    pthread_t comm, ctrl;

    setvbuf(stdout, NULL, _IOLBF, 0);

    pthread_create(&comm, NULL, comm_task, NULL);
    pthread_create(&ctrl, NULL, control_loop, NULL);

    pthread_join(comm, NULL);
    pthread_join(ctrl, NULL);

    return 0;
}
