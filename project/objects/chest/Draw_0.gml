if highlight {
	//shader_set(shader_flash)
	draw_sprite_ext(sprite_index,image_index,x,y,1.25,1.25,image_angle,image_blend,0.25)	
	//shader_reset()

	
}

//draw_unit()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)