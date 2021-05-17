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
						}
					break
				}
				
			break
		#endregion
			
		#region SPEND FINAL COIN
			case quests.spendFinalCoin:
				
				switch(stage) {
					//	Wait for player to say Yes to going back then count quest stats
					case -1:
						if room == RoomCityHub {
							if instance_exists(brotherIntro) and brotherIntro.dialogueIndex == 5 {
														
								//	Quest variables
								quest.keptCoin = false
								quest.listenedToPete = false
								quest.boughtSandwich = false
								quest.gambled = false
								quest.profited = false
								quest.lostItAll = false 
							
								quest._listenedToPete = false
								quest._boughtSandwich = false
								quest._gambled = false
							
								if instance_exists(sailorPeteSitting) {
									//	Did the player listen to Pete?
									quest.listenedToPete = sailorPeteSitting.toldStory
								}
							
								//	Did the player buy a sandwich?
								if player.item_check(item.sandwich) > -1 quest.boughtSandwich = true
							
								//	Did the player gamble at all?
								if (bully2Dice.roundOne) {
									quest.gambled = true	
								}
							
								//	Did the player gamble, make profit, and do nothing?
								if (bully2Dice.roundOne or bully2Dice.roundTwo) and player.gold > 0 and !quest.boughtSandwich and !quest.listenedToPete {
									quest.profited = true
								}
							
								//	Did the player keep the coin?
								if player.gold == 1 and !quest.gambled and !quest.boughtSandwich and !quest.listenedToPete {
									quest.keptCoin = true	
								}
							
								//	Did the player lose it all?
								if bully2Dice.roundThree and !quest.boughtSandwich and !quest.listenedToPete and player.gold == 0 {
									quest.lostItAll = true	
								}
							
								quest.stage++	
							}
						}
					break
					//	Wait for player to go back to alley
					case 0:
						if room == RoomAlleyHub {
							quest_finished = true
						}
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
				
				if room == RoomAlleyHub {
					quest_finished = true	
				}
				
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