numbers = load 'numbers.txt' as (V1:int, V2:int, V3:int, V4:int);
numbers1 = load 'numbers.txt' as (V1:int, V2:int, V3:int, V4:int);
letters = load 'letters.txt' as (X:chararray, Y:chararray, Z:chararray);

m = JOIN numbers BY V1 outer, numbers1 BY V1;

