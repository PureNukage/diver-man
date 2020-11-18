if stage == 0 {
	if timer < 3000 {
		timer++	
	}
	else {
		app.cameraFocusOnPlayer = false
		app.cameraFocusX = 0
		app.cameraFocusY = 230
		stage = 1
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
	}
}
//	Wait for dialogue to finish
else if stage == 1 {
	if !instance_exists(textbox) and dialogueIndex == 1 {
		Layer = layer_create(-1)
	    Sequence = layer_sequence_create(Layer,0,0,Sequence4)
		stage = 2	
		playerDance.muted = true
		brotherMusic.visible = false
	}
}
//	Wait for Sequence to finish
else if stage == 2 {
	app.cameraFocusX += 5
	if layer_sequence_is_finished(Sequence) {
		stage = 3
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
	}	
}
//	Wait for dialogue to finish
else if stage == 3 {
	if !instance_exists(textbox) and dialogueIndex == 8 {
		layer_sequence_destroy(Sequence)
		Sequence = layer_sequence_create(Layer,0,0,Sequence5)
		stage = 4
	}
}
//	Wait for sequence 5 to finish
else if stage == 4 {
	if layer_sequence_is_finished(Sequence) {
		app.cameraFocusOnPlayer = true
		instance_create_layer(player.x,player.y,"Instances",playerChase)
		instance_destroy()
	}
}