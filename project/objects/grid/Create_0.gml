mpGrid = -1
hoseGrid = -1
hoseGrid2 = -1
hoseGrid3 = -1

function mpGrid_build() {
	
	cellWidth = 16
	cellHeight = 16
	
	gridWidth = room_width / cellWidth
	gridHeight = room_height / cellHeight
	
	if mpGrid > -1 mp_grid_destroy(mpGrid)
	if hoseGrid > -1 mp_grid_destroy(hoseGrid)
	if hoseGrid2 > -1 mp_grid_destroy(hoseGrid2)
	if hoseGrid3 > -1 mp_grid_destroy(hoseGrid3)
	
	hoseCW = 8
	hoseCH = 8
	gW = room_width / hoseCW
	gH = room_height / hoseCH
	
	hoseGrid = mp_grid_create(0,0,gridWidth*2,gridHeight*2,cellWidth/2,cellHeight/2)
	hoseGrid2 = mp_grid_create(0,0,gW,gH,hoseCW,hoseCH)
	hoseGrid3 = mp_grid_create(0,0,room_width/96,room_height/96,96,96)
	
	mpGrid = mp_grid_create(0,0,gridWidth,gridHeight,cellWidth,cellHeight)
	
	if instance_exists(collision) mp_grid_add_instances(mpGrid,collision,false)
	if instance_exists(collisionMap) mp_grid_add_instances(mpGrid,collisionMap,false)
	
	if instance_exists(collision) mp_grid_add_instances(hoseGrid2,collision,false)
	//if instance_exists(collisionMap) mp_grid_add_instances(hoseGrid,collisionMap,false)
	
}

mpGrid_build()