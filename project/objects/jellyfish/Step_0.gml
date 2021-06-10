event_inherited()

if !startedCutscene and dialogueIndex == 2 {
	startedCutscene = true
	cutsceneManager.start_cutscene(cutscene.jellyGivingNecklace)
}