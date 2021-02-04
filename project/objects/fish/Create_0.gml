event_inherited()

sprite_index = choose(s_fish_1,s_fish_2,s_fish_3,s_fish_4)
mask_index = s_fish_collision

floatZ = 32

//drawShadow = false

interactibility = false

maxMovespeed = 1

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