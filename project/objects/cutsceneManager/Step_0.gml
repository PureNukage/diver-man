switch(cutscene)
{
	case -1:
	
	break
	case cutscene.coupleComingOffBoat:
		switch(stage)
		{
			//	Setup camera
			case -1:
				if room == RoomDocks {
					player.muted = true
					gui.toggle(false)
					app.cameraFocus(1020,353,"~",false)
					var Husband = instance_create_layer(1370,350,"Instances",husband)
					var Wife = instance_create_layer(1380,380,"Instances",wife)
					stage++
				}
			break
			case 0:
				if timer < 180 timer++
				else {
					husband.move_to(1086,350)
					wife.move_to(1096,380)
					stage++
					timer = 0
				}
			break
			case 1:
				if !husband.moving and !wife.moving {
					with wife {
						create_textbox(id, myDialogue[1, dialogueIndex])
						inConversation = true
					}
					stage++
				}
			break
			//	Wait for wifes dialogue to be done
			case 2:
				if wife.dialogueIndex == 2 {
					if timer < 60 timer++
					else {
						var Brother = instance_create_layer(608,360,"Instances",brother)
						Brother.move_to(900,360)
						stage++
						timer = 0
					}
				}
			break
			//	Wait for brother to stop moving
			case 3:
				if !brother.moving {
					with wife {
						create_textbox(id, myDialogue[1, dialogueIndex])
						inConversation = true
					}
					stage++	
				}
			break
			//	Back to alley
			case 4:
				if wife.dialogueIndex == 6 and !instance_exists(textbox) {
					questManager.add_quest(quests.necklace)
					app.roomTransition(RoomAlleyHub, 10)
					finish_cutscene()
					gui.toggle(true)
					stage++	
				}
			break
		}
	break
}