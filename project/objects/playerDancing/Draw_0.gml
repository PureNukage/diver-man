if live_call() return live_result

draw_self()


//	Dancing!
if on {
	
	var xx = x
	var yy = y - 100
	draw_sprite(s_dance_center,0,xx,yy)
	
	draw_set_font(font_dancing)
	draw_set_halign(fa_left)
	draw_set_valign(fa_middle)
	draw_text(xx-200,yy-12,"Mistakes: "+string(mistakes)+"/5")
	
	if !audio_is_playing(sound_electroswing) sound.playMusic(sound_electroswing, true)
	
	//	Send a person away
	if mistakes >= 5 and !sentPersonAway {
		sentPersonAway = true
		dancingCrowdManager.remove_person()
	}

	if !ds_list_empty(list_active) {
		for(var i=0;i<ds_list_size(list_active);i++) {
			var Type = list_active[| i]
			var Sprite = -1
			var Key = false
			switch(Type) {
				case up: 
					Sprite = s_arrow_up 
					if input.keyUp Key = true
				break
				case right: 
					Sprite = s_arrow_right
					if input.keyRight Key = true
				break
				case down: 
					Sprite = s_arrow_down 
					if input.keyDown Key = true
				break
				case left: 
					Sprite = s_arrow_left 
					if input.keyLeft Key = true
				break
			}
			
			if i == 0 draw_set_alpha(1)
			else if i == 1 draw_set_alpha(0.5)
			else draw_set_alpha(0)
			draw_sprite(Sprite,0,xx+list_offset,yy)
			
			if Key and list_offset < 5 {
				list_remove_one()
				//sound.playSoundEffect(sound_coins)
				list_success++
				if list_success == 10 {
					list_success = 0
					dancingCrowdManager.add_person()
				}
			}
			else if Key and list_offset >= 5 and list_offset <= 15 {
				list_remove_one()
				sound.playSoundEffect(sound_whoosh)
				mistakes++
			}
			if list_offset < -5 {
				list_remove_one()
				sound.playSoundEffect(sound_whoosh)
				mistakes++
			}
			xx += 45
		}
	}
	else if !ds_list_empty(list) {
		list_unpack()
	}
	//	New dance
	else {
		if dances > 0 {
			mistakes = 0
			sentPersonAway = false

			sound.playSoundEffect(sound_coins)
			var Random = irandom_range(0,ds_list_size(dancingCrowdManager.list)-1)
			var RandomPerson = dancingCrowdManager.list[| Random]
			var Coin = instance_create_layer(RandomPerson.x,RandomPerson.y,"Instances",coin)
			Coin.stage = 2
			
			add_dance()
			
			if dances == 3 list_speed += 0.12
			if dances == 2 list_speed += 0.13
			if dances == 1 list_speed += .10
			list_offset = list_offset_start
		}
	}
	list_offset -= list_speed

}

draw_reset()