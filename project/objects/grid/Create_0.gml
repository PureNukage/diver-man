mpGrid = -1
hoseGrid = -1
hoseGrid2 = -1
hoseGrid3 = -1

cell = [[]]

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
	if instance_exists(collisionMap) with collisionMap {
		//mp_grid_add_instances(mpGrid,collisionMap,false)
		var X = floor(bbox_left/grid.cellWidth)
		var Y = floor((bbox_top+z)/grid.cellHeight)
		var Width = ((bbox_right-bbox_left)/grid.cellWidth)
		var Height = (bbox_bottom - (bbox_top+z))/grid.cellHeight
		for(var w=X;w<X+Width;w++) {
			for(var h=Y;h<Y+Height;h++) {
				//var pX = (w*grid.cellWidth) + 1
				//var pY = (h*grid.cellHeight) + 1
				mp_grid_add_cell(grid.mpGrid,w,h)
			}
		}
	}
	
	if instance_exists(collision) mp_grid_add_instances(hoseGrid2,collision,false)
	//if instance_exists(collisionMap) mp_grid_add_instances(hoseGrid,collisionMap,false)
	
	
	////	Build z-map
	for(var w=0;w<gridWidth;w++) {
		for(var h=0;h<gridHeight;h++) {
			cell[w, h] = new tile_info(0,0)
			cell[w, h].map = -1
		}
	}
	
	if instance_exists(collisionMap) with collisionMap {
		if height == 48 {
			var Break = 0	
		}
		var Width = bbox_right-bbox_left
		var Height = bbox_bottom-(bbox_top+z)
		var cellsW = floor(Width/grid.cellWidth)+1
		var cellsH = floor(Height/grid.cellHeight)+1
		var startX = floor(bbox_left/grid.cellWidth)
		var startY = floor((bbox_top+z)/grid.cellHeight)
		for(var w=startX;w<cellsW+startX;w++) {
			for(var h=startY;h<cellsH+startY;h++) {
				var _cellHeight = (height / grid.cellHeight)
				//if _cellHeight > 0 _cellHeight -= 1
				//	Only place this if its taller than whats there
				if z+height > grid.cell[w, h+_cellHeight].top {
					grid.cell[w, h+_cellHeight] = new tile_info(0,z+height)
					grid.cell[w, h+_cellHeight].map = id
				}
			}
		}
	}
	
}

mpGrid_build()