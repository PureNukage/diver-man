event_inherited()

if player.suitOn {
	if dialogueIndex != 6 and oldDialogueIndex == -1 {
		oldDialogueIndex = dialogueIndex
		dialogueIndex = 6
	}
}
else {
	if oldDialogueIndex > -1 {
		dialogueIndex = oldDialogueIndex	
		oldDialogueIndex = -1	
	}
}

if dialogueIndex == 7 {
	//game_end()
	//	Go to alley
	app.roomTransition(RoomAlleyHub, 10)
	dialogueIndex = -7
}