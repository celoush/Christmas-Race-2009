// --- SKRIPT NA RESPAWN ---
_mrtvola = _this select 0;
sleep 0.1;
waitUntil {alive player};
_mrtvola RemoveEventHandler ["killed", CELO_EH_respawn];
_null = 0 execVM "sqf\addaction.sqf";
CELO_EH_respawn = player addeventhandler ["killed",{_this exec "sqf\respawn.sqf"}];
