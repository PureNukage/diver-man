event_inherited()

if !shop and dialogueIndex == 1 and !input.keyInteract {
	dialogueIndex = 0
	shop = true
	app.zoom_level = 0.70
	player.muted = true
}