event_inherited()

//	Brother comes out
if stage == 0 {
	if dialogueIndex == 7 { 
		Sequence = layer_sequence_create(Layer,0,0,Sequence2)
		stage = 1
		inConversation = true
		brothersbox.filled = false
	}
	
}

//	Wait for brother to finish up
else if stage == 1 {
	inConversation = true
	if layer_sequence_is_finished(Sequence) {
		//layer_set_visible(Layer, false)
		stage = 2
	}
}
//	Start new dialogue
else if stage == 2 {
	create_textbox(id, myDialogue[1, dialogueIndex])
	inConversation = true
	stage = 3
}

//	Wait for brothers dialogue to finish then start the sequence of him running back
else if stage == 3 {
	if !instance_exists(textbox) and dialogueIndex == 12 {
		layer_sequence_destroy(Sequence)
		Sequence = layer_sequence_create(Layer,0,0,Sequence3)
		stage = 4
	}
}
//	Wait for brother to go to box
else if stage == 4 {
	if layer_sequence_is_finished(Sequence) {
		layer_set_visible(Layer, false)
		app.roomTransition(RoomCity2, 5)
		stage = 5
		brothersbox.filled = true
	}
}