// vytvorim prozatimni promenne
_parametr = _this;
call compile format ["CELO_aktualni_start = CELO_etapa_start%1;",_parametr];
call compile format ["CELO_aktualni_cil = CELO_etapa_cil%1;",_parametr];

// vytvorim vozidlo, hodim jednotku do vozidla
car =  createVehicle [CELO_CAR_TYP,position CELO_aktualni_start,[],0,"NONE"];
car setdir getdir CELO_aktualni_start;
player moveindriver car;
call compile format["player setCurrentTask obj%1;",_parametr];
// pridam kontrolu, zda je hrac jeste ve vozidle
0 spawn { // handler zlobil, zkusime to jinak
  waituntil {car != vehicle player};
  sleep 0.1;
  {unassignvehicle _x;_x action ["EJECT",car]} foreach crew car;
  sleep 0.1;
  deletevehicle car;
};

CELO_START_ETAPY = true;

// nastavim WP
_group = group player;
[_group, 1] setWaypointPosition [position CELO_aktualni_cil,0];
_group setCurrentWaypoint [_group,1];
call compile format ["[_group,1] setWaypointDescription ""CÍL ETAPY %1"";",_parametr]; 
car move getpos CELO_aktualni_cil;

call compile format ["CELO_JEDU_FAZI=%1",_parametr];
CELO_JEDU_CAS = time;

sleep 1;

CELO_START_ETAPY = false;

// pockam dokud nezacne novou etapu nebo nedojede do cile
waituntil {CELO_START_ETAPY or (car distance CELO_aktualni_cil <5)};
if ((car distance CELO_aktualni_cil)<5) then {
  _null = _parametr execVM "sqf\vuz_v_cili.sqf";
};
true;