/**** A simple sort and merge program of two SAS datasets ****/

libname datain '\cc\programs\datain';
libname dataout '\cc\programs\dataout';

options obs=MAX;

proc sort data=dataout.in_A(keep=account) nodupkey;
  by account;
run;

proc sort data=dataout.in_B(keep=account) nodupkey;
  by account;
run;

data dataout.in_A dataout.in_B dataout.matchAB;
  merge datain.fileA(in=A) datain.fileB(in=B); by account;

  if A = 1 and B = 0
    then
      output dataout.in_A;
  else if A = 0 and B = 1
    then
      output dataout.in_B;
  else
    if A = 1 and B = 1
      then 
        output dataout.matchAB;
run;

endsas;