event_inherited()

//	Getting smacked
if player.state == state.attack and damagedTimer == -1 and !smashed {
	var oldPlayerMask = player.mask_index
	var oldRockMask = mask_index
	player.mask_index = player.sprite_index
	mask_index = sprite_index
	if place_meeting(x,y,player) {
		debug.log("Getting smacked!")
		damagedTimer = 30
		image_index++
		heightMap.createSurface()
		if image_index >= 3 {
			debug.log("SMASHED")
			smashed = true
			instance_destroy(heightMap)
		}
		water.generate_caustic_map()
	}
	player.mask_index = oldPlayerMask
	mask_index = oldRockMask
}

if damagedTimer > -1 {
	damagedTimer--
}