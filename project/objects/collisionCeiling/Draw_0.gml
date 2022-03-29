if sprite_exists(sprite) {
	var extraSpace = 100
	if collision_rectangle(bbox_left-extraSpace,bbox_top-extraSpace,bbox_right+extraSpace,bbox_bottom+extraSpace,player,true,true) draw_sprite(sprite,0,x,y)
}