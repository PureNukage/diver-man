event_inherited()

if filled and interactable interactable = false

if interactable {
	if input.keyInteract and !filled and !instance_exists(brotherFinalCoin) { 
		filled = true
		player.muted = true
		
		//var Quest = questManager.current_quest()
		////	Intro alleyway
		//if (Quest > -1 and Quest.index == quests.spendFinalCoin) or (Quest == -1 and questManager.find_finished_quest(quests.spendFinalCoin) > -1) {
			var Convo = instance_create_layer(player.x,player.y,"Instances",roomAlleyConvo)
			create_textbox(Convo, Convo.myDialogue[1, Convo.dialogueIndex])
			Convo.inConversation = true
		//}
		////	After getting watch 
		//else {
		//	var Convo = instance_create_layer(0,0,"Instances",roomAlleyAfterWatch)
		//}
	}
}