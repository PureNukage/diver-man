event_inherited()

mask_index = sprite_index

interactibility = true
npcKey = "default"
npcSprite = s_brother_face
inConversation = false
dialogueIndex = -1

hasDialogue = true

moving = false
freemove = false

load_dialogue()

emoting = false
emoteTimer = 0
emoteIndex = -1
function emote(index, duration) {
	emoteIndex = index
	emoteTimer = duration
	emoting = true
}
function _emote() {
	var Scale = 0.5
	draw_sprite_ext(emoteIndex,0,x,interactableY-40, Scale,Scale, 0,c_white,1)
	if is_string(emoteTimer) and emoteTimer == "~" {
		
	}
	else if emoteTimer > 0 emoteTimer--
	else if emoteTimer == 0 {
		emoting = false
		emoteIndex = -1
	}
}

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
	
	////	Fish schools
	if object_index == fish and school > -1 {
		if !point_in_rectangle(_x,_y, school.x-school.width/2,school.x+school.width/2, school.y-school.height/2,school.y+school.height/2) {
			_x = irandom_range(school.x-school.width/2,school.x+school.width/2)	
			_y = irandom_range(school.y-school.height/2,school.y+school.height/2)
		}
		//_x = clamp(_x, school.x-school.width/2,school.x+school.width/2)
		//_y = clamp(_y, school.y-school.height/2,school.y+school.height/2)
	}
	
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
				if point_in_rectangle(_x-16,_y, 0,0,room_width,room_height) {
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
		}
			
		//	If the _x,_y are in my grid
		if mp_grid_get_cell(Grid, floor(_x/grid.cellWidth),floor(_y/grid.cellHeight)) == 0 {
			freemove = true
			moving = true
			xGoto = _x
			yGoto = _y
			debug.log("Free moving!")
		}
			
		return false	
	}
}

function _moving() {
	
	//	Grid-moving
	if !freemove {
		//	Arrived at point in path
		//var Dist = floor(point_distance(x,y, xGoto,yGoto))
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
	//	Free-moving
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
	
	//////	Fish schools
	//if object_index == fish and school > -1 {
	//	ran_x = clamp(ran_x, school.x-school.width/2,school.x+school.width/2)
	//	ran_y = clamp(ran_y, school.y-school.height/2,school.y+school.height/2)
	//}
	
	if move_to(ran_x,ran_y) {
		return true	
	}
	else {
		return false	
		debug.log("Cannot pathfind here!")
	}
}
	
function free_move(_x, _y) {
	freemove = true
	pos = 1
	xGoto = _x
	yGoto = _y
	moving = true
}
	
function mapcheck() {
	if place_meeting(x,y,collisionMap) and map == -1 {
		var list = ds_list_create()
		var count = instance_place_list(x,y,collisionMap,list,true)
		var highestMap = -1
		for(var i=0;i<count;i++) {
			var ID = list[| i]
			if highestMap == -1 or ID.z+ID.height > highestMap.z+highestMap.height {
				highestMap = ID	
			}
		}
		if highestMap > -1 {
			map = highestMap
			y += map.z
			z = map.z
		}
	}	
}
	
mapcheck()