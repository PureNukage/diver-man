event_inherited()

if interactable {
	if input.keyInteract and !inConversation and dialogueIndex > -1 {
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = id
		Textbox.text = myDialogue[1, dialogueIndex]
		inConversation = true	
	}
}

if !interactable and inConversation {
	inConversation = false
	if instance_exists(textbox) instance_destroy(textbox)
}