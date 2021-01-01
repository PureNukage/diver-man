event_inherited()

if interactable {
	if input.keyInteract {
		player.suitOn = !player.suitOn
		app.suitOn = player.suitOn
	}
}

//depth = -(y+32)