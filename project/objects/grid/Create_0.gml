mpGrid = -1

function mpGrid_build() {
	
	cellWidth = 16
	cellHeight = 16
	
	gridWidth = room_width / cellWidth
	gridHeight = room_height / cellHeight
	
	if mpGrid > -1 mp_grid_destroy(mpGrid)
	
	mpGrid = mp_grid_create(0,0,gridWidth,gridHeight,cellWidth,cellHeight)
	
	if instance_exists(collision) mp_grid_add_instances(mpGrid,collision,false)
	
	//if instance_exists(collisionMap) mp_grid_add_instances(mpGrid,collisionMap,false)
	
}

mpGrid_build()