event_inherited()

mask_index = s_mudcrab_collision

interactibility = false

maxMovespeed = 0.5

if place_meeting(x,y,collisionMap) {
	var Map = instance_place(x,y,collisionMap)
	map = Map
	z = Map.z
	y += z
}

function stunCheck() {
	if point_distance(x,y, player.x,player.y) < 30 and player.jumpHalt and abs(player.z-z) < 4 {
		state = state.stunned
		//sprite_index = s_crab_knocked
		setThrust(5)
		timer = 90
		
	}
}