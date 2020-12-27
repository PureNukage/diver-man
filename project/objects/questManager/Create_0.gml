questList = ds_list_create()
questCount = -1

finishedQuestList = ds_list_create()

questNames = []
questNames[quests.intro] = "Intro"
questNames[quests.spendFinalCoin] = "The Last Coin"
questNames[quests.streetDance] = "Performing for the Streets"
questNames[quests.watch] = "The Family Watch"


function quest_check() {
	for(var i=0;i<questCount;i++) {
		var Quest = questList[| i]
	
		//	Run the quest script
		var finished = quest_script(Quest)
		if finished {
			_remove_quest(i)
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