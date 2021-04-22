if drawSurface and surface_exists(surface) {
	
	//	Only do this if we're in camera
	if rectangle_in_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom, app.cameraX1,app.cameraY1,app.cameraX2,app.cameraY2) {
		draw_surface(surface, x,y)
	
		with particle if particles == particles.footprint if z == other.z {
			draw_self()
		}
		
		//	Draw shadow
		if surface_exists(shadows.surface) {
			if rock == -1 draw_surface_part(shadows.surface,bbox_left,bbox_top,bbox_right-bbox_left,(bbox_bottom-z)-bbox_top,bbox_left,bbox_top)
		}
	
		draw_reset()
	
	}
}