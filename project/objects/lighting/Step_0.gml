if !surface_exists(surface) {
	
	surface = surface_create(room_width,room_height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	surface_reset_target()
}

surface_set_target(surface)


draw_set_alpha(darkness)

draw_rectangle(0,0,room_width,room_height,false)


//	Punch out light
gpu_set_blendmode(bm_subtract)

if instance_exists(class_light) with class_light {
	draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,c_black,image_alpha)	
}

gpu_set_blendmode(bm_normal)

//	Shade
if instance_exists(shade) with shade {
	draw_rectangle(x,y,x+sprite_get_width(sprite_index)*image_xscale,y+sprite_get_height(sprite_index)*image_yscale,false)	
}

surface_reset_target()