event_inherited()

if filled and interactable interactable = false

if interactable {
	if input.keyInteract and !filled { 
		filled = true
		player.muted = true
		
		var Convo = instance_create_layer(player.x,player.y,"Instances",roomAlleyConvo)
		var Textbox = instance_create_layer(0,0,"Instances",textbox)
		Textbox.ID = Convo
		Textbox.text = Convo.myDialogue[1, Convo.dialogueIndex]
		Convo.inConversation = true
	}
}