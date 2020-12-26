event_inherited()

//	Round one
if dialogueIndex == 3 and player.gold > 0 {
	roundAmount= player.gold
	app.gold = 0
	player.gold = app.gold
}
if dialogueIndex == 4 and !roundOne {
	app.gold = roundAmount
	app.gold *= 2
	player.gold = app.gold
	roundOne = true
}

//	Round two
if dialogueIndex == 7 and player.gold > 0 {
	roundAmount = player.gold
	app.gold = 0
	player.gold = app.gold
}
if dialogueIndex == 8 and !roundTwo {
	app.gold = roundAmount
	app.gold *= 2
	player.gold = app.gold
	roundTwo = true	
}

//	Round three
if dialogueIndex == 11 and !roundThree {
	app.gold = 0
	player.gold = app.gold
	roundThree = true
}