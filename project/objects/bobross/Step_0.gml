event_inherited()

if dialogueIndex == 9 and !donated {
	donated = true
	if app.gold > 0 app.gold -= 1
	player.gold = app.gold
}
