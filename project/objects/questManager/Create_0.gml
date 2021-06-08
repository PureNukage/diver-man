questList = ds_list_create()
questCount = -1

finishedQuestList = ds_list_create()

questData = load_csv("quests.csv")
questInformation = ds_grid_create(ds_grid_width(questData),ds_grid_height(questData))
ds_grid_set_region(questInformation, 0,0, ds_grid_width(questInformation)-1,ds_grid_height(questInformation)-1, false)

questNames = []
for(var i=0;i<ds_grid_height(questData);i++) {
	questNames[i] = questData[# i, 0]
}
questNames[quests.intro] = "Intro"
questNames[quests.spendFinalCoin] = "The Last Coin"
questNames[quests.streetDance] = "Performing for the Streets"
questNames[quests.watch] = "The Family Watch"
questNames[quests.necklace] = "Necklace Overboard"

function quest_information_check() {
	for(var i=0;i<questCount;i++) {	
		var quest_index = questList[| i].index
		switch(quest_index) {
			case quests.spendFinalCoin:
				questInformation[# quest_index, 1] = true
			break
			
			#region Streen Dance
				case quests.streetDance:
					questInformation[# quest_index, 1] = true
					//	If we're in the dancing room and the segment is over OR we're not in the dancing room
					if (room == RoomCity2 and instance_exists(danceTimer) and danceTimer.stage >= 4) {
						questInformation[# quest_index, 2] = true
					}
				break
			#endregion
			
			#region Watch
				case quests.watch:
					questInformation[# quest_index, 1] = true
					//	If Sailor Pete has told the player about the diving suit
					if instance_exists(sailorPeteGivingSuit) and sailorPeteGivingSuit.stage >= 3 {
						questInformation[# quest_index, 2] = true	
					}
					//	If the crab has taken the watch
					if instance_exists(crab) and crab.holdingItem == watch {
						questInformation[# quest_index, 3] = true	
					}
					//	If the player has the watch
					if instance_exists(player) and player.item_check(item.watch) > -1 {
						questInformation[# quest_index, 4] = true
					}
				break
			#endregion
			
			#region Necklace
				case quests.necklace:
					questInformation[# quest_index, 1] = true
				break
			#endregion
		}
	}
}

function quest_check() {
	for(var i=0;i<questCount;i++) {
		var Quest = questList[| i]
	
		//	Run the quest script
		var finished = quest_script(Quest)
		if finished {
			var Index = Quest.index
			_remove_quest(i)
			if Index == quests.intro {
				app.scene_loader()
				app.save_game(false)
			}
			i = questCount
		}
	
	}
}

function find_quest(quest_index) {
	var quest = -1
	
	//	Check active quests first
	quest = find_active_quest(quest_index)
	
	//	Check finished quests next
	if quest == -1 quest = find_finished_quest(quest_index)
	
	//	Quest doesn't exist, lets make it
	if quest == -1 {
		add_quest(quest_index)
		quest = find_active_quest(quest_index)
	}
	
	return quest
}

function current_quest() {
	if questCount > 0 var Quest = questList[| 0]
	else var Quest = -1
	return Quest
}

function find_active_quest(quest_index) {
	for(var i=0;i<questCount;i++) {
		var Quest = questList[| i]
		if Quest.index == quest_index return Quest
	}
	return -1
}

function find_finished_quest(quest_index) {
	for(var i=0;i<ds_list_size(finishedQuestList);i++) {
		var Quest = finishedQuestList[| i]
		if Quest.index == quest_index return Quest
	}
	return -1
}

function add_quest(_quest_index) {
	var Quest = new _add_quest(_quest_index)
	ds_list_add(questList, Quest)
	
	debug.log("Added quest: "+string_upper(questNames[_quest_index]))
	
	gui.drawNewQuest = true
	
	questCount = ds_list_size(questList)
}

function _add_quest(_quest_index) constructor {
	index = _quest_index
	stage = -1
}

function _remove_quest(list_index) {
	var Quest = questList[| list_index]
	ds_list_add(finishedQuestList, Quest)
	ds_list_delete(questList, list_index)
	questCount = ds_list_size(questList)
}