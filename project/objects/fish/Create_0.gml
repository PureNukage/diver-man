event_inherited()

speedBurst = false

school = -1

sprite_index = choose(s_fish_1,s_fish_2,s_fish_3,s_fish_4)
mask_index = s_fish_collision

floatZ = 32

//drawShadow = false

interactibility = false

maxMovespeed = 1

if place_meeting(x,y,collisionMap) and map == -1 {
	var list = ds_list_create()
	var count = instance_place_list(x,y,collisionMap,list,true)
	var highestMap = -1
	for(var i=0;i<count;i++) {
		var ID = list[| i]
		if highestMap == -1 or ID.z+ID.height > highestMap.z+highestMap.height {
			highestMap = ID	
		}
	}
	if highestMap > -1 {
		map = highestMap
		y += map.z
		z = map.z
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