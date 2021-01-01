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
			var Pete = instance_create_layer(820,369,"Instances",sailorPeteEntrance)
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
		sailorPeteEntrance.move_to(980,369)
		app.cameraFocus(980,369,"~",true)
		stage = 3
		image_xscale = -1
		player.image_xscale = -1
		questManager.add_quest(quests.watch)
	}
}
//	Wait till sailor pete walks in 
else if stage == 3 {
	if !sailorPeteEntrance.moving {
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
		stage = 7
		sailorPeteEntrance.move_to(636,sailorPeteEntrance.y)
		brotherAfterWatch.move_to(754,360)
		app.cameraFocus(player.x,player.y,1,true)
		player.canMove = true
		brotherAfterWatch.interactibility = false
		sailorPeteEntrance.interactibility = false
	}
}
//	Wait till Pete arrives at the cage/suit
else if stage == 7 {
	if !sailorPeteEntrance.moving {
		var Pete = instance_create_layer(sailorPeteEntrance.x,sailorPeteEntrance.y,"Instances",sailorPeteGivingSuit)
		Pete.image_xscale = 1
		instance_destroy(sailorPeteEntrance)
		var Brother = instance_create_layer(x,y,"Instances",brotherGivingSuit)
		Brother.image_xscale = image_xscale
		Brother.interactibility = false
		instance_destroy()
	}
}