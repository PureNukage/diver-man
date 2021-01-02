//	Wait for player to get close enough
if stage == 0 {
	if player.groundX >= 1050 {
		player.canMove = false
		app.cameraFocus(1235,360, "~", true)
		stage = 1
		Layer = layer_create(-1)
		Sequence = layer_sequence_create(Layer,0,0,Sequence6)
		layer_sequence_pause(Sequence)
		layer_set_visible(Layer,false)
		create_textbox(id, myDialogue[1, dialogueIndex])
	}
}
//	Wait for dialogue to finish then start sequence
else if stage == 1 {
	if dialogueIndex == 3 {
		layer_sequence_play(Sequence)
		layer_set_visible(Layer,true)
		brotherWatchToss.visible = false
		bully2Watch.visible = false
		bully1Watch.visible = false
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
		layer_set_visible(Layer,false)
		brotherWatchToss.visible = true
		bully2Watch.visible = true
		bully1Watch.visible = true
		create_textbox(id, myDialogue[1, dialogueIndex])
	}
}
//	Wait for dialogue to finish then finish the Sequence
else if stage == 3 {
	if !instance_exists(textbox) and dialogueIndex == 4 {
		layer_sequence_play(Sequence)
		layer_set_visible(Layer,true)
		brotherWatchToss.visible = false
		bully2Watch.visible = false
		bully1Watch.visible = false
		stage = 4
	}
}
//	Wait for sequence to finish
else if stage == 4 {
	if layer_sequence_is_finished(Sequence) {
		instance_create_layer(1152,384,"Instances",brotherAfterWatch)
		instance_destroy(brotherWatchToss)
		instance_destroy(bully2Watch)
		instance_destroy(bully1Watch)
		layer_sequence_destroy(Sequence)
		instance_destroy()
	}
}