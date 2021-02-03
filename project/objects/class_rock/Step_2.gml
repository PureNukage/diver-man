event_inherited()

if heightMap > -1 and instance_exists(heightMap) {
	if !heightMap.drawSurface heightMap.depth = heightMap.bbox_top*-1
	heightMap.drawSurface = true
}