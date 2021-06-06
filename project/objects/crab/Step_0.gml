switch(state) 
{
	#region Free
		case state.free:
			
			stunCheck()
			
			//if timer == -1 {
			//	idlewalk()	
			//} else timer--
			
			//	Run to next node
			if !flee and point_distance(x,y, player.x,player.y) < 200 and player.z == z {
				changeNode()
			}
			
		break
	#endregion
		
	#region Walk 
		case state.walk:
			
			stunCheck()
				
			moveDirection = point_direction(groundX,groundY,xGoto,yGoto)
			
			//	If player is in between crab and next node
			if !flee and point_in_rectangle(player.x,player.y, x,y, nodes[0,currentNode],nodes[1,currentNode]) and player.z == z {
				reverseNode()
			}
			
			if point_distance(groundX,groundY, xGoto,yGoto) < 4 {
				if pos++ >= path_get_number(path) - 1 {
					if flee {
						instance_destroy()	
					}
					else {
						state = state.free
						timer = irandom_range(60,90)
					}
				}
				
				else {
					xGoto = path_get_point_x(path, pos)
					yGoto = path_get_point_y(path, pos)	
				}
			}
			
			else {
				moveForce += 0.5
				moveForce = clamp(moveForce,0,maxMovespeed)
				setForce(moveForce, moveDirection)
				
			}
			
			if xx > 0.25 {
				image_xscale = 1
			} if xx < -0.25 {
				image_xscale = -1	
			}
			
		break
	#endregion
		
	#region Stunned
		case state.stunned:
				
			if onGround {
				sprite_index = s_crab_insand
				if timer > -1 timer--
				else {
					if pathfind(grid.mpGrid,path, x,y, fleeX,fleeY, true)	{
						state = state.walk
						pos = 1 
						xGoto = path_get_point_x(path,pos)
						yGoto = path_get_point_y(path,pos)
						flee = true
					}
					sprite_index = s_crab
				}
			}
				
		break
	#endregion
}
	
if !onGround applyThrust()
	
applyMovement()
	
if onGround {
	x = groundX
	y = groundY + z
} else {
	x = groundX	
}

depth = -y
