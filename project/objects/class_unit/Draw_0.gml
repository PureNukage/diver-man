if drawShadow draw_shadow()

if drawUnit draw_unit()

if interactable {
	var xx = x 
	var yy = y-(sprite_get_yoffset(sprite_index)*image_yscale)-z
	
	if object_index == cage {
		yy = y - 100		
	}
	else if object_index == mudcrab_lost {
		yy = bbox_top - 35 - z
	}
	
	interactableY = yy
	
	var Sprite = s_keyboard_e
	if input.keyboardOrController == 1 Sprite = s_controller_xbox_y
	draw_sprite_ext(Sprite,0,xx,yy,2,2,0,c_white,1)
}
else {
	interactableY = y-z
}