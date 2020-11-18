event_inherited()

shadeStatic = false
detectCollision = false

maxMovespeed = 5

state = state.free

knocked = false
grounded = 0

nodes = [[]]
nodes[0,0] = 850
nodes[1,0] = 120

nodes[0,1] = 1260
nodes[1,1] = 120

nodes[0,2] = 1260
nodes[1,2] = 413

nodes[0,3] = 850
nodes[1,3] = 413 

holdingWatch = true

currentNode = 0

function changeNode() {
	//	Which node is the player closer to
	var nextNode = currentNode + 1
	if nextNode > 3 nextNode = 0
	var previousNode = currentNode - 1
	if previousNode < 0 previousNode = 3
	
	var distanceNextNode = point_distance(player.x,player.y, nodes[0, nextNode],nodes[1, nextNode])
	var distancePreviousNode = point_distance(player.x,player.y, nodes[0, previousNode],nodes[1, previousNode])
	
	if distanceNextNode > distancePreviousNode { 
		if pathfind(grid.mpGrid,path, x,y, nodes[0,nextNode],nodes[1,nextNode],true) {
			state = state.walk
			pos = 1
			xGoto = path_get_point_x(path, pos)
			yGoto = path_get_point_y(path, pos)
			currentNode = nextNode
		}
	}
	else {
		if pathfind(grid.mpGrid,path, x,y, nodes[0,previousNode],nodes[1,previousNode],true) {
			state = state.walk
			pos = 1
			xGoto = path_get_point_x(path, pos)
			yGoto = path_get_point_y(path, pos)
			currentNode = nextNode
		}	
	}
}

function reverseNode() {
	var nextNode = currentNode - 1
	if nextNode < 0 nextNode = 3
	
	if pathfind(grid.mpGrid,path, x,y, nodes[0,nextNode],nodes[1,nextNode], true) {
		state = state.walk
		pos = 1
		xGoto = path_get_point_x(path, pos)
		yGoto = path_get_point_y(path, pos)
		currentNode = nextNode
	}
}
	
function stunCheck() {
	if point_distance(x,y, player.x,player.y) < 30 and player.jumpHaltDuration > -1 {
		state = state.stunned
		sprite_index = s_crab_knocked
		setThrust(5)
		if holdingWatch { 
			var Watch = instance_create_layer(x,y-30,"Instances",watch)
			with Watch setThrust(8)
		}
		holdingWatch = false
		timer = 90
	}
}