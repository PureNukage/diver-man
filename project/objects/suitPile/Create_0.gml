event_inherited()

depthY = false

drawShadow = false
interactability = true
interactable = false

var ID = collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,crate,true,true)
if ID > - 1 {
	depth = ID.depth - 1	
}
//if place_meeting(x,y,crate) {
//	var ID = instance_place(x,y,crate)
//	depth = ID.depth - 1
//}