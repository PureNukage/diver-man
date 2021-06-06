event_inherited()

if (instance_exists(player) and player.y > 271 or (player.x < 827 or player.x > 991)) and !played {
	
	played = true
	
	create_textbox(id, myDialogue[1, dialogueIndex])
	inConversation = true
	
	app.cameraFocus(1183,550,"~",true)
	
	player.canMove = false
	
}

if dialogueIndex == 5 and !instance_exists(textbox) {
	instance_destroy()
	if instance_exists(mafia0) mafia0.move_to(1104,240)
	
	app.cameraFocus(player.x,player.y,1,true)
	
	player.canMove = true
	
	app.save_game(false)
}