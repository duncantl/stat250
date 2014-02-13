numbers = load 'numbers.txt' as (V1:int, V2:int, V3:int, V4:int);

register 'myudfs.jar';
z = FOREACH numbers GENERATE SinSquare((double) V1);
DUMP z;

/* We need two different loads. */
numbers1 = load 'numbers.txt' as (V1:int, V2:int, V3:int, V4:int);
z = CROSS numbers, numbers1;

register 'myudfs.jar';
tmp1 = FOREACH z GENERATE Euclidean(*);
DUMP tmp1;