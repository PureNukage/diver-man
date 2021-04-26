if destroy {
	instance_destroy(playerShadow)
	instance_destroy(brotherShadow)
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
		
			if timer >= 120 and !inConversation and dialogueIndex != 6 {
				create_textbox(id, myDialogue[1, dialogueIndex])
				inConversation = true
			}
		}
	
	}
	else {
		if gap < gapMax gap += 2
	}
	
	if dialogueIndex == 6 {
		stage = 1
		questManager.add_quest(quests.streetDance)
	}
}
//	Walking to the center of the room	
else if stage == 1 {
	if gap > 0 gap -= 2
	else {
		x += 2
		playerShadow.x = x
		playerShadow.groundX = x
		playerShadow.y = y
		playerShadow.groundY = y
		brotherShadow.x = x
		brotherShadow.groundX = x
		player.x = x
		player.groundX = x
		
		if x >= room_width/2 + 50 {
			x = room_width/2 + 50
			
			stage = 2
		}
	}
}
//	Arrived at the center
else if stage == 2 {
	destroy = true
	instance_create_layer(x+96+gap,y,"Instances",brotherMusic)
	instance_create_layer(x,y,"Instances",player)
	//instance_create_layer(0,0,"Instances",danceTimer)
	gui.drawGold = true
	exit
}

if instance_exists(brotherShadow) {
	brotherShadow.x = x + 96 + gap	
	brotherShadow.groundX = x + 96 + gap
}
if instance_exists(playerShadow) {
	playerShadow.x = x	
	playerShadow.groundX = x
	playerShadow.y = y
	playerShadow.groundY = y
}
depth = -y