event_inherited()

interactibility = true
npcKey = "default"
npcSprite = s_brother_face
inConversation = false
dialogueIndex = -1

moving = false

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
		return false	
	}
}

function _moving() {
	//	Arrived at point in path
	if point_distance(x,y, xGoto,yGoto) < 2 {
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
		//mp_potential_step_object(xGoto,yGoto,moveForce,collision)
		if xGoto > x image_xscale = 1
		else image_xscale = -1
	}
}