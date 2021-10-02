cfg = {}

cfg.UtiliserSystemeDePoids = true
cfg.DoubleJob = false

cfg.HUD = {
	UtiliserTrigger = false,
	Trigger = "tontrigger",
	Commande = "hud"
}

cfg.DefBase = {
	ESX = "esx:getSharedObject",
	ArgentSociete = "esx_society:getSocietyMoney",
}

cfg.Controls = {
	HandsUP = {clavier = 243},
	Pointing = {clavier = 29},
	Crouch = {clavier = 36},
	StopTasks = {clavier = 73},
}

cfg.UtiliserTouches = true
cfg.Touches = { 
    {Nom = "Inventaire", Touche = "F5"},
    {Nom = "Téléphone", Touche = "F1"},
}

cfg.demarches = { 
    {Nom = "Normal homme", Arg1 = "move_m@confident", Arg2 ="move_m@confident"},
	{Nom = "Normal femme", Arg1 = "move_f@heels@c", Arg2 ="move_f@heels@c"},
	{Nom = "Depressif homme", Arg1 = "move_m@depressed@a", Arg2 ="move_m@depressed@a"},
	{Nom = "Depressif femme", Arg1 = "move_f@depressed@a", Arg2 ="move_f@depressed@a"},
	{Nom = "Business", Arg1 = "move_m@business@a", Arg2 ="move_m@business@a"},
	{Nom = "Determiné", Arg1 = "move_m@brave@a", Arg2 ="move_m@brave@a"},
	{Nom = "Casual", Arg1 = "move_m@casual@a", Arg2 ="move_m@casual@a"},
	{Nom = "Trop mangé", Arg1 = "move_m@fat@a", Arg2 ="move_m@fat@a"},
	{Nom = "Hipster", Arg1 = "move_m@hipster@a", Arg2 ="move_m@hipster@a"},
	{Nom = "Blessé", Arg1 = "move_m@injured", Arg2 ="move_m@injured"},
	{Nom = "Intimidé", Arg1 = "move_m@hurry@a", Arg2 ="move_m@hurry@a"},
	{Nom = "Hobo", Arg1 = "move_m@hobo@a", Arg2 ="move_m@hobo@a"},
	{Nom = "Malheureux", Arg1 = "move_m@sad@a", Arg2 ="move_m@sad@a"},
	{Nom = "Muscle", Arg1 = "move_m@muscle@a", Arg2 ="move_m@muscle@a"},
	{Nom = "Choc", Arg1 = "move_m@shocked@a", Arg2 ="move_m@shocked@a"},
	{Nom = "Sombre", Arg1 = "move_m@shadyped@a", Arg2 ="move_m@shadyped@a"},
	{Nom = "Fatigue", Arg1 = "move_m@buzzed", Arg2 ="move_m@buzzed"},
	{Nom = "Fier", Arg1 = "move_m@money", Arg2 ="move_m@money"},
	{Nom = "Petite course", Arg1 = "move_m@quick", Arg2 ="move_m@quick"},
	{Nom = "Mangeuse d'homme", Arg1 = "move_f@maneater", Arg2 ="move_f@maneater"},
}

cfg.GPS = {
	{Nom = 'Aucun', Coo = nil},
	{Nom = 'Poste de Police', Coo = vector2(425.13, -979.55)},
	{Nom = 'Garage Central', Coo = vector2(-449.67, -340.83)},
	{Nom = 'Hôpital', Coo = vector2(-33.88, -1102.37)},
	{Nom = 'Concessionnaire', Coo = vector2(215.06, -791.56)},
	{Nom = 'Benny\'s Custom', Coo = vector2(-212.13, -1325.27)},
	{Nom = 'Pôle Emploie', Coo = vector2(-264.83, -964.54)},
	{Nom = 'Auto école', Coo = vector2(-829.22, -696.99)},
	{Nom = 'Téquila-la', Coo = vector2(-565.09, 273.45)},
	{Nom = 'Bahama Mamas', Coo = vector2(-1391.06, -590.34)}
}

cfg.Props = {
	UtiliserMenuProps = true,

	UtiliserEMS = true,
	NomJobEMS = 'ambulance',

	UtiliserMecano = true,
	NomJobMecano = 'mechanic',

	UtiliserGang = true,
	UtiliserJob2 = false,

}



