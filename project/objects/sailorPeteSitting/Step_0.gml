event_inherited()

if dialogueIndex == 5 and !toldStory {
	if app.gold > 0 app.gold -= 1
	player.gold = app.gold
	toldStory = true
}