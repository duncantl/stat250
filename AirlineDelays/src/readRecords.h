int readRecord(char *line, int fieldNum);
unsigned long readDelays(const char *filename, void *d, int fieldNum);

#define MAX_NUM_CHARS 2000
#define MAX_NUM_VALUES 4000

//#define FIELD_NUM 44
#define FIELD_NUM 14


/* Really want a C++ class. */
typedef struct  {
    int min, max;
    int numValues;
    int observedMin, observedMax;
    unsigned long values[MAX_NUM_VALUES + 1];
} Table;

Table* combineTables(Table **tables, int num, Table *out);

Table *makeTable(Table *tt);
