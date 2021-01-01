event_inherited()

npcKey = "brother"
load_dialogue()

stage = 0

if room == RoomCityHub {
	questManager.add_quest(quests.spendFinalCoin)
}