//if (instance_exists(player) and place_meeting(x,y,player) and player.groundY <= y+z)
////or (instance_exists(player) and player.falling)
//or drawSurface {
//	if player.map != id {
//		var surface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
//		buffer_set_surface(surfaceBuffer, surface, 0, 0, 0)
//		draw_surface(surface,x,y)
//		if surface_exists(surface) surface_free(surface)
		
//		//gpu_set_blendmode(bm_subtract)
//		//draw_surface_part(water.groundSurface, 0,0, sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16, x,y)
//		//gpu_set_blendmode(bm_normal)
//	}
//}



//if drawSurface {
//	var xscale = image_xscale
//	var yscale = image_yscale
//	image_xscale = 1
//	image_yscale = 1
//	draw_self()
//	image_xscale = xscale
//	image_yscale = yscale
//}