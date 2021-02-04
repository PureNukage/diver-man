event_inherited()

interactibility = true
npcKey = "default"
npcSprite = s_brother_face
inConversation = false
dialogueIndex = -1

moving = false
freemove = false

load_dialogue()

function move_to(_x, _y) {
	
	//	What mp_grid am I using?
	var Grid = -1
	if map > -1 {
		var Z = z
		if map.ramp {
			Z = map.z
		}
		var Index = grid.return_z_index(Z)
		if Index > -1 {
			Grid = grid.mp_grids[Index, 0]
		}
	}
	else Grid = grid.mpGrid
	
	if pathfind(Grid,path, x,y, _x,_y, true) {
		pos = 1
		xGoto = path_get_point_x(path,pos)
		yGoto = path_get_point_y(path,pos)
		moving = true
		return true
	}
	else {
		//	If we're on a ramp
		if map > -1 and map.ramp {
			//	and the x,y is in a valid cell
			if mp_grid_get_cell(Grid,_x/grid.cellWidth,_y/grid.cellHeight) == 0 {
				freemove = true
				moving = true
				xGoto = _x
				yGoto = _y
				debug.log("Free moving!")
			}
			//	the x,y is not a valid cell, lets see though if our stairs leads to it
			else {
				//	is the cell to the left of it our stairs
				var Cell = new cell_create(_x-16,_y)
				if Cell.map == map {
					freemove = true
					moving = true
					xGoto = _x
					yGoto = _y
					debug.log("Free moving")
				}
			}
		}
			
		return false	
	}
}

function _moving() {
	
	//	Grid-moving
	if !freemove {
		//	Arrived at point in path
		var Dist = floor(point_distance(x,y, xGoto,yGoto))
		if floor(point_distance(x,y, xGoto,yGoto)) < 2 {
			//	Arrived at destination
			if pos++ >= path_get_number(path)-1 {
				moving = false
			}
			//	Another point in the path
			else {
				xGoto = path_get_point_x(path,pos)
				yGoto = path_get_point_y(path,pos)
			}
		}
		//	Keep moving to next point
		else {
			moveForce += .10
			moveForce = clamp(moveForce,-maxMovespeed,maxMovespeed)
			moveDirection = point_direction(x,y,xGoto,yGoto)
			setForce(moveForce, moveDirection)
			if xGoto > x image_xscale = 1
			else image_xscale = -1
		}
	}
	//	Fre-moving
	else {
		if point_distance(x,y, xGoto,yGoto) < 2 {
			moving = false
			freemove = false
		}
		else {
			moveForce += .10
			moveForce = clamp(moveForce,-maxMovespeed,maxMovespeed)
			moveDirection = point_direction(x,y,xGoto,yGoto)
			setForce(moveForce, moveDirection)
			if xGoto > x image_xscale = 1
			else image_xscale = -1
		}
	}
}
	
function random_move(distance) {
	var ran_x = irandom_range(x-distance,x+distance)
	var ran_y = irandom_range(y-distance,y+distance)
	if move_to(ran_x,ran_y) {
			
	}
	else debug.log("Cannot pathfind here!")
}