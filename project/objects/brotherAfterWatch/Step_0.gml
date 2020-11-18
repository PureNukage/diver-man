event_inherited()

//	Start dialogue
if stage == 0 {
	var Textbox = instance_create_layer(0,0,"Instances",textbox)
	Textbox.ID = id
	Textbox.text = myDialogue[1, dialogueIndex]	
	stage = 1
}
//	Wait till dialogue finishes then start sailor pete entrance dialogue
else if stage == 1 {
	if !instance_exists(textbox) and dialogueIndex == 5 {
		timer++
		if timer >= 120 {
			stage = 2
			var Pete = instance_create_layer(0,0,"Instances",sailorPeteEntrance)
			var Textbox = instance_create_layer(0,0,"Instances",textbox)
			Textbox.ID = Pete
			Textbox.text = Pete.myDialogue[1, Pete.dialogueIndex]
		}
	}
}
//	Brief pause before sailor pete interrupts
else if stage == 2 {
	if !instance_exists(textbox) {
		Layer = layer_create(-1)
		Sequence = layer_sequence_create(Layer,0,0,Sequence7)	
		stage = 3
		image_xscale = -1
		player.image_xscale = -1
	}
}
//	Wait till sailor pete walks in 
else if stage == 3 {
	if layer_sequence_is_finished(Sequence) {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		var Pete = sailorPeteEntrance
		Textbox.ID = Pete
		Textbox.text = Pete.myDialogue[1, Pete.dialogueIndex]	
		stage = 4
	}
}
//	Wait till petes done talking then start more brother dialogue
else if stage == 4 {
	if !instance_exists(textbox) and sailorPeteEntrance.dialogueIndex == 5 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
		stage = 5
	}
}
//	Wait till brother stops talking then start Petes last dialogue
else if stage == 5 {
	if !instance_exists(textbox) and dialogueIndex == 7 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		var Pete = sailorPeteEntrance
		Textbox.ID = Pete
		Textbox.text = Pete.myDialogue[1, Pete.dialogueIndex]
		stage = 6
	}
}
//	Wait till Petes last dialogue is finished
else if stage == 6 {
	if !instance_exists(textbox) and sailorPeteEntrance.dialogueIndex == 9 {
		app.roomTransition(RoomDockGettingSuit, 5)
		stage = 7
	}
}