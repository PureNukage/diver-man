event_inherited()

if input.keyInteract and !dancingFinished and interactable and !on and !instance_exists(walkAndTalk2) {
	on = true
	player.muted = true
	
	app.cameraFocus(x,y,"~",0)
	app.zoom_level = 0.70
	
	if !instance_exists(dancingCrowdManager) instance_create_layer(x,y,"Instances",dancingCrowdManager)
	dancingCrowdManager.add_person()
	
	add_dance()
	
}

if on {
	if animation_end and (sprite_index == s_player_kid_dance_left_legsup or sprite_index == s_player_kid_dance_right_legsup) {
		if sprite_index == s_player_kid_dance_right_legsup sprite_index = s_player_kid_dance_left_idle
		else if sprite_index == s_player_kid_dance_left_legsup sprite_index = s_player_kid_dance_right_idle
	}
}

if input.keyArrowUp y--
if input.keyArrowDown y++

depth = -y - 50