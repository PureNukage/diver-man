if map > -1 {
	if map.drawSurface {
		depth = map.depth - 100 - y
	}
	else {
		depth = -y
	}
}
else {
	depth = -y	
}