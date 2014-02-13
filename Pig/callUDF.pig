letters = load 'letters.txt' as (X:chararray, Y:chararray, Z:chararray);
tmp = FOREACH letters GENERATE CONCAT(X, 'XYZ') AS bob;

register '/home/duncan/pig-0.12.0/contrib/piggybank/java/piggybank.jar';
tmp1 = FOREACH tmp GENERATE org.apache.pig.piggybank.evaluation.string.Reverse(bob);

define reverse org.apache.pig.piggybank.evaluation.string.Reverse();
tmp1 = FOREACH tmp GENERATE reverse(bob);

/* */