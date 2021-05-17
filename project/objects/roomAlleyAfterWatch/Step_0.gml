event_inherited()

if timer > 0 timer--
else {
	if !used {
		create_textbox(id, myDialogue[1, dialogueIndex])
		inConversation = true
		
		used = true
	}
}

if dialogueIndex == 8 and !newRoom {
	newRoom = true
	cutsceneManager.cutscene = cutscene.coupleComingOffBoat
	app.roomTransition(RoomDocks, 10)
}