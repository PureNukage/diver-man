//	Draw vertices
draw_reset()
//draw_set_color(c_green)
//for(var i=0;i<verticeCount;i++) {
//	var vX = vertices[| i].x
//	var vY = vertices[| i].y	
//	draw_circle(vX,vY, 4, false)
//}

////	Draw sticks
//for(var i=0;i<verticeCount-1;i++) {
//	var x1 = vertices[| i].x
//	var y1 = vertices[| i].y
//	var x2 = vertices[| i+1].x
//	var y2 = vertices[| i+1].y
//	draw_line(x1,y1, x2,y2)
//}

//	Draw rope
draw_set_color(c_red)
var path = path_add()
path_set_kind(path, 1)
path_set_closed(path, false)
path_set_precision(path, 8)

//	Adjust the last hose segment so it matches the divers helmet
if player.sprite_index == s_diverman_sprint {
	var vx = player.x + (player.image_xscale * 8)	
	var vy = player.y-player.z-55
} else if player.sprite_index == s_diverman_attack {
	if player.image_index == 1 {
		var vx = player.x + (player.image_xscale * 8)
		var vy = player.y-player.z-55
	}
	else if player.image_index > 1 and player.image_index < 6 {
		var vx = player.x + (player.image_xscale * 12)
		var vy = player.y-player.z-55
	}
	else {
		var vx = player.x
		var vy = player.y-player.z-59	
	}
}
else {
	var vx = player.x
	var vy = player.y-player.z-59
}
path_add_point(path, vx,vy, 100)
for(var i=0;i<verticeCount;i++) {
	var X = vertices[| i].x
	var Y = vertices[| i].y
	var Z = vertices[| i].z
	path_add_point(path, vertices[| i].x,vertices[| i].y - vertices[| i].z, 100)
}
draw_path_sprite(path, s_hose_2, 0)
//draw_path(path, x,y, true)
path_delete(path)

//	Draw text
//draw_set_color(c_black)
//draw_text(15,15,"ropeLength: "+string(ropeLength))