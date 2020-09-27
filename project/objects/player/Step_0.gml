hspd = input.keyRight - input.keyLeft
vspd = input.keyDown - input.keyUp

if (hspd != 0 or vspd != 0) {
	moveDirection = point_direction(0,0,hspd,vspd)
	moveForce += 1
	moveForce = clamp(moveForce,0,2)

	setForce(moveForce, moveDirection)
	
	if hspd != 0 image_xscale = hspd * xscale
	
	if sprite_index != s_diverman_walk {
		sprite_index = s_diverman_walk
		image_index = 0
	}
	else {
		////	Footprints
		if floor(image_index) == 2 or floor(image_index) == 6 {
			if !madeFootprint {
				switch(sign(image_xscale))
				{
					//	Facing Right
					case 1:
						//	Right foot
						if floor(image_index) == 2 {
							var X = x
						} 
						//	Left foot
						else {
							var X = x - 18
						}
					break
					//	Facing Left
					case -1:
						//	Right foot
						if floor(image_index) == 6 {
							var X = x + 18
						} 
						//	Left foot
						else {
							var X = x
						}
					break
				}
				var Footprint = createParticle(X,y, particles.footprint, 180, 0)
				Footprint.sprite_index = s_footprint
				Footprint.image_xscale = round(image_xscale)
				madeFootprint = true
			}
		}
		//	Not stepping
		else {
			if madeFootprint madeFootprint = false
		}
	}
} 
//	Not inputting 
else {
	if moveForce > 0 {
		moveForce--
	}
	else {
		if sprite_index != s_diverman_idle {
			sprite_index = s_diverman_idle
			image_index = 0
		}
	}
}

applyMovement()

x = groundX
y = groundY

depth = -y


bubbles()