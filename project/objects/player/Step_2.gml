if depthY {
	depth = -y
	//	If the map under us is being drawn, lets make sure we're on top of it
	if map > -1 and map.drawSurface {
		depth = map.depth - ((abs(y-z) - abs(map.bbox_top)))
	}
}