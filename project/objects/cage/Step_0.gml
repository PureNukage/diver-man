var buffer = 32
if lowered and !inUse and instance_exists(player) and point_in_rectangle(player.groundX,player.groundY, x-buffer,y-buffer,bbox_right+buffer,bbox_bottom+buffer) {
	if input.keyInteract {
		useLift(up, true)
	}
}

depth = -y