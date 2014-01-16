void * thread_multi_readDelays(void *data);
void *thread_readDelays(void *data);

typedef struct {
    int numEls;
    const char * *filenames;
    Table *counts;
    int fieldNum;
} FileNames;

