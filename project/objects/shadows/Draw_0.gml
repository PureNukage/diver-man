if !surface_exists(surface) {
	surface = surface_create(room_width, room_height)	
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	surface_reset_target()
}

if surfaceBuffer > -1 and buffer_exists(surfaceBuffer) {
	var Surface = surface_create(room_width, room_height)
	surface_set_target(Surface)
	draw_clear_alpha(c_white, 0)
	surface_reset_target()
	draw_set_alpha(0.5)
	buffer_set_surface(surfaceBuffer,Surface,0)
	draw_surface(Surface,0,0)
	surface_free(Surface)
}

if instance_exists(mainmenu2) with mainmenu2 {
	draw_set_alpha(1)
	if surface_exists(surface) draw_surface(surface,0,0)
	other.generate_map()
}