event_inherited()

attemptingToMove = 0

state = state.free


function idlewalk() {
	//	Find goal
	var distance = 250
	var X = irandom_range(groundX-distance,groundY+distance)
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