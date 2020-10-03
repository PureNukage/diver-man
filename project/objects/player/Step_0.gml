if !app.paused {
	image_speed = 1
	if !muted {
	
		visible = true

		hspd = input.keyRight - input.keyLeft
		vspd = input.keyDown - input.keyUp
		
		if !suitOn sprite_index = s_kid_player

		if (hspd != 0 or vspd != 0) {
			moveDirection = point_direction(0,0,hspd,vspd)
			moveForce += 1
			moveForce = clamp(moveForce,0,2)

			setForce(moveForce, moveDirection)
	
			if hspd != 0 image_xscale = hspd * xscale
	
			////	Footprints
			if sprite_index == s_diverman_walk and onGround {
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
						var Footprint = createParticle(X,groundY, particles.footprint, 180, 0)
						Footprint.sprite_index = s_footprint
						Footprint.image_xscale = round(image_xscale)
						Footprint.z = z
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
				//if sprite_index != s_diverman_idle {
				//	sprite_index = s_diverman_idle
				//	image_index = 0
				//}
			}
		}
	
		////	Jumping
		if input.keyJump and onGround {
			setThrust(5)	
		}

		if !onGround applyThrust()

		////	Determine sprite
		if onGround {
			//	Moving
			if (hspd != 0 or vspd != 0) {
				if suitOn {
					if sprite_index != s_diverman_walk {
						sprite_index = s_diverman_walk
						image_index = 0
					}
				}
			}
			//	Not moving
			else {
				if suitOn {
					if moveForce == 0 and sprite_index != s_diverman_idle {
						sprite_index = s_diverman_idle
						image_index = 0
					}	
				}
			}
		} 
		//	In the air
		else {
			if thrust > 0 {
				if suitOn sprite_index = s_diverman_jump	
			}
			else {
				if suitOn sprite_index = s_diverman_fall	
			}
			//sprite_index = s_diverman_idle_frozen
		}

		applyMovement()

		if onGround {
			x = groundX
			y = groundY + z
		} else {
			x = groundX	
		}

		depth = -y

		if app.underwater bubbles(false)
	}
	else visible = false
}
else {
	image_speed = 0
}