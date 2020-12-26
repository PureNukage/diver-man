event_inherited()

//	Take players money and give sandwich if they don't have a sandwich
if dialogueIndex == 3 and player.item_check(item.sandwich) == -1 {
	player.create_item(item.sandwich)
	if app.gold > 0 app.gold -= 1
	player.gold = app.gold
	debug.log("Giving player sandwich and taking their money")
}