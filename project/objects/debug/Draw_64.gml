if on {
	
	var XX = 15
	var YY = 15
	draw_set_color(c_black)
	
	draw_text(XX,YY, "mouse_x: "+string(mouse_x)) YY += 15
	draw_text(XX,YY, "mouse_y: "+string(mouse_y)) YY += 15
	
	with player {
		draw_text(XX,YY, "x: "+string(x)) YY += 15
		draw_text(XX,YY, "y: "+string(y)) YY += 15
		draw_text(XX,YY, "z: "+string(z)) YY += 15
		draw_text(XX,YY, "map: "+string(map)) YY += 15
		draw_text(XX,YY, "groundX: "+string(groundX)) YY += 15
		draw_text(XX,YY, "groundY: "+string(groundY)) YY += 15
		draw_text(XX,YY, "moveForce: "+string(moveForce)) YY += 15
	}
	
	
	////	GUI buttons
	//	Suit on/off
	var _string = "off"	if app.suitOn _string = "on"
	var clicked = draw_button_ext(display_get_gui_width()-128-8,8, 128,64, "suit: "+_string) 
	if clicked {
		app.suitOn = !app.suitOn
		if instance_exists(player) player.suitOn = app.suitOn
	}
	
	//	GUI on/off
	var _string = "off"	if gui.drawGold _string = "on"
	var clicked = draw_button_ext(display_get_gui_width()-128-8,80, 128,64, "gui: "+_string) 
	if clicked {
		gui.drawGold = !gui.drawGold
	}
	
	draw_reset()
	
}