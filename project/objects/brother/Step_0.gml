event_inherited()


if !moving image_xscale = -1

if moving {
	sprite_index = s_brother_walk
}
else {
	sprite_index = s_kid_crutch	
}


//	Heading home
if dialogueIndex == 5 and app.roomTransitionTo == -1 {
	app.roomTransition(RoomAlleyHub, 8)
}