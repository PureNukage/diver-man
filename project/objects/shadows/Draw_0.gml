if !surface_exists(surface) {
	surface = surface_create(room_width, room_height)	
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	surface_reset_target()
}

if surface_exists(surface) {

	surface_set_target(surface)

	if instance_exists(shade) with shade {
		draw_sprite_ext(s_shade, image_index, x,y, image_xscale,image_yscale, image_angle, image_blend, image_alpha)	
	}

	surface_reset_target()
	
	draw_set_alpha(0.5)
	draw_surface(surface,0,0)
	
	//surface_free(surface)
	
	draw_reset()
	
}