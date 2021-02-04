event_inherited()

switch(state) {
	case state.free:
		
		if !moving {
			if timer > -1 {
				player_check()
				timer--
			}
			else {
				random_move(128)
				timer = irandom_range(30,60)
			}
		}
		else {
			if point_distance(x,y,xprevious,yprevious) < 1 {
				attemptingToMove++	
			}
			if attemptingToMove >= 100 {
				if timer > -1 timer--
				else {
					attemptingToMove = 0
					moving = false
				}
			}	
		}
		
	break
}