cameraX1 = camera_get_view_x(camera)
cameraY1 = camera_get_view_y(camera)
cameraX2 = cameraX1 + camera_get_view_width(camera)
cameraY2 = cameraY1 + camera_get_view_height(camera)

if !paused {
	var border = 256
	var x1 = camera_get_view_x(app.camera) - border
	var y1 = camera_get_view_y(app.camera) - border
	instance_activate_region(x1,y1,camera_get_view_width(app.camera)+(border*2),camera_get_view_height(app.camera)+(border*2),true)
}