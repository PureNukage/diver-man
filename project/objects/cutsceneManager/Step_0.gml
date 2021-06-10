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
	case cutscene.mafiaVendorShake:
		switch(stage)
		{
			//	Wait for mafia0 to be back at the diner
			case -1:
				if instance_exists(mafia0) and point_distance(mafia0.x,mafia0.y, 1104,240) < 2 {
					stage++
					finish_cutscene()
					mafia0.image_xscale = 1
					app.save_game(false)
				}
			break
		}
	break
	case cutscene.jellyGivingNecklace:
		switch(stage) {
			//	Spawn in the eels
			case -1:
				var Eeel1 = instance_create_layer(1472,2304,"Instances",eel)
				Eeel1.image_xscale = -1
				var Eeel2 = instance_create_layer(1520,2304,"Instances",eel)
				stage = 0
				player.canMove = false
				jellyfish.interactibility = false
				jellyfish.interactable = false
				jellyfish.interactDistance = false
			break
			//	Pan camera to the eels
			case 0:
				app.cameraFocus(1496,2260,"~",true)
				stage = 1
			break
			//	Resume Jellyfish dialogue
			case 1:
				if timer < 90 timer++
				else {
					if instance_exists(jellyfish) with jellyfish {
						create_textbox(id, myDialogue[1, dialogueIndex])
						inConversation = true	
					}
					stage = 2
					timer = 0
					app.cameraFocus(jellyfish.x,jellyfish.y,"~",true)
				}
			break
			//	Jellyfish walks over to the eels
			case 2:
				if jellyfish.dialogueIndex == 13 {
					app.cameraFocus(1496,2260,"~",true)
					jellyfish.sprite_index = s_jelly
					jellyfish.free_move(1440,2304)
					stage = 3
				}
			break
		}
	break
}