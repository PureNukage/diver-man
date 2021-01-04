image_speed = 1
switch(state)
{
	#region Free/Idle
		case state.free:
			
			//	Finished idling
			if timer == -1 {
				
				idlewalk()
				
			}
			else timer--
			
		break
	#endregion
	
	#region Walk
		case state.walk:
		
			moveDirection = point_direction(groundX,groundY,xGoto,yGoto)
			
			if point_distance(groundX,groundY, xGoto,yGoto) < 4 {
				if pos++ >= path_get_number(path) - 1 {
					state = state.free
					timer = irandom_range(60,90)
				}
				
				else {
					xGoto = path_get_point_x(path, pos)
					yGoto = path_get_point_y(path, pos)	
				}
			}
			
			else {
				moveForce += 0.5
				moveForce = clamp(moveForce,0,2)
				setForce(moveForce, moveDirection)
				
			}
			
			if xx > 0.25 {
				image_xscale = 1
			} if xx < -0.25 {
				image_xscale = -1	
			}
			
		break
	#endregion
}
	
//	Check for damage
mask_index = s_shark_swim
if !damaged and place_meeting(x,y, player) and player.state == state.attack and player.image_index < 4 {
	depth = player.depth + 1
	setDamage(1, 15)
	knockbackForce = 5
	knockbackDirection = point_direction(player.x,player.y, x,y)
}
mask_index = s_shark_collision
if damaged applyDamage()
	
if knockbackForce > 0 {
	setForce(knockbackForce, knockbackDirection)
	knockbackForce--	
}

var oldX = groundX
var oldY = groundY

applyMovement()

if state == state.walk {
	if oldX == groundX and oldY == groundY { 
		attemptingToMove++
		
		if attemptingToMove >= 180 {
			idlewalk()
			attemptingToMove = 0
		}
	}
}

x = groundX
y = groundY + z

depth = -y
