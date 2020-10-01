if on {

	if !surface_exists(groundSurface) {
		groundSurface = surface_create(room_width, room_height)	
	
		surface_set_target(groundSurface)
		draw_clear_alpha(c_black, 0)
	
		surface_reset_target()
	}

	var surface = surface_create(room_width, room_height)
	
	surface_set_target(surface)
	
	////	WIP CAUSTIC
	shader_set(shader_caustic)
	var Width = room_width
	var Height = room_height
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
	
	if instance_exists(collisionMap) with collisionMap if drawSurface {
		//if player.map != id {
			var surface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
			buffer_set_surface(surfaceBuffer, surface, 0, 0, 0)		
			draw_surface(surface,x,y)
			if surface_exists(surface) surface_free(surface)
		//}	
	}
	
	with particle if particles == particles.footprint if z > 0 {
		draw_self()	
	}
	
	draw_surface(groundSurface,0,0)
}
	
	