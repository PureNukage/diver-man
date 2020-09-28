switch(state)
{
	#region Free/Idle
		case state.free:
			
			//	Finished idling
			if timer == -1 {
				
				//	Find goal
				var distance = 250
				var X = irandom_range(groundX-distance,groundX+distance)
				var Y = irandom_range(groundY-distance,groundY+distance)
				
				if !place_meeting(X,Y,collision) and !place_meeting(X,Y,collisionMap) {
					if pathfind(grid.mpGrid, path, groundX,groundY, X,Y, true) {
						debug.log("Idle walking")
						debug.log("this path has "+string(path_get_number(path))+" points")
						state = state.walk
						pos = 1
						//path_set_precision(path,8)
						xGoto = path_get_point_x(path, pos)
						yGoto = path_get_point_y(path, pos)
					}
				}
				
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
			
			if xx > 0 {
				image_xscale = 1
			} if xx < 0 {
				image_xscale = -1	
			}
			
		break
	#endregion
}

applyMovement()

x = groundX
y = groundY + z

depth = -y