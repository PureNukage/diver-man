draw_unit()

if interactable {
	var xx = x 
	var yy = y - (sprite_get_height(sprite_index)/2) - 25	
	
	var Sprite = s_keyboard_e
	if input.keyboardOrController == 1 Sprite = s_controller_xbox_y
	draw_sprite_ext(Sprite,0,xx,yy,2,2,0,c_white,1)
}