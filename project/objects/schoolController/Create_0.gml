event_inherited()

count = 8
width = 512
height = 512

interactibility = false

maxMovespeed = 1

for(var i=0;i<count;i++) {
	var Fish = instance_create_layer(irandom_range(x-width/2,x+width/2),irandom_range(y-height/2,y+height/2),"Instances",fish)
	Fish.school = id
}

function player_check() {
	if instance_exists(player) {
		if (abs(player.moveForce) > 1) and point_distance(x,y, player.x,player.y) < width {
			var DirectionAwayFromPlayer = point_direction(player.x,player.y, x,y)
			var DirectionWiggleRoom = 45
			var RandomDirection = irandom_range(DirectionAwayFromPlayer-DirectionWiggleRoom, DirectionAwayFromPlayer+DirectionWiggleRoom)
			var rangeMax = 128
			var rangeMin = 64
			var randomRange = irandom_range(rangeMin, rangeMax)
			var randomX = x + lengthdir_x(randomRange, RandomDirection)
			var randomY = y + lengthdir_y(randomRange, RandomDirection)
			if move_to(randomX,randomY) {
				timer = -1	
			}
			debug.log("swimming away from player!")
		}
	}
}