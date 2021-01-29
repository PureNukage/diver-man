debug.log(sprite_get_name(playerShadow.sprite_index))
debug.log(sprite_get_name(brotherShadow.sprite_index))

if gap < gapMax {
	brotherShadow.sprite_index = s_brother_walk	
}
else {
	brotherShadow.sprite_index = s_kid_crutch	
}

if stage == 1 and playerShadow.sprite_index != s_kid_player_walk {
	playerShadow.sprite_index = s_kid_player_walk	
}

draw_sprite_ext(playerShadow.sprite_index,playerShadow.image_index, x,y, 1,1,0, image_blend,image_alpha)

draw_sprite_ext(brotherShadow.sprite_index,brotherShadow.image_index, x+96 + gap,y, 1,1,0, image_blend,image_alpha)