if instance_exists(player) and (place_meeting(x,y,player) or point_in_rectangle(player.x,player.y-32,x-32,y-32,bbox_right+32,bbox_bottom+32)) {
	if input.keyInteract {
		player.suitOn = !player.suitOn
		app.suitOn = player.suitOn
	}
}

depth = -y