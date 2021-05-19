if surface > -1 and surface_exists(surface) surface_free(surface)

//depth = -room_height

surface = surface_create(display_get_gui_width(), display_get_gui_height())
surface_set_target(surface)
draw_clear_alpha(c_white, 0)

draw_set_alpha(0.5)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)


draw_set_color(c_black)
draw_set_font(font_menu2)

switch(menu) {
	#region Main Menu
		case menu.main:
			
			var xx = display_get_gui_width()/2
			var yy = 128
			var menu_items = 4

			for(var i=0;i<menu_items;i++) {
				var text = ""
				var pressed = false
				var active = true
	
				if menuIndex == i and (input.keyEnterPress or input.keyInteract or gamepad_button_check_pressed(0, gp_face1)) pressed = true
				
				switch(i) {
					//	New Game
					case 0:
						text = "New Game"
						if room != RoomMainMenu active = false
						if pressed and active {
							room_goto(RoomIntro)
							app.cameraRefresh = true
							//questManager.add_quest(quests.watch)
						}
					break
					//	Load game
					case 1:
						text = "Load Game"
						
						////	Check if we have one
						ini_open("save.ini")
						var saved = ini_read_real("SETTINGS","saved",0)
						
						if room != RoomMainMenu active = false
						
						if saved and pressed and active {
							app.load_game(false)	
						}
					break
					//	Settings
					case 2:
						text = "Settings"
						if pressed {
							menu = menu.settings
							menuIndex = 0
						}
					break
					//	Exit to Main Menu
					case 3:
						text = "Exit to Main Menu"
						if room == RoomMainMenu active = false
						if pressed and active {
							app.save_game(false)
							app.roomTransition(RoomMainMenu, 10)
							app.pause()
						}
					break
				}
				
				if active {
					if menuIndex == i draw_set_alpha(0.95)
					else draw_set_alpha(0.8)
				
					if i == 1 and !saved {
						draw_set_alpha(0.5)
						if menuIndex == i draw_set_alpha(0.95)
					}
	
					draw_text(xx,yy,text)
					yy += 64
				}
				else {
					if menuIndex == i menuIndex++	
				}
			}

			if input.keyUpPress menuIndex--
			if input.keyDownPress menuIndex++

			if menuIndex < 0 menuIndex = menu_items-1
			else if menuIndex > menu_items-1 menuIndex = 0
			
		break
	#endregion
	#region Settings
		case menu.settings:
			
			var xx = display_get_gui_width()/2
			var yy = 128
			
			for(var i=0;i<3;i++) {
				var text = ""
				var pressed = false
				switch(i) {
					case 0:
						text = "Sound: " + string(sound.volumeSound*100) + "%"
						if string_count(".00",text) text = string_delete(text,string_pos(".",text),3)
						
						if menuIndex == i {
							if input.keyLeftPress sound.volumeSound -= 0.1
							else if input.keyRightPress sound.volumeSound += 0.1
							sound.volumeSound = clamp(sound.volumeSound,0,1)
							
							if audio_is_playing(sound_underwater) audio_sound_gain(sound_underwater,sound.volumeSound,0)
						}
					break
					case 1:
						text = "Music: " + string(sound.volumeMusic*100) + "%"
						if string_count(".00",text) text = string_delete(text,string_pos(".",text),3)
						
						if menuIndex == i {
							if input.keyLeftPress sound.volumeMusic -= 0.1
							else if input.keyRightPress sound.volumeMusic += 0.1
							sound.volumeMusic = clamp(sound.volumeMusic,0,1)
							
							if sound.musicIndex > -1 {
								audio_sound_gain(sound.musicIndex, sound.volumeMusic, 0)	
							}
						}
					break
					case 2:
						text = "Back"
						
						if menuIndex == i and (input.keyEnterPress or input.keyInteract or gamepad_button_check_pressed(0, gp_face1)) {
							menu = menu.main
							menuIndex = 2
						}
					break
				}
				
				if menuIndex == i draw_set_alpha(0.95)
				else draw_set_alpha(0.8)
				
				draw_text(xx,yy, text)
				
				yy += 64
			}
			
			if input.keyUpPress menuIndex--
			if input.keyDownPress menuIndex++

			if menuIndex < 0 menuIndex = 2
			else if menuIndex > 2 menuIndex = 0
			
			
		break
	#endregion
}




surface_reset_target()

draw_reset()