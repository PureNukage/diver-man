depth = player.depth + 1

keyUp = keyboard_check(vk_up)
keyDown = keyboard_check(vk_down)

var minSegments = point_distance(x,y, player.x,player.y)/ropeLengthMin
var segmentSlack = 0
if minSegments > 3 {
	if minSegments > 7 and verticeCount > minSegments+segmentSlack {
		delete_vertex(1)
		//debug.log("deleting vertex")
	}
	else if instance_exists(cage) and cage.filled and cage.inUse and verticeCount > 4 {
		delete_vertex(1)
	}
	
}

var buffer = 128
x = anchorX
y = anchorY
x = clamp(x, app.cameraX1-buffer, app.cameraX2+buffer)
y = clamp(y, app.cameraY1-buffer, app.cameraY2+buffer)

reel--
//	Loop through vertices
var length = 0 
for(var i=0;i<verticeCount;i++) {
	//var previousVertex = vertices[| i+1]
	var vertex = vertices[| i]	
	var nextVertex = vertices[| i-1]
		
		//	Vertice other than the first
		if i > 0 {

			//var reelAmount = 10
			// If this is the last node
			if i == verticeCount - 1 {
				if verticeCount > ropeMaxSegments {
					vertex.x = x
					vertex.y = y
				}
				else 
				//	Create a new node if we're far enough away from the anchor
				if point_distance(vertex.x,vertex.y, x,y) >= ropeLengthMin {
					create_vertex(x,y)	
				}
					
			}
		
			update_vertices(vertex, nextVertex)
		
			update_sticks(vertex, nextVertex)
		
			collision_check_stick(vertex, nextVertex)
			
			////	Check z collision
			//var ID = collision_point(vertex.x,vertex.y, collisionMap, true,true)
			//if ID and vertex.y < (ID.bbox_top + ID.width + 16) {
			//	vertex.z = ID.z
			//}
			//else {
			//	vertex.z = 0	
			//}

			
		length += point_distance(vertex.x,vertex.y, nextVertex.x,nextVertex.y)
		
	//	The player vertice
	} else if i == 0 {
		if player.sprite_index == s_diverman_sprint {
			vertex.x = player.x + (player.image_xscale * 8)	
			vertex.y = player.y-player.z-55
		}
		else {
			vertex.x = player.x
			vertex.y = player.y-player.z-59
		}
		//vertex.z = player.z + 59
	}
}
ropeLength = length
if reel <= -1 reel = 60
