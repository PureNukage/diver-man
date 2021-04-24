if surface_exists(surface) {
	//debug.log("shadow alpha: "+string(draw_get_alpha()))
	draw_surface(surface,0,0)
}

if (instance_exists(mainmenu) and room == RoomMainMenu) with mainmenu  {
	draw_set_alpha(1)
	if surface_exists(surface) draw_surface(surface,0,0)
	other.generate_map()
}

draw_reset()