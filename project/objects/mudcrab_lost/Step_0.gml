event_inherited()

if stage0map < 0 {
	stage0map = instance_place(1600,1970,collisionMap)	
}
if stage1map < 0 {
	stage1map = instance_place(1749,2004,collisionMap)
}
if stage2map < 0 {
	stage2map = instance_place(1826,1949,collisionMap)	
}

switch(stage) {
	case 0:
		if map == stage0map {
			stage = 1
		}
	break
	case 1:
		if map == stage1map stage = 2
	break
	case 2:
		if map == stage2map stage = 3
	break
	case 3:
	
	break
}

switch(state) {
	case state.free:
	
		//	Knocked up by player jumping
		stunCheck()
		
		if timer > -1 timer--
		else {
			//	Walk up and down
			if !moving {
				var _x = x
				var _y = y
				movingStage = !movingStage
				switch(stage) {
					case 0:
						//	retreating
						if movingStage == 0 {
							_x = 1487
							_y = 2064
						}
						else if movingStage == 1 {
							_x = 1632
							_y = 2064
						}
					break
					case 1:
						//	retreating
						if movingStage == 0 {
							_x = 1599
							_y = 2064
						}
						else {
							_x = 1727
							_y = 2064
						}
					break
					case 2:
						//	retreating
						if movingStage == 0 {
							_x = 1727
							_y = 2064
						}
						else {
							_x = 1822
							_y = 2064
						}
					break
					case 3:
						instance_create_layer(x,y-z,"Instances",mudcrab)
						instance_destroy()
						//	Create gold coin
						var Coin = instance_create_layer(x,y-z,"Instances",coin)
						Coin.setThrust(5)
					break
				}
				free_move(_x, _y) 
			}
			else {
				
				if point_distance(x,y,xprevious,yprevious) < 0.5 {
					attemptingToMove++	
				}
				if attemptingToMove >= 100 {
					attemptingToMove = 0
					moving = false
				}
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
