duration = -1
durationMax = -1
Speed = -1
particles = -1
z = 0
moveDirection = 45
temporary = true

burstTimer = -1
burstGoalX = -1
burstGoalY = -1
burstGoalX = x + lengthdir_x(50, moveDirection)
burstGoalY = y + lengthdir_y(50, moveDirection)
function burst() {
	var Lerp = 0.03
	x = lerp(x, burstGoalX, Lerp)
	y = lerp(y, burstGoalY, Lerp)
	
	if point_distance(x,y, burstGoalX,burstGoalY) < 2 {
		burstTimer = 45
		burstGoalX = x + lengthdir_x(50, moveDirection)
		burstGoalY = y + lengthdir_y(50, moveDirection)
	}
}
