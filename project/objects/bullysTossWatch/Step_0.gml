//	Wait for player to get close enough
if stage == 0 {
	if player.groundX >= 2340 {
		player.groundX = 2360
		player.x = 2360
		player.muted = true
		app.cameraFocusOnPlayer = false
		app.cameraFocusX = 2560
		app.cameraFocusY = 491
		stage = 1
		Layer = layer_create(-1)
		Sequence = layer_sequence_create(Layer,0,0,Sequence6)
		layer_sequence_pause(Sequence)
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
	}
}
//	Wait for dialogue to finish then start sequence
else if stage == 1 {
	if dialogueIndex == 3 {
		layer_sequence_play(Sequence)
		stage = 2
	}
}
//	Wait for bullies to toss watch into the water 
else if stage == 2 {
	var Frame = layer_sequence_get_headpos(Sequence)
	if Frame >= 140 {
		stage = 3 
		layer_sequence_headpos(Sequence, 141)
		layer_sequence_pause(Sequence)
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
	}
}
//	Wait for dialogue to finish then finish the Sequence
else if stage == 3 {
	if !instance_exists(textbox) and dialogueIndex == 4 {
		layer_sequence_play(Sequence)
		stage = 4
	}
}
//	Wait for sequence to finish
else if stage == 4 {
	if layer_sequence_is_finished(Sequence) {
		instance_create_layer(2525,502,"Instances",brotherAfterWatch)
		layer_sequence_destroy(Sequence)
		instance_destroy()
	}
}