event_inherited()

if filled and interactable interactable = false

if interactable {
	if input.keyInteract and !filled and !instance_exists(brotherFinalCoin) { 
		filled = true
		player.muted = true
		
		var Convo = instance_create_layer(player.x,player.y,"Instances",roomAlleyConvo)
		create_textbox(Convo, Convo.myDialogue[1, Convo.dialogueIndex])
		Convo.inConversation = true
	}
}