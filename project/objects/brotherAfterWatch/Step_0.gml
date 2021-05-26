event_inherited()

if moving {
	sprite_index = s_brother_walk
}
else {
	sprite_index = s_brother	
}

//	Start dialogue
if stage == 0 {
	create_textbox(id, myDialogue[1, dialogueIndex])
	stage = 1
}
//	Wait till dialogue finishes then start sailor pete entrance dialogue
else if stage == 1 {
	if !instance_exists(textbox) and dialogueIndex == 1 {
		stage = 2
		sailorPeteEntrance.move_to(1311, 351)
	}
}
//	Wait till sailor pete walks in 
else if stage == 2 {
	if !sailorPeteEntrance.moving {
		var Pete = sailorPeteEntrance
		create_textbox(Pete.id, Pete.myDialogue[1, Pete.dialogueIndex])
		stage = 3
	}
}
//	Wait till petes done talking then start more brother dialogue
else if stage == 3 {
	if !instance_exists(textbox) and sailorPeteEntrance.dialogueIndex == 4 {
		create_textbox(id, myDialogue[1, dialogueIndex])
		stage = 4
	}
}
//	Wait till brother stops talking then start Petes last dialogue
else if stage == 4 {
	if !instance_exists(textbox) and dialogueIndex == 3 {
		var Pete = sailorPeteEntrance
		create_textbox(Pete.id, Pete.myDialogue[1, Pete.dialogueIndex])
		stage = 5
	}
}
//	Wait till Petes last dialogue is finished
else if stage == 5 {
	if !instance_exists(textbox) and sailorPeteEntrance.dialogueIndex == 8 {
		stage = 6
		sailorPeteEntrance.move_to(636,sailorPeteEntrance.y)
		brotherAfterWatch.move_to(754,360)
		app.cameraFocus(player.x,player.y,1,true)
		player.canMove = true
		brotherAfterWatch.interactibility = false
		sailorPeteEntrance.interactibility = false
	}
}
//	Wait till Pete arrives at the cage/suit
else if stage == 6 {
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