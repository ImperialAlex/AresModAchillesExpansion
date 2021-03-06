////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	AUTHOR: Kex
//	DATE: 1/13/16
//	VERSION: 1.0
//  DESCRIPTION: Function for the module "change altitude"
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#include "\achilles\modules_f_ares\module_header.hpp"

_objects = [[_logic, false] call Ares_fnc_GetUnitUnderCursor];

_dialogResult = 
[
	localize "STR_CHANGE_ALTITUDE",
	[
		[(localize "STR_Altitude_ASL_ATL") + " [m]", "","0"]
	]
] call Ares_fnc_ShowChooseDialog;

if (count _dialogResult == 0) exitWith {};
_height = parseNumber (_dialogResult select 0);

if (isNull (_objects select 0)) then
{
	_objects = [localize "STR_OBJECTS"] call Achilles_fnc_SelectUnits;
};
if (isNil "_objects") exitWith {};
if (count _objects == 0) exitWith {[localize "STR_NO_OBJECT_SELECTED"] call Ares_fnc_ShowZeusMessage; playSound "FD_Start_F"};;
{
	[_x,_height] spawn 
	{
		params ["_object","_height"];
		if (_object isKindOf "Air") exitWith
		{
			if (local _object) then {_object flyInHeight _height} else {[_object,_height] remoteExec ["flyInHeight",_object]};
		};
		if (_object isKindOf "Ship") exitWith
		{
			if (local _object) then {_object swimInDepth _height} else {[_object,_height] remoteExec ["swimInDepth",_object]};
		};
	};
} forEach _objects;


#include "\achilles\modules_f_ares\module_footer.hpp"