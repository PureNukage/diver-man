if drawShadow draw_shadow()

if drawUnit draw_unit()

if interactable {
	var xx = x 
	var yy = y-sprite_get_yoffset(sprite_index)	
	
	draw_sprite_ext(s_keyboard_e,0,xx,yy,2,2,0,c_white,1)
}