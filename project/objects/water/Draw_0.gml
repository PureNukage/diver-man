if on {

	if !surface_exists(causticSurface) {
		causticSurface = surface_create(room_width, room_height)	
	
		surface_set_target(causticSurface)
		draw_clear_alpha(c_black, 0)
	
		surface_reset_target()
	}

	var surface = surface_create(room_width, room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	////	WIP CAUSTIC
	shader_set(shader_caustic)
	var Width = room_width
	var Height = room_height
	shader_set_uniform_f(caustic_resolution, Width, Height)
	shader_set_uniform_f(caustic_seconds, sec)

	draw_rectangle(0,0,Width,Height,false)
	
	shader_reset()
	
	surface_reset_target()
	
	surface_set_target(causticSurface)
	
	//var Layer = layer_tilemap_get_id(layer_get_id("Tiles_1"))
	//draw_tilemap(Layer, 0,0)
	
	draw_set_alpha(1)
	draw_surface(surface,0,0)
	
	surface_reset_target()
	
	if !surface_exists(causticSurfaceOriginal) {
		causticSurfaceOriginal = surface_create(room_width,room_height)	
	}
	surface_copy(causticSurfaceOriginal,0,0,surface)
	surface_free(surface)
	
	with particle if particles == particles.footprint if z > 0 {
		draw_self()	
	}
	
	draw_set_alpha(0.25)
	draw_surface(causticSurface,0,0)
}
	
	