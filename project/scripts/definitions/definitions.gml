#macro mouse_gui_x device_mouse_x_to_gui(0)
#macro mouse_gui_y device_mouse_y_to_gui(0)

#macro animation_end (image_index > image_number - 1)

#macro up 0
#macro right 1
#macro down 2
#macro left 3

#macro mode_DEBUG 0
#macro mode_PRODUCTION 1

enum particles {
	bubble,
	footprint,
	jellyfish,
	dustpoof,
}

enum state {
	free,
	walk,
	stunned,
	flee,
	attack
}

enum item {
	sandwich,
	watch,
}

enum treasure {
	gold,
	gold_necklace,	
}

enum menu {
	main,
	settings,
}

enum characters {
	brother,	
}

enum quests {
	intro,
	spendFinalCoin,
	streetDance,
	watch,
	necklace,
}

enum cutscene {
	coupleComingOffBoat,
}