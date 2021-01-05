if drawSurface and surface_exists(surface) {
	
	//	Only do this if we're in camera
	if rectangle_in_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom, app.cameraX1,app.cameraY1,app.cameraX2,app.cameraY2) {
		draw_surface(surface, x,y)
	
		var causticSurf = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
		surface_set_target(causticSurf)
		draw_clear_alpha(c_black, 0)
	
		if surface_exists(water.causticSurface) surface_copy_part(causticSurf,0,0, water.causticSurface,x,y,sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
	
		if surface_exists(cookieSurface) {
			gpu_set_blendmode(bm_subtract)
			draw_surface_ext(cookieSurface,0,0,1,1,0,c_black,1)
			gpu_set_blendmode(bm_normal)
		}
	
		surface_reset_target()
	
		with particle if particles == particles.footprint if z == other.z {
			draw_self()
		}
	
		draw_set_alpha(0.15)
		draw_surface(causticSurf,x,y)
		
		//	Draw shadow
		if surface_exists(shadows.surface) {
			if rock == -1 draw_surface_part(shadows.surface,bbox_left,bbox_top,bbox_right-bbox_left,(bbox_bottom-z)-bbox_top,bbox_left,bbox_top)
		}
	
		draw_reset()
	
		surface_free(causticSurf)
	}
}