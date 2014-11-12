private "_name","_kills","_killsH","_killsB","_humanitydb","_headShots","_pic";
toggle_debug = {
	if (custom_monitor) then {
		custom_monitor = false;
		titleText ["Debug Box OFF","PLAIN DOWN"]; titleFadeOut 4;
		hintSilent "";
	} else {
		custom_monitor = true;
		titleText ["Debug Box ON","PLAIN DOWN"]; titleFadeOut 4;
		[] spawn debugstart;
	};
};

END_KEY = (findDisplay 46) displayAddEventHandler ["KeyDown","if ((_this select 1) == 76) then {call toggle_debug;}"];

debugstart = {
	while { (custom_monitor && !isDedicated) } do 
	{
		_name = if (alive player) then {name player;} else {"Dead Player";};
		_kills =		player getVariable["zombieKills",0];
		_killsH =		player getVariable["humanKills",0];
		_killsB =		player getVariable["banditKills",0];
		_humanitydb =	player getVariable["humanity",0];
		_headShots =	player getVariable["headShots",0];
		_pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));
		if (player == vehicle player) then
		{
			_pic = (gettext (configFile >> 'cfgWeapons' >> (currentWeapon player) >> 'picture'));	
		}
		else
		{
			_pic = (gettext (configFile >> 'CfgVehicles' >> (typeof vehicle player) >> 'picture'));	
		};

		hintSilent parseText format
		["
			<br/>
			<t	size='1.20' font='Bitstream'	align='center'		color='#00FF00'	>%1 survived %14 Days</t><br/>
			<t	size='1.15' font='Bitstream'	align='center'		color='#00FF00' >%2 Player online</t><br/>
			<img size='6' image='%3'/><br/>
			<t	size='1' font='Bitstream'		align='left'		color='#00FF00'	>Humanity:</t>				<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%4</t><br/>
			<t	size='1' font='Bitstream'		align='left'		color='#00FF00'	>Headshots:</t>				<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%5</t><br/>
			<t	size='1' font='Bitstream'		align='left' 		color='#FFFF00'	>Killed Heroes:</t>			<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%6</t><br/>
			<t	size='1' font='Bitstream'		align='left' 		color='#FFFF00'	>Killed Bandits:</t>		<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%7</t><br/>
			<t	size='1' font='Bitstream'		align='left'		color='#FFFF00'	>Killed Zombies:</t>		<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%8</t><br/>
			<t	size='1' font='Bitstream'		align='left' 		color='#FF0000'	>Zombies (alive/total):</t>	<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%9/%10</t><br/>
			<t	size='1' font='Bitstream'		align='left' 		color='#FF0000'	>Blood:</t>					<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%11</t><br/>
			<t	size='1' font='Bitstream'		align='left' 		color='#FF0000'	>FPS:</t>					<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%12</t><br/>
			<t	size='1' font='Bitstream'		align='left' 		color='#FF0000'	>Restart:</t>				<t size='1' font='Bitstream' align='right' color='#FFFFFF'>%13</t><br/><br/>
			<t size='1' font='Bitstream'align='center'color='#0095DD'>fb.com/zockerparty</t><br/>
			<t size='1' font='Bitstream'align='center'color='#FF0000'>TS3 </t><t size='1'font='Bitstream'align='center'color='#0095DD'>teamwb.noip.me</t><br/>
			<t size='1' font='Bitstream'align='center'color='#000000'>Use NUM5 to Toggle</t><br/>

			",
			(_name),									// 1
			(count playableUnits), 						// 2
			(_pic),										// 3
			(round _humanitydb),						// 4
			(_headShots),								// 5
			(_killsH),									// 6
			(_killsB),									// 7
			(_kills),									// 8
			({alive _x} count entities "zZombie_Base"),	// 9
			(count entities "zZombie_Base"),			// 10
			(r_player_blood),							// 11
			(round diag_FPS),							// 12
			(240-(round(serverTime/60))),				// 13 - change the 240 to suit your server mins for restarts
			(dayz_Survived)								// 14

		]; 
	sleep 2;
	};
};
[] spawn debugstart;
