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
						}
					break
					//	Wait for intro dialogue to finish up
					case 0:
						if !instance_exists(walkAndTalk) {
							quest_finished = true
							questManager.add_quest(quests.spendFinalCoin)
						}
					break
				}
				
			break
		#endregion
			
		#region SPEND FINAL COIN
			case quests.spendFinalCoin:
				
				switch(stage) {
					//	Wait for player to go back to alley
					case -1:
						if room == RoomAlley quest_finished = true
					break
				}
				
			break
		#endregion
		
		#region STREET PERFORMERS
			case quests.streetDance:
				
				switch(stage) {
					//	Wait for bullies to chase brother away
					case -1:
						if instance_exists(danceTimer) and danceTimer.stage >= 4 quest.stage++
					break
					//	Chasing after brother and bullies
					case 0:
						if instance_exists(bullysTossWatch) and bullysTossWatch.stage > 0 quest_finished = true
					break
				}
				
			break
		#endregion
		
		#region GET BROTHERS WATCH
			case quests.watch:
				
				
				
			break
		#endregion
	}
	
	//	We advanced a stage
	if quest.stage > stage {
		debug.log("Quest: "+string_upper(questManager.questNames[quest_index])+" is now at stage: "+string_upper(quest.stage))	
	}
	
	if quest_finished {
		debug.log("Finished quest: "+string_upper(questNames[quest_index]))	
	}
	
	return quest_finished
	
}