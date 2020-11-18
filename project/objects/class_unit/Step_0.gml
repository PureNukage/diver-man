if interactibility {
	if point_distance(x,y, player.x,player.y) < 60 and app.roomTransitionTo == -1 {
		interactable = true
	}
	else {
		if interactable {
			interactable = false		
		}
	}
}

if interactCD > -1 {
	interactCD--
	interactable = false	
}