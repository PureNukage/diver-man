event_inherited()

if !startedCutscene and dialogueIndex == 2 {
	startedCutscene = true
	cutsceneManager.start_cutscene(cutscene.jellyGivingNecklace)
}

if !gaveNecklace and dialogueIndex == 15 {
	gaveNecklace = true
	sprite_index = s_jelly_sad_no_necklace
	player.create_item(item.necklace)
}