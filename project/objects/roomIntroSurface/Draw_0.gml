if surface_exists(surface) and room == RoomCityHub {
	var _surface = surface_create(room_width,room_height)
	surface_set_target(_surface)
	draw_clear_alpha(c_black, 0)
	
	var loops = ceil((720 - surfaceX) / 720)
	var _x = surfaceX
	for(var i=0;i<loops;i++) {
		draw_surface(surface,_x,0)
		_x += 720
	}
	
	gpu_set_blendmode(bm_subtract)
	draw_rectangle(720,0,room_width,room_height,false)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	draw_surface(_surface,0,0)
	
	surface_free(_surface)
	
	draw_reset()
}