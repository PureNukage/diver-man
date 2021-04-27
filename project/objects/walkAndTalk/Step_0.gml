if destroy {
	instance_destroy(brotherShadow)
	instance_destroy(playerShadow)
	instance_destroy()
	exit
}

if gap < gapMax {
	brotherShadow.sprite_index = s_brother_walk	
}
else {
	brotherShadow.sprite_index = s_kid_crutch	
}

if stage == 0 {
	if input.keyRight or gamepad_axis_value(0, gp_axislh) > 0.5 {
		layer_x("Background", layer_get_x("Background")-2)
		if gap > 0 gap -= 3
	
		if gap <= 0 {
			if timer < 120 timer++
		
			if timer >= 120 and !inConversation {
				create_textbox(id,myDialogue[1, dialogueIndex])
				inConversation = true
			}
		}
	
	
		//	Show gold
		if dialogueIndex == 7 {
			gui.drawGold = true	
		}
		playerShadow.sprite_index = s_kid_player_walk
	}
	else {
		if gap < gapMax gap += 2
	}

	//	Check for final dialogue
	if dialogueIndex == 8 {
		stage = 1
		inConversation = false
	}
}
//	After the brother knows how much money is left
else if stage == 1 {
	if gap < gapMax {
		gap++
		//brotherShadow.sprite_index = s_brother_walk
	}
	else {
		//brotherShadow.sprite_index = s_kid_crutch
		if !inConversation and dialogueIndex < 12 {
			create_textbox(id,myDialogue[1, dialogueIndex])
			inConversation = true	
		}
	}
	
	//	Check for final dialogue
	if dialogueIndex == 12 {
		player.muted = false
		player.canMove = false
		instance_create_layer(x+96+gap,y,"Instances",brother)
		destroy = true
		app.buffer_loader(RoomCityHub)
		room_goto(RoomCityHub)
		roomIntroSurface.surfaceX = layer_get_x("Background")
		roomIntroSurface.brotherX = x+96+gap
		roomIntroSurface.brotherY = y
		app.cameraRefresh = true
		gui.drawHealth = true
		gui.drawStamina = true
		exit
	}
}

if instance_exists(brotherShadow) {
	brotherShadow.x = x + 96 + gap	
}