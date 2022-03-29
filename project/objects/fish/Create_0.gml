event_inherited()

speedBurst = false

school = -1

sprite_index = choose(s_fish_1,s_fish_2,s_fish_3,s_fish_4)
mask_index = s_fish_collision

floatZ = 32

//drawShadow = false

interactability = false

maxMovespeed = 1

mapcheck()

new_z = 0
function float(_new_z) {
	new_z = _new_z-z
}
function _floating() {
	z += sign(new_z)
	new_z -= sign(new_z)
}
function map_move(_x, _y) {
	var newMap = instance_place(_x,_y,collisionMap)
	
	if newMap > -1 {
		var newZ = newMap.z+newMap.height
	
		if newZ != z and newMap != map {
			//changeMap(newMap)
			map = newMap
			float(newZ)
		}
	}
	//	No map
	else {
		if z > 0 {
			//changeMap(-1)
			map = -1
			float(0)
		}
	}
}

function player_check() {
	if instance_exists(player) {
		if (abs(player.moveForce) > 1) and point_distance(x,y, player.x,player.y) < 128 {
			var DirectionAwayFromPlayer = point_direction(player.x,player.y, x,y)
			var DirectionWiggleRoom = 45
			var RandomDirection = irandom_range(DirectionAwayFromPlayer-DirectionWiggleRoom, DirectionAwayFromPlayer+DirectionWiggleRoom)
			var rangeMax = 128
			var rangeMin = 64
			var randomRange = irandom_range(rangeMin, rangeMax)
			var randomX = x + lengthdir_x(randomRange, RandomDirection)
			var randomY = y + lengthdir_y(randomRange, RandomDirection)
			move_to(randomX,randomY)
			debug.log("swimming away from player!")
		}
	}
}