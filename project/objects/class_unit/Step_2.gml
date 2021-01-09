var border = 256
var x1 = camera_get_view_x(app.camera) - border
var y1 = camera_get_view_y(app.camera) - border
var x2 = camera_get_view_x(app.camera) + camera_get_view_width(app.camera) + border
var y2 = camera_get_view_y(app.camera) + camera_get_view_height(app.camera) + border
if room != RoomMainMenu and rectangle_in_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,x1,y1,x2,y2) == 0 {
	instance_deactivate_object(id)
}

if cell == -1 {
	cell = new cell_create(x, y)
}