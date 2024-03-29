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
		draw_text(XX,YY, "player_depth: "+string(depth)) YY += 15
		draw_text(XX,YY, "camera_zoom: "+string(app.zoom_level)) YY += 15
		draw_text(XX,YY, "app.depth: "+string(app.depth)) YY += 15
		var Quest = questManager.current_quest()
		if Quest > -1 {
			draw_text(XX,YY, "quest: " + string(questManager.questNames[Quest.index]))
		}
		if instance_exists(mainmenu) draw_text(XX,YY, "mainmenu.depth: "+string(mainmenu.depth)) YY += 15
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
		gui.drawEquip = !gui.drawEquip
	}
	
	//	Playground
	var _string = "Playground" 
	var clicked = draw_button_ext(display_get_gui_width()-128-8,152, 128,64, _string) 
	if clicked {
		app.roomTransition(RoomPlayground, 20)
	}
	
	//	DEBUG
	var _string = "DEBUG" if app.mode == mode_PRODUCTION _string = "PROD"
	var clicked = draw_button_ext(display_get_gui_width()-128-8,224, 128,64,"mode: "+_string) 
	if clicked {
		app.mode = !app.mode
	}
	
	//	REBUILD
	var clicked = draw_button_ext(display_get_gui_width()-128-8,296, 128,64,"REBUILD") 
	if clicked {
		rebuild()
	}
	
	//	Underwater
	var clicked = draw_button_ext(display_get_gui_width()-256-8,296, 128,64,"go underwater") 
	if clicked {
		app.roomTransition(RoomDocks_Underwater, 20)
		if questManager.find_quest(quests.watch) == -1 questManager.add_quest(quests.watch)
		gui.toggle(true)
		app.suitOn = true
		app.save_game(true)
	}
	
	draw_reset()
	
}