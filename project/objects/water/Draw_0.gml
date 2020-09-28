if !surface_exists(groundSurface) {
	groundSurface = surface_create(room_width, room_height)	
	
	surface_set_target(groundSurface)
	draw_clear_alpha(c_black, 0)
	
	surface_reset_target()
}

//else {

	var surface = surface_create(room_width, room_height)
	
	surface_set_target(surface)
	
	////	WIP CAUSTIC
	shader_set(shader_caustic)
	var Width = room_width
	var Height = room_height
	shader_set_uniform_f(caustic_resolution, Width, Height)
	shader_set_uniform_f(caustic_seconds, sec)

	draw_rectangle(0,0,Width,Height,false)
	
	//	check for collisionMap collisions
	//var yes = false
	//if instance_exists(collisionMap) with collisionMap if drawSurface yes = true
	
	//if yes {
	//	gpu_set_blendmode(bm_subtract)
	//	draw_sprite_ext(player.sprite_index,player.image_index,player.x,player.y,player.image_xscale,player.image_yscale,player.image_angle,c_black,player.image_alpha)
	//	gpu_set_blendmode(bm_normal)	
	//}
	
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
		if player.map != id {
			var surface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
			buffer_set_surface(surfaceBuffer, surface, 0, 0, 0)
			
			//gpu_set_blendmode(bm_subtract)
			//draw_sprite_ext(player.sprite_index,player.image_index,player.x,player.y,player.image_xscale,player.image_yscale,player.image_angle,c_black,player.image_alpha)
			//gpu_set_blendmode(bm_normal)
			
			draw_surface(surface,x,y)
			if surface_exists(surface) surface_free(surface)
		}	
	}
	
	with particle if particles == particles.footprint if z > 0 {
		draw_self()	
	}
	
	draw_surface(groundSurface,0,0)
	
	//if instance_exists(collisionMap) with collisionMap if drawSurface {
	//	if player.map != id {
	//		var surface = surface_create(sprite_get_width(sprite_index)*image_xscale, sprite_get_height(sprite_index)*image_yscale + 16)
	//		buffer_set_surface(surfaceBuffer, surface3, 0, 0, 0)
	//		draw_surface(surface,x,y)
	//		if surface_exists(surface) surface_free(surface)
	//	}	
	//}
	
	//surface_free(groundSurface)
	
//}

//if instance_exists(player) with player {
//	depth = -y
//	draw_self()	
//}

//if instance_exists(seaweed) with seaweed {
//	depth = -y
//	draw_self()	
//}