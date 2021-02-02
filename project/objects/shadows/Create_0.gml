surface = -1
surfaceBuffer = -1
depth = -1

function generate_map() {
	var amountOfShades = 0
	var surfaceArray = []
	
	var shadeList = ds_list_create()
	
	//	Grab the amount of different shade values we have in the room
	if instance_exists(shade) with shade {
		if !ds_list_find_index(shadeList, darkness) {
			ds_list_add(shadeList, darkness)
			amountOfShades++
		}
	}
	
	//	Make a surface for each value of shade and draw the equivalent shadows to it
	for(var i=0;i<amountOfShades;i++) {
		var Darkness = shadeList[| i]
		var Surface = surface_create(room_width, room_height)	
		surface_set_target(Surface)
		draw_clear_alpha(c_white, 0)
		
		if instance_exists(shade) with shade if darkness == Darkness {
			draw_sprite_ext(s_shade, image_index, x,y, image_xscale,image_yscale, image_angle, image_blend, 1)		
		}
		
		surface_reset_target()
		surfaceArray[i] = Surface
	}
	
	if surfaceBuffer > -1 and buffer_exists(surfaceBuffer) buffer_delete(surfaceBuffer)
	
	surfaceBuffer = buffer_create(room_width*room_height*4,buffer_grow,1)
	
	//	Lets finish this by drawing all the different surfaces in their respective shade values on one surface
	if surface > -1 and surface_exists(surface) surface_free(surface)
	surface = surface_create(room_width, room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_white, 0)
	
	for(var i=0;i<amountOfShades;i++) {
		var Darkness = shadeList[| i]
		var Surface = surfaceArray[i]
		draw_surface_ext(Surface,0,0,1,1,0,c_white,Darkness)
		surface_free(Surface)
	}
	
	//	Shift shadows for collisionMaps up
	if instance_exists(collisionMap) with collisionMap if rock == -1 {
		var x1 = bbox_left
		var y1 = bbox_top+z
		var x2 = bbox_right
		var y2 = bbox_bottom
		//	Create copy of shadow 
		var mapSurface = surface_create(x2-x1,y2-y1)
		surface_copy_part(mapSurface,0,0,shadows.surface,x1,y1,x2-x1,y2-y1)
		//	Clear entire collisionMap from shadow surface
		surface_set_target(shadows.surface)
		gpu_set_blendmode(bm_subtract)
		var cliffSurface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
		buffer_set_surface(surfaceBuffer,cliffSurface,0)
		draw_surface_ext(cliffSurface,x,y,1,1,0,c_black,1)
		gpu_set_blendmode(bm_normal)
		//	Paste our copy back in but shifted up z
		draw_surface(mapSurface,bbox_left,bbox_top)
		surface_reset_target()
		surface_free(mapSurface)
	}
	
	//	Main menu shadow text
	if instance_exists(mainmenu) with mainmenu {
		draw_set_alpha(1)
		if surface_exists(surface) draw_surface(surface,0,0)	
	}
	
	surface_reset_target()
	
	//	Store surface 
	buffer_get_surface(surfaceBuffer,surface,0)
	
	surface_free(surface)
	ds_list_destroy(shadeList)

}

generate_map()