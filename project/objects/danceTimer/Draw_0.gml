if debug.on {
	draw_set_alpha(1)
	draw_set_color(c_black)
	draw_text(playerDance.x,playerDance.y-70,string(timer) + "/3600")	
}

//	Draw the player
if stage > 1 draw_sprite_ext(player.sprite_index,player.image_index,player.x,player.y,player.image_xscale,player.image_yscale,player.image_angle,player.image_blend,player.image_alpha)

if stage == 3 {
	draw_sprite_ext(s_bully2,player.image_index,577,254,1,1,0,c_white,1)	
	draw_sprite_ext(s_bully1,player.image_index,535,254,1,1,0,c_white,1)	
}