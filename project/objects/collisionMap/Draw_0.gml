if drawSurface {
	var surface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	buffer_set_surface(surfaceBuffer, surface, 0)
	draw_surface(surface, x,y)
	
	////	Create cookie cutter from surface
	var cookieCut = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	surface_set_target(cookieCut)
	draw_clear_alpha(c_black, 0)
	
	draw_set_alpha(1)
	draw_set_color(c_black)
	draw_rectangle(0,0,sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale,false)
	
	gpu_set_blendmode(bm_subtract)
	draw_surface_ext(surface,0,0,1,1,0,c_black,1)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	var causticSurf = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	surface_set_target(causticSurf)
	draw_clear_alpha(c_black, 0)
	surface_reset_target()
	
	surface_copy_part(causticSurf,0,0, water.causticSurface,x,y,sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	surface_set_target(causticSurf)
	
	gpu_set_blendmode(bm_subtract)
	draw_surface_ext(cookieCut,0,0,1,1,0,c_black,1)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	with particle if particles == particles.footprint if z > 0 {
		draw_self()
	}
	
	draw_set_alpha(0.15)
	draw_surface(causticSurf,x,y)
	
	draw_reset()
	
	surface_free(surface)
	surface_free(cookieCut)
	surface_free(causticSurf)
}