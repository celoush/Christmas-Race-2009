titlecut ["","BLACK IN",999999999999999];
// init sqf soubor
celkem_fazi = 5;
for [{_i=1},{_i<=(celkem_fazi)},{_i=_i+1}] do {call compile format["casy_%1 = []",_i];};
enableEnvironment false;
diary = player createDiaryRecord ["Diary", [localize "STR_CELO_DiaryName",  localize "STR_CELO_DiaryDescription"]];

for [{_i=celkem_fazi},{_i>=1},{_i=_i-1}] do {
  call compile format["obj%1  = player createSimpleTask [localize ""STR_CELO_Task%1Name""];obj%1 setSimpleTaskDescription [localize ""STR_CELO_Task%1Descr1_0"",localize ""STR_CELO_Task%1Descr1_1"",localize ""STR_CELO_Task%1Descr1_2""];obj%1 setSimpletaskDestination (getMarkerPos ""cil%1"");obj%1 setTaskState ""CREATED"";",_i];
};

pred_konec = false;

titlecut ["","BLACK IN",5];
if (isServer) then {
  setviewdistance 200;
  start_time = time;
};


if (isPlayer player) then {
  0 spawn {
    playmusic "CELO_Christmas_intro";
    sleep 3;
    titleRsc ["CELO_titlesceloush", "PLAIN"];
    sleep 5;
    titleRsc ["CELO_titlesuvadi", "PLAIN"];
    sleep 5;
    titleRsc ["CELO_titlesorb", "PLAIN"];
  };

  sleep 3;

  _group = group player;
  CELO_JEDU_FAZI = 0; 
  CELO_JEDU_CAS  = 0;
  CELO_CAR_TYP   = "VWGolf";
  //CELO_CAR_TYP   = "qin_evoix_orange";
  _typy = ["qin_evoix_orange","qin_evoix_green","qin_evoix_black","qin_evoix_blue","qin_evoix_gray","qin_evoix_red"];
  CELO_CAR_TYP  = _typy select (ceil random count _typy);
  
  CELO_START_ETAPY = false;
  // cast pro hrace
  
  sleep 5;
  (_group) addWaypoint [position player,0];
  [_group, 1] setWaypointSpeed "FULL";
  [_group, 1] setWaypointBehaviour "SAFE";
  [_group, 1] setWaypointType "SAD";
  [_group, 1] setWaypointDescription "VYBERTE SI ETAPU";
  
  _null = 0 execVM "sqf\addaction.sqf";
  
  0 spawn {
    waitUntil {pred_konec};
    titleRsc ["CELO_titleskonec", "PLAIN"];
    sleep 10; 
    titleRsc ["CELO_titlesorb", "PLAIN"];
    sleep 10;
    titleRsc ["CELO_titleskonec", "PLAIN"];
  };
  
  CELO_EH_respawn = player addeventhandler ["killed",{_this exec "sqf\respawn.sqf"}];
  
  //onPlayerConnected 
  
};

if (isServer) then {
  celkem_se_hraje_minut = 90;  
  waitUntil { (start_time + celkem_se_hraje_minut*60) < time  };
  pred_konec = true;
  publicVariable "pred_konec";
  diag_log "SERVER VYSLEDEK";
  for [{_i=1},{_i<=(celkem_fazi)},{_i=_i+1}] do {
    call compile format["vypisArr = casy_%1",_i];
    _total = Count vypisArr;
    call compile format["vypis = ""Časy %1 sekce"";",_i];
    for [{_j=0},{_j<(_total)},{_j=_j+1}] do {
      _subpole = (vypisArr select _j);
      call compile format["vypis = vypis + ""%1: %2 - "";",_subpole select 0,_subpole select 1];
    };
    diag_log vypis;
  };
  diag_log "SERVER KONEC VYSLEDKU";
  sleep 30;
  konec = true;
  publicVariable "konec";
};

