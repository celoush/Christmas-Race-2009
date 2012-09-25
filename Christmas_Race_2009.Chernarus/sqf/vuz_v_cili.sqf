// dojel do cile
_dojel_v_case = time - CELO_JEDU_CAS;
call compile format ["[obj%1 setTaskState ""Succeeded"";]",CELO_JEDU_FAZI];

sleep 4;
hint format ["%2.etapa dojeta za %1 sekund",_dojel_v_case,CELO_JEDU_FAZI];

// zjistim v jakem case dojel

call compile format["casy_%1 = casy_%1 + [[""%2"",""%3""]];publicVariable ""casy_%1"";",CELO_JEDU_FAZI,name player,_dojel_v_case];
call compile format["0 spawn {waitUntil {preloadCamera getpos CELO_etapa_preload%1;};};",CELO_JEDU_FAZI];
sleep 2;
_null = [] execVM "sqf\ukaz_vysledky.sqf";