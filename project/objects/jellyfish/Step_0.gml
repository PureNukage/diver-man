event_inherited()

if !startedCutscene and dialogueIndex == 2 {
	startedCutscene = true
	cutsceneManager.start_cutscene(cutscene.jellyGivingNecklace)
}

if sprite_index == s_jelly_sitting and dialogueIndex == 11 and !gaveNecklace {
	sprite_index = s_jelly_sitting_no_necklace
	gaveNecklace = true
	player.create_item(item.necklace)
}

if !gaveNecklace and dialogueIndex == 15 {
	gaveNecklace = true
	if sprite_index == s_jelly_sad sprite_index = s_jelly_sad_no_necklace
	else sprite_index = s_jelly_sitting_no_necklace
	player.create_item(item.necklace)
}