if !surface_exists(groundSurface) {
	groundSurface = surface_create(room_width, room_height)	
	
	surface_set_target(groundSurface)
	draw_clear_alpha(c_black, 0)
	
	surface_reset_target()
}

else {

	var surface = surface_create(room_width, room_height)
	
	surface_set_target(surface)
	
	////	WIP CAUSTIC
	shader_set(shader_caustic)
	var Width = window_get_width()
	var Height = window_get_height()
	shader_set_uniform_f(caustic_resolution, Width, Height)
	shader_set_uniform_f(caustic_seconds, sec)

	draw_rectangle(0,0,Width,Height,false)
	
	shader_reset()
	
	surface_reset_target()
	
	surface_set_target(groundSurface)
	
	var Layer = layer_tilemap_get_id(layer_get_id("Tiles_1"))
	//draw_tilemap(Layer, 0,0)
	
	draw_set_alpha(0.20)
	draw_surface(surface,0,0)
	draw_set_alpha(1)
	
	surface_reset_target()
	
	surface_free(surface)
	
	draw_surface(groundSurface,0,0)
	
	//surface_free(groundSurface)
	
}

//if instance_exists(player) with player {
//	depth = -y
//	draw_self()	
//}

//if instance_exists(seaweed) with seaweed {
//	depth = -y
//	draw_self()	
//}

//draw_set_alpha(0.25)
//draw_set_color(c_blue)
//draw_rectangle(0,0,room_width,room_height,false)
//draw_reset()