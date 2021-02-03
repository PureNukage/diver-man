if input.keyPause and room != RoomMainMenu {
	pause()
}
if paused and !surface_exists(pauseSurface) {
	pauseSurface = surface_create(display_get_gui_width(),display_get_gui_height())
	buffer_set_surface(pauseSurfaceBuffer,pauseSurface,0)
	debug.log("poop")
}

if cameraRefresh {
	water.check_room_underwater()
	cameraRefresh = false
	cameraFix()
	grid.mpGrid_build()
	shadows.generate_map()
	water.generate_caustic_map()
	water.generate_collision_maps()
	surface_free(water.causticSurface)
	surface_free(water.causticSurfaceCutout)
	//surface_free(water.causticSurfaceOriginal)
	surface_free(lighting.surface)
	if instance_exists(player) and cameraFocusOnPlayer {
		x = player.x
		y = player.y-player.z-32
	}
}

var viewportID = layer_get_id("Viewport")
if layer_exists(viewportID) and layer_get_visible(viewportID) {
	layer_set_visible(viewportID, false)	
}

if !paused {
	
	//	Camera is not focused on the player
	var coordX = cameraFocusX
	var coordY = cameraFocusY
	if cameraFocusOnPlayer and instance_exists(player) {
		coordX = player.x
		coordY = player.y-player.z
	}
	if cameraLerp {
		x = floor(lerp(x,coordX,0.05))
		y = floor(lerp(y,coordY,0.05))
	}
	else {
		x = coordX
		y = coordY
	}
	if cameraFocusDuration == "~" {
	
	} else if cameraFocusDuration > -1 {
		cameraFocusDuration--
		if cameraFocusDuration == 0 cameraFocusOnPlayer = true
	}
	
	if instance_exists(player) and cameraFocusOnPlayer {
		var Lerp = 0.09
		x = lerp(x,player.groundX,Lerp)
		y = lerp(y,player.y-player.z-32,Lerp)
	}

	if time.stream <= 5 {
		window_center()
		if instance_exists(player) and cameraFocusOnPlayer {
			x = player.x
			y = player.y
		}
	}

	//zoom_level = clamp((zoom_level + (mouse_wheel_down()-mouse_wheel_up())*0.1),0.25,1.0)

	camera_set_view_pos(camera,
			clamp( camera_get_view_x(camera), 0, room_width - camera_get_view_width(camera) ),
			clamp( camera_get_view_y(camera), 0, room_height - camera_get_view_height(camera) ));

	var view_w = camera_get_view_width(camera)
	var view_h = camera_get_view_height(camera)

	var rate = 0.2

	var new_w = round(lerp(view_w, zoom_level *  default_zoom_width, rate))
	var new_h = round(lerp(view_h, zoom_level * default_zoom_height, rate))
			
	if new_w & 1 {
		new_w++	
	}
	if new_h & 1 {
		new_h++	
	}

	camera_set_view_size(camera, new_w, new_h)

	//	Realignment
	var shift_x = camera_get_view_x(camera) - (new_w - view_w) * 0.5
	var shift_y = camera_get_view_y(camera) - (new_h - view_h) * 0.5

	camera_set_view_pos(camera,shift_x, shift_y)


	////	Clamp app x,y within room
	var edgeX = camera_get_view_width(camera)/2
	var edgeY = camera_get_view_height(camera)/2
	x = clamp(x,0+edgeX,room_width-edgeX)
	y = clamp(y,0+edgeY,room_height-edgeY)
}