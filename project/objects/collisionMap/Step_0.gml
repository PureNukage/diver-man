if (instance_exists(player) and place_meeting(x,y,player) and player.groundY < y+z) 
//or (instance_exists(player) and player.falling) 
{
	if player.map != id {
		player.depth = water.depth + 1
		depth = player.depth - 1
		drawSurface = true
		drawNearbyMaps()
	}
}

if !foundNearbyMaps findNearbyMaps()