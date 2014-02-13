a = load 'Full.csv' USING PigStorage(',');
d = FILTER a BY $0 != 'A';
DUMP d;


a = load 'Full.csv' USING PigStorage(',');
d = FILTER a BY no $0 matches '[A-Za-z]';
DUMP d;

