event_inherited()

if moving and !inConversation _moving()

applyMovement()

if !onGround applyThrust()

if interactable and interactability and hasDialogue {
	if input.keyInteract and !inConversation and dialogueIndex > -1 and dialogueIndex < array_length(myDialogue[0]) {
		//	Condition check this dialogue
		condition_check_dialogue(id)
		
		create_textbox(id, myDialogue[1, dialogueIndex])
		inConversation = true
	}
}

if !interactable and inConversation and interactDistance {
	inConversation = false
	if instance_exists(textbox) instance_destroy(textbox)
}

//debug.log("x: "+string(x))
//debug.log("y: "+string(y))

if onGround {
	x = groundX
	y = groundY + z
}
else {
	x = groundX
}