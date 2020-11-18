draw_unit()

if interactable {
	var xx = x 
	var yy = y - (sprite_get_height(sprite_index)/2) - 25	
	
	draw_sprite_ext(s_keyboard_e,0,xx,yy,2,2,0,c_white,1)
	//draw_set_color(c_white)
	//draw_set_halign(fa_center)
	//draw_set_valign(fa_middle)
	//draw_text(xx,yy,"E")
}