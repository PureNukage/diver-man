if !app.paused {
	//image_speed = 1
	if !muted {
		
		player.groundX = x
		player.x = x
		player.y = y
		
		if input.keyInteractHold and !knocked and grounded == 0 {
			dancing = true
			sprite_index = s_player_kid_dance
		}
		else if !knocked and grounded == 0 {
			sprite_index = s_kid_player
			dancing = false
		} 
		
		if knocked or grounded > 0 and dancing dancing = false
		
		//	Dancing adult check
		var width = 120
		var height = 90
		var Adult = collision_rectangle(x-width/2,y-height/2,x+width/2,y+height/2, adult, true,true)
		if dancing and Adult {
			if !Adult.payingAttention and !Adult.notPaying {
				var chance = choose(0,1,2)
				if chance == 0 {
					Adult.payingAttention = true
				}
				else Adult.notPaying = true
				currentCustomer = Adult
			}
		}
		else if currentCustomer > -1 {
			currentCustomer.payingAttention = false
			currentCustomer.notPaying = true
			currentCustomer = -1
		}
		
		//	Collision with adult
		if place_meeting(x,y,adult) and !knocked and grounded == 0 {
			var Adult = instance_place(x,y,adult)
			Adult.notPaying = true
			knocked = true
			setThrust(3)
			hspd = 0
			vspd = 0
		}
		
		if knocked and !onGround {
			sprite_index = s_player_kid_knocked	
		}
		else if knocked and onGround {
			knocked = false
			grounded = 45
			sprite_index = s_player_kid_onground
		}
	
		visible = true
		
		if !instance_exists(response) and !knocked and grounded == 0 {
			hspd = (input.keyRight - input.keyLeft) + input.gamepadAxisLH
			vspd = (input.keyDown - input.keyUp) + input.gamepadAxisLV
		}
		
		if grounded > 0 grounded--
		
		//if !suitOn sprite_index = s_kid_player

		if (hspd != 0 or vspd != 0) {
			moveDirection = point_direction(0,0,hspd,vspd)
			moveForce += 0.10
			moveForce = clamp(moveForce,0,2)
			
			//if moveForce == 2 moveForce = 0

			setForce(moveForce, moveDirection)
	
			if hspd != 0 image_xscale = sign(hspd) * xscale
			
			image_speed = (moveForce/2)
			image_speed = clamp(image_speed,.5,1)
		} 
		//	Not inputting 
		else {
			if moveForce > 0 {
				moveForce--
			}
			else {
				image_speed = 1
				moveForce = 0
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

			}
			//	Not moving
			else {

			}
		} 
		//	In the air
		else {
			if thrust > 0 {
				//if suitOn sprite_index = s_diverman_jump	
			}
			else {
				//if suitOn sprite_index = s_diverman_fall	
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

		
	}
	else visible = false
}
else {
	image_speed = 0
}