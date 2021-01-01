if stage == 0 {
	timer++
	if timer >= 120 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
		stage = 1
		timer = 0
	}
}
//	Wait for pete to finish then go to brother
else if stage == 1 {
	if dialogueIndex == 6 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = brotherGivingSuit.id
		Textbox.text = brotherGivingSuit.myDialogue[1, brotherGivingSuit.dialogueIndex]	
		stage = 2
	}
}
//	Wait until player is done responding
else if stage == 2 {
	if !instance_exists(textbox) and brotherGivingSuit.dialogueIndex == 3 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]	
		stage = 3 
	}
}
//	Let pete finish his last line
else if stage == 3 {
	if !instance_exists(textbox) and dialogueIndex == 7 {
		app.cameraFocus(player.x,player.y,1,true)
		stage = 4
		suitPile.interactibility = true // act suit
		cage.interactibility = true	 // act cage
	}
}
//	Wait till player puts on diving suit
else if stage == 4 {
	if player.suitOn {
		instance_create_layer(x,y,"Instances",sailorPeteGotSuit)
		var Brother = instance_create_layer(brotherGivingSuit.x,brotherGivingSuit.y,"Instances",brotherGotSuit)
		Brother.image_xscale = brotherGivingSuit.image_xscale
		instance_destroy(brotherGivingSuit)
		instance_destroy()
	}
}