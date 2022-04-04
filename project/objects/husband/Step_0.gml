event_inherited()

//	The player has given the necklace to them
if npcKey == "husbandAndWifePost" and dialogueIndex == 4 and player.item_check(item.necklace) > -1 {
	var index = player.item_check(item.necklace)
	if index > -1 {
		player.remove_item(index)
		if instance_exists(brother) with brother {
			npcKey = "brotherNecklacePostEmpty"
			load_dialogue()
		}
	}
	
	free_move(-110, 330)
	with wife free_move(-110, 330)
	
	create_coin()
	
}

if (x < -80 and wife.x < -80) {
	instance_destroy()
	debug.log("destroying husband and wife")
}