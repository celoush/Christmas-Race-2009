for [{_i=1},{_i<=(celkem_fazi)},{_i=_i+1}] do {
  call compile format["vypisArr = casy_%1",_i];
  _total = Count vypisArr;
  call compile format["vypis = ""Časy %1 sekce\n"";",_i];
  for [{_j=0},{_j<(_total)},{_j=_j+1}] do {
    _subpole = (vypisArr select _j);
    call compile format["vypis = vypis + ""%1: %2 \n"";",_subpole select 0,_subpole select 1];
  };
  hintSilent vypis;
  diag_log vypis;
  sleep 3;
};