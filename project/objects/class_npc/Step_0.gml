event_inherited()

if interactable and interactibility {
	if input.keyInteract and !inConversation and dialogueIndex > -1 {
		//	Condition check this dialogue
		condition_check_dialogue(id)
		
		create_textbox(id, myDialogue[1, dialogueIndex])
		inConversation = true
	}
}

if !interactable and inConversation {
	inConversation = false
	if instance_exists(textbox) instance_destroy(textbox)
}