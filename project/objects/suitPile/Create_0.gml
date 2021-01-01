event_inherited()

depthY = false

drawShadow = false
interactibility = true
interactable = false

if place_meeting(x,y,crate) {
	var ID = instance_place(x,y,crate)
	depth = ID.depth - 1
}