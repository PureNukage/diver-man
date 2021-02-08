event_inherited()

hspd = input.keyArrowRight - input.keyArrowLeft
vspd = input.keyArrowDown - input.keyArrowUp

if (hspd != 0 or vspd != 0) {
	moveForce += 0.10
	moveForce = clamp(moveForce,0,maxMovespeed)
	moveDirection = point_direction(0,0,hspd,vspd)
	setForce(moveForce, moveDirection)
}

applyMovement()

if onGround {
	x = groundX
	y = groundY + z
}
else {
	x = groundX	
}