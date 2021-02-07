event_inherited()

if !onGround applyThrust()

//if place_meeting(x,y,collisionMap) {
//	var ID = instance_place(x,y,collisionMap)
//	if z < ID.z + ID.height {
//		z = ID.z + ID.height	
//	}
//}

switch(stage) {
	//	Growing larger
	case 0:
		var Lerp = 0.03
		image_xscale = lerp(image_xscale,1,Lerp)
		image_yscale = lerp(image_yscale,1,Lerp)
		if image_xscale > 0.9 and image_yscale > 0.9 {
			image_xscale = 1
			image_yscale = 1
			stage = 1
		}
	break
	//	Now collectable!
	case 1:
		var Dist = 100
		if instance_exists(player) and point_distance(x,y,player.x,player.y) < Dist {
			moveDirection = point_direction(x,y,player.x,player.y)
			moveForce += 0.1
			moveForce = clamp(moveForce,0,maxMovespeed)
			setForce(moveForce, moveDirection)
			if place_meeting(x,y,player) {
				//app.gold++
				//player.gold++
				sound.playSoundEffect(sound_coins)
				stage = 2
				gui_x = x - camera_get_view_x(app.camera)
				gui_y = y - z - floatZ - camera_get_view_y(app.camera)
				//instance_destroy()
			}
		}

		else {
			if moveForce > 0 {
				moveForce--
				moveForce = clamp(moveForce,0,maxMovespeed)
				setForce(moveForce, moveDirection)
			}
		}
		applyMovement()
	break
}

if onGround {
	x = groundX
	y = groundY + z
}
else {
	x = groundX
}

//depth = -20000