if on {
	
	var XX = 15
	var YY = 15
	draw_set_color(c_black)
	
	//draw_text(XX,YY,"selected_unit: "+string(selected_unit)) YY += 15
	//if selected_unit > -1 {
	//	draw_text(XX,YY,string_upper(object_get_name(selected_unit.object_index))) YY += 15
	//}
	//draw_text(XX,YY, "mouse_x: "+string(mouse_x)) YY += 15
	//draw_text(XX,YY, "mouse_y: "+string(mouse_y)) YY += 15
	
	//var _string = ""
	//if input.keyboardOrController == 0 _string = "keyboard"
	//else _string = "controller"
	//draw_text(XX,YY, "input: "+_string) YY += 15
	//draw_text(XX,YY,"controllerType: "+string(input.controllerType)) YY += 15
	
	with player {
		//draw_text(XX,YY, "x: "+string(x)) YY += 15
		//draw_text(XX,YY, "y: "+string(y)) YY += 15
		//draw_text(XX,YY, "z: "+string(z)) YY += 15
		//draw_text(XX,YY, "map: "+string(map)) YY += 15
		//draw_text(XX,YY, "groundX: "+string(groundX)) YY += 15
		//draw_text(XX,YY, "groundY: "+string(groundY)) YY += 15
		//draw_text(XX,YY, "moveForce: "+string(moveForce)) YY += 15
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
		gui.drawHealth = !gui.drawHealth
		gui.drawStamina = !gui.drawStamina
	}
	
	//	Playground
	var _string = "Playground" 
	var clicked = draw_button_ext(display_get_gui_width()-128-8,152, 128,64, _string) 
	if clicked {
		app.roomTransition(RoomPlayground, 20)
	}
	
	//	Playground
	var _string = "DEBUG" if app.mode == mode_PRODUCTION _string = "PROD"
	var clicked = draw_button_ext(display_get_gui_width()-128-8,224, 128,64,"mode: "+_string) 
	if clicked {
		app.mode = !app.mode
	}
	
	draw_reset()
	
}