event_inherited()

if npcKey == "girlLastCoin" and dialogueIndex == 3 and !inConversation and cutsceneManager.cutscene == -1
and cutsceneManager.find_cutscene(cutscene.girlSkippingAroundBrother) == -1 {
	//debug.log(string(cutsceneManager.find_cutscene(cutscene.girlSkippingAroundBrother)))
	cutsceneManager.start_cutscene(cutscene.girlSkippingAroundBrother)
}
