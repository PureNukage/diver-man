if !muted {
		
	player.groundX = x
	player.x = x
	player.y = y
		
	if backgroundX >= 450 {
		adultManager.on = false
		with adult {
			var border = 100
			if x < app.cameraX1-border or x > app.cameraX2+border or y < app.cameraY1-border or y > app.cameraY2+border {
				instance_destroy()	
			}
		}
	}
	//if backgroundX >= 750 and !instance_exists(adult) {
	//	room_goto(RoomCityAndDock)
	//	app.cameraRefresh = true
	//}
	
	//	Sprinting
	if input.keyRun {
		if !running {
			running = true
		}
	}
	else if running {
		running = false	
	}
	
	if running maxMovespeed = 3.5
	else maxMovespeed = 2.5
		
	//	Collision with adult
	if place_meeting(x,y,adult) and !knocked and grounded == 0 {
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
	else if !knocked and grounded == 0 {
		if (vspd != 0 or hspd != 0) {
			if !running sprite_index = s_kid_player_walk
			else sprite_index = s_kid_player_running
		}
		else sprite_index = s_kid_player
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
		moveForce = clamp(moveForce,0,maxMovespeed)
			
		if hspd > 0 and backgroundX < 301 {
			backgroundX += hspd
			layer_x("Background", layer_get_x("Background") - moveForce)
			if instance_exists(adult) with adult x -= other.moveForce
		}
			
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
		
	var oldX = groundX
	applyMovement()
	if backgroundX < 300 groundX = oldX

	if onGround {
		x = groundX
		y = groundY + z
	} else {
		x = groundX	
	}

	depth = -y

		
}
else visible = false