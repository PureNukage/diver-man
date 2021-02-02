event_inherited()

//	Walk up and down
if !moving {
	
	var _x = x
	var _y = y
	
	//	On a map
	if map > -1 {
		
		var Index = grid.return_z_index(z)
		
		var ran_x = irandom_range(x-16,x+16)
		var ran_y = irandom_range(y-16,y+16)
		move_to(ran_x,ran_y)
		
		////	Closer to the left side
		//if abs(x - map.bbox_left) < abs(x - map.bbox_right) {
		//	_x = map.bbox_right-5	
		//}
		//else {
		//	_x = map.bbox_left+5
		//}
		//move_to(_x,_y)
	}
	
}