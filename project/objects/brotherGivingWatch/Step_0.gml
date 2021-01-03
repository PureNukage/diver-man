event_inherited()

if player.suitOn {
	if dialogueIndex != 11 and oldDialogueIndex == -1 {
		oldDialogueIndex = dialogueIndex
		dialogueIndex = 11
	}
}
else {
	if oldDialogueIndex > -1 {
		dialogueIndex = oldDialogueIndex	
		oldDialogueIndex = -1	
	}
}

if dialogueIndex == 12 {
	game_end()	
}