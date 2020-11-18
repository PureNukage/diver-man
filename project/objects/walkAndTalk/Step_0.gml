if destroy {
	instance_destroy()
	exit
}

if stage == 0 {
	if input.keyRight {
		layer_x("Background", layer_get_x("Background")-2)
		if gap > 0 gap -= 3
	
		if gap <= 0 {
			if timer < 120 timer++
		
			if timer >= 120 and !inConversation {
				var Textbox = instance_create_layer(0,0,"Instances",textbox)
				Textbox.ID = id
				Textbox.text = myDialogue[1, dialogueIndex]
				inConversation = true
			}
		}
	
	
		//	Show gold
		if dialogueIndex == 7 {
			gui.drawGold = true	
		}
	
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
	if gap < gapMax gap++
	else if !inConversation and dialogueIndex < 12 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
		inConversation = true	
	}
	
	//	Check for final dialogue
	if dialogueIndex == 12 {
		player.muted = false
		instance_create_layer(x+96+gap,y,"Instances",brother)
		destroy = true
		exit
	}
}

if instance_exists(player) {
	player.muted = true
	player.x = x
	player.y = y
}