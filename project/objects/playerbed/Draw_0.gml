event_inherited()

if !filled drawUnit = true
//	The player is in bed
else {
	drawUnit = false
	//	Drawing the pillow
	draw_sprite_part(sprite_index,0,0,0,sprite_get_width(sprite_index),20,x,y)
	
	//	Drawing the player
	draw_sprite_ext(player.sprite_index,0,x+22,y+60,player.image_xscale,player.image_yscale,player.image_angle,player.image_blend,player.image_alpha)
	
	//	Draw the blanket
	draw_sprite_part(sprite_index,0,0,20,sprite_get_width(sprite_index),60,x,y+24)
	
}