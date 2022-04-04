event_inherited()

if moving and !inConversation {
	sprite_index = s_brother_walk
}
else {
	sprite_index = s_brother	
}

//	After giving the necklace to the adults, spawn Sailor Pete and walk over to the Dock Shop
if npcKey == "brotherNecklacePostEmpty" and dialogueIndex == 3 and !inConversation and interactability {
	move_to(448, 304)
	var Pete = instance_create_layer(320,272,"Instances",sailorPete)
	with Pete {
		npcKey = "sailorPeteShop"
		load_dialogue()
	}
	//if instance_exists(collisionRoomChange) {
	//	with collisionRoomChange {
	//		spawn_collision()
	//	}
	//}
	interactability = false
}