if surface > -1 and surface_exists(surface) surface_free(surface)

surface = surface_create(room_width, room_height)
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
			
			var xx = room_width/2
			var yy = 128

			for(var i=0;i<3;i++) {
				var text = ""
				var pressed = false
	
				if menuIndex == i and (input.keyEnterPress or input.keyInteract) pressed = true
	
				switch(i) {
					//	New Game
					case 0:
						text = "New Game"
						if pressed {
							room_goto(Room1)
							app.cameraRefresh = true
						}
					break
					//	Load game
					case 1:
						text = "Load Game"

					break
					//	Settings
					case 2:
						text = "Settings"
						if pressed {
							menu = menu.settings
							menuIndex = 0
						}
					break
				}
	
				if menuIndex == i draw_set_alpha(0.95)
				else draw_set_alpha(0.8)
	
				draw_text(xx,yy,text)
				yy += 64
			}

			if input.keyUpPress menuIndex--
			if input.keyDownPress menuIndex++

			if menuIndex < 0 menuIndex = 2
			else if menuIndex > 2 menuIndex = 0
			
		break
	#endregion
	#region Settings
		case menu.settings:
			
			var xx = room_width/2
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
						}
					break
					case 2:
						text = "Back"
						
						if menuIndex == i and (input.keyEnterPress or input.keyInteract) {
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