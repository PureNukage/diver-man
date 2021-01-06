if !app.underwater {
	var surface = surface_create(room_width, room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	draw_sprite(s_chain2,0,x,y-z-64)
	draw_sprite(s_chain2,0,x,y-z-sprite_get_height(s_chain2))
	
	gpu_set_blendmode(bm_subtract)
	draw_rectangle(0,0,room_width,crane.y-81,false)
	gpu_set_blendmode(bm_normal)
	
	surface_reset_target()
	
	draw_surface(surface,0,0)
	
	surface_free(surface)
}
else {
	draw_sprite(s_chain2,0,x,y-z-64)
}

if !inUse {
	//drawUnit = true
	//draw_unit()
} else {
	drawUnit = false
	lift(liftDirection)
}

event_inherited()