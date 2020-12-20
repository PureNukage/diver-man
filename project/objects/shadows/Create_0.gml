surface = -1
surfaceBuffer = -1
depth = -1

function generate_map() {
	var amountOfShadows = instance_number(shade)
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
	
	//	Main menu shadow text
	if instance_exists(mainmenu2) with mainmenu2 {
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