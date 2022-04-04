event_inherited()

if npcKey == "girlLastCoin" and dialogueIndex == 3 and !inConversation and cutsceneManager.cutscene == -1
and cutsceneManager.find_cutscene(cutscene.girlSkippingAroundBrother) == -1 {
	cutsceneManager.start_cutscene(cutscene.girlSkippingAroundBrother)
}

if npcKey == "girlLastCoin" and dialogueIndex == 3 and !inConversation and cutsceneManager.find_cutscene(cutscene.girlSkippingAroundBrother) > -1 {
	dialogueIndex = 4
}
