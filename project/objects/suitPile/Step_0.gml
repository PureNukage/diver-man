if instance_exists(player) and place_meeting(x,y,player) {
	if input.keyInteract {
		player.suitOn = !player.suitOn
		app.suitOn = player.suitOn
	}
}

depth = -y