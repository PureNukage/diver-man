function check_room_underwater() {
	
	//	list of underwater rooms
	var list = ds_list_create() 
	ds_list_add(list, Room1)
	ds_list_add(list, RoomMainMenu)
	
	//	This room is underwater
	if ds_list_find_index(list, room) > -1 {
		app.underwaterChange(true)
		
		//	Lets make sure the player has his suit on
		if instance_exists(player) and !app.suitOn {
			app.suitOn = true
			player.suitOn = app.suitOn
		}
	}
	// This room is NOT underwater
	else {
		app.underwaterChange(false)
		
		//	Lets make sure the player does NOT have his suit on
		if instance_exists(player) and app.suitOn {
			app.suitOn = false
			player.suitOn = app.suitOn
		}
	}
	
	ds_list_destroy(list)

}

on = false

application_surface_draw_enable(false)

q_seconds = shader_get_uniform(shader_quake, "iTime")

caustic_resolution = shader_get_uniform(shader_caustic, "iResolution")

caustic_seconds = shader_get_uniform(shader_caustic, "iTime")

causticSurfaceOriginal = -1
causticSurface = -1

cliffSurface = -1

sec = 0

causticBuffer = -1
function generate_caustic_map() {
	var Surface = surface_create(room_width, room_height)
	surface_set_target(Surface)
	draw_clear_alpha(c_white, 0)
	
	draw_set_alpha(1)
	draw_set_color(c_black)
	
	if instance_exists(collisionMap) with collisionMap {
		//var y1 = bbox_bottom - z
		//var y2 = bbox_bottom
		//raw_rectangle(bbox_left,y1,bbox_right,y2,false)
		
		var mapSurface = surface_create(sprite_get_width(sprite_index)* image_xscale,sprite_get_height(sprite_index)*image_yscale)
		surface_reset_target()
		surface_set_target(mapSurface)
		draw_clear_alpha(c_white, 0)
		surface_reset_target()
		surface_set_target(Surface)
		
		buffer_set_surface(surfaceBuffer,mapSurface,0)
		
		draw_surface_ext(mapSurface,x,y,1,1,0,c_black,1)
		
		//	Cleanup the top so only the cliff remains
		gpu_set_blendmode(bm_subtract)
		draw_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom-z,false)
		gpu_set_blendmode(bm_normal)
		
		surface_free(mapSurface)
	}
	
	surface_reset_target()
	
	if causticBuffer > -1 and buffer_exists(causticBuffer) buffer_delete(causticBuffer)
	
	causticBuffer = buffer_create(room_width*room_height*4,buffer_grow,1)
	buffer_get_surface(causticBuffer,Surface,0)
	
	//surface_save(Surface,"causticMap.png")
	
	surface_free(Surface)
}

heightMapCount = -1
heightMaps = [[]]
collisionMapsBuffer = -1
collisionMapsSurface = -1
function generate_collision_maps() {
	
	//	Clear out existing map buffers if we have any 
	for(var i=0;i<heightMapCount;i++) {
		if buffer_exists(heightMaps[i][1]) buffer_delete(heightMaps[i][1])
	}
	
	//	how many z-level does this room have?
	var z_list = ds_list_create()
	if instance_exists(collisionMap) with collisionMap {
		if ds_list_find_index(z_list,z) == -1 ds_list_add(z_list,z)
	}
	heightMapCount = ds_list_size(z_list)
	
	//	Create the inverse height maps
	for(var i=0;i<heightMapCount;i++) {
		var Z = z_list[| i]
		var surface = surface_create(room_width, room_height)
		surface_set_target(surface) 
		draw_clear_alpha(c_black, 0)
		
		draw_set_alpha(1)
		draw_set_color(c_black)
		draw_rectangle(0,0,room_width,room_height,false)
		
		gpu_set_blendmode(bm_subtract)
		if instance_exists(collisionMap) with collisionMap if z == Z {
			var Surface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
			buffer_set_surface(surfaceBuffer,Surface,0)
			draw_surface_ext(Surface,x,y,1,1,0,c_black,1)
			surface_free(Surface)
		}
		gpu_set_blendmode(bm_normal)
		
		//	Draw the cliffs since we don't want to have shadows on those
		if instance_exists(collisionMap) with collisionMap if z == Z {
			draw_rectangle(bbox_left,bbox_bottom-z,bbox_right,bbox_bottom,false)
		}
		
		surface_reset_target()
		
		//	Store this surface in our z-level array
		heightMaps[i][1] = buffer_create(room_width*room_height*4,buffer_grow,1)
		buffer_get_surface(heightMaps[i][1],surface,0)
		heightMaps[i][0] = Z
		heightMaps[i][2] = -1
		
		//surface_save(surface,"inverseHeightMap"+string(Z)+".png")
		
		surface_free(surface)
	}
	
	////	Create map of all cliffs, used for the base shadow
	var surface = surface_create(room_width, room_height)
	surface_set_target(surface) 
	draw_clear_alpha(c_black, 0)
	
	if instance_exists(collisionMap) with collisionMap {
		var Surface = surface_create(sprite_get_width(sprite_index)*image_xscale,sprite_get_height(sprite_index)*image_yscale)
		buffer_set_surface(surfaceBuffer,Surface,0)
		
		draw_surface_ext(Surface,x,y,1,1,0,c_black,1)
		
		surface_free(Surface)
	}
	surface_reset_target()
	
	if collisionMapsBuffer > -1 and buffer_exists(collisionMapsBuffer) buffer_delete(collisionMapsBuffer)
	if surface_exists(collisionMapsSurface) surface_free(collisionMapsSurface)
	collisionMapsBuffer = buffer_create(room_width*room_height*4,buffer_grow,1)
	buffer_get_surface(collisionMapsBuffer,surface,0)
	
	//surface_save(surface, "collisionMapsSurface.png")
	
	surface_free(surface)	
	
	ds_list_destroy(z_list)
}