event_inherited()

if stage == 0 {
	timer++
	if timer >= 90 {
		create_textbox(id, myDialogue[1, dialogueIndex])
		stage = 1
	}
}