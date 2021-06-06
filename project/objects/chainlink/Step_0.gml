if !onGround applyThrust()

if point_distance(x,y, player.x,player.y) < 60 and app.roomTransitionTo == -1 and room != RoomAlleyHub {
	interactable = true
	if input.keyInteract and interactCD == -1 {
		pickedUp = true
	}
}
else {
	if interactable {
		interactable = false		
	}
}
