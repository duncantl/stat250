int readRecord(char *line, int fieldNum);
double readDelays(const char *filename, void *d, int fieldNum);

#define MAX_NUM_CHARS 2000
#define MAX_NUM_VALUES 4000

//#define FIELD_NUM 44
#define FIELD_NUM 15


/* Really want a C++ class. */
typedef struct  {
    int min, max;
    int numValues;
    int observedMin, observedMax;
    long values[MAX_NUM_VALUES + 1];
} Table;

Table* combineTables(Table **tables, int num, Table *out);

Table *makeTable(Table *tt);
