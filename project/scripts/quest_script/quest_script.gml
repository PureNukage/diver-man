function quest_script(quest) {
	var quest_index = quest.index
	var stage = quest.stage 
	
	var quest_finished = false
	switch(quest_index) {
		
		#region INTRO 
			case quests.intro:
				
				switch(stage) {
					case -1:
						if instance_exists(walkAndTalk) {
							quest.stage++
							debug.log("Quest: "+string_upper(questManager.questNames[quest_index])+" is now at stage: "+string_upper(quest.stage))
						}
					break
					//	Wait for intro dialogue to finish up
					case 0:
						if !instance_exists(walkAndTalk) {
							quest_finished = true	
						}
					break
				}
				
			break
		#endregion
			
		#region SPEND FINAL COIN
			case quests.spendFinalCoin:
				
				
				
			break
		#endregion
		
		#region STREET PERFORMERS
			case quests.streetDance:
				
				
				
			break
		#endregion
		
		#region GET BROTHERS WATCH
			case quests.watch:
				
				
				
			break
		#endregion
	}
	
	if quest_finished {
		debug.log("Finished quest: "+string_upper(questNames[quest_index]))	
	}
	
	return quest_finished
	
}