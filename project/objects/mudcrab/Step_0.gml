event_inherited()

switch(state) {
	case state.free:
	
		//	Knocked up by player jumping
		stunCheck()
		
		//	Walk up and down
		if !moving {
	
			//	On a map
			if map > -1 {
		
				var ran_x = irandom_range(x-16,x+16)
				var ran_y = irandom_range(y-16,y+16)
				move_to(ran_x,ran_y)
		
			}
	
		}
		else {
			if point_distance(x,y,xprevious,yprevious) < 1 {
				attemptingToMove++	
			}
			if attemptingToMove >= 100 {
				attemptingToMove = 0
				moving = false
			}
		}
	break
	case state.stunned:
		if timer > -1 timer--
		else {
			state = state.free	
		}
	break
}
