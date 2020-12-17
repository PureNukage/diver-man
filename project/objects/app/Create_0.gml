creator = ""
version = ""

canvasX = 0

paused = false
suitOn = false
gold = 1

var Layer = "Instances"
instance_create_layer(0,0,Layer,input)
instance_create_layer(0,0,Layer,debug)
instance_create_layer(0,0,Layer,time)
instance_create_layer(0,0,Layer,sound)
instance_create_layer(0,0,Layer,water)
instance_create_layer(0,0,Layer,lighting)
instance_create_layer(0,0,Layer,shadows)
instance_create_layer(0,0,Layer,grid)
instance_create_layer(0,0,Layer,gui)

function scale_canvas(new_width, new_height) {
	window_set_size(new_width, new_height)
	
	//if center {
	//	centerWindow = true
	//}
	
	//surface_resize(application_surface,new_width,new_height)
}
	
function cameraSetup() {

		width = 640
		height = 360
		zoom_level = 1
		
		var fullscreen = false
		//var windowWidth = window_get_width()
		var windowHeight = window_get_height()
		//var displayWidth = display_get_width()
		var displayHeight = display_get_height()
		if window_get_width() == display_get_width() and (abs(windowHeight - displayHeight) < 100) {
			fullscreen = true
		}

		#region Views

			view_enabled = true
			view_visible[0] = true

			view_set_visible(0,true)

			view_set_wport(0,width)
			view_set_hport(0,height)

		#endregion
		#region Resize and Center Game Window

			if !fullscreen window_set_rectangle((display_get_width()-view_wport[0])*0.5,(display_get_height()-view_hport[0])*0.5,view_wport[0],view_hport[0])
			
			if !fullscreen window_center()
	
			surface_resize(application_surface,view_wport[0],view_hport[0])
	
			display_set_gui_size(width,height)


		#endregion
		#region Camera Create

			camera = camera_create()

			var viewmat = matrix_build_lookat(width,height,-10,width,height,0,0,1,0)
			var projmat = matrix_build_projection_ortho(width,height,1.0,32000.0)

			camera_set_view_mat(camera,viewmat)
			camera_set_proj_mat(camera,projmat)
	
			camera_set_view_pos(camera,x,y)
			camera_set_view_size(camera,width,height)
	
			camera_set_view_speed(camera,200,200)
			camera_set_view_border(camera,width,height)
	
			camera_set_view_target(camera,id)

			view_camera[0] = camera

		#endregion
	
		//if !fullscreen scale_canvas(1920,1080)

		default_zoom_width = camera_get_view_width(camera)
		default_zoom_height = camera_get_view_height(camera)

}

cameraFocusOnPlayer = true
cameraFocusX = x
cameraFocusY = y
cameraFocusDuration = -1
function cameraFocus(_x, _y, _duration){
	
	cameraFocusX = _x
	cameraFocusY = _y
	cameraFocusDuration = _duration
	
}
	
cameraSetup()

if room == RoomAppStart {
	room_goto(RoomMainMenu)
	cameraRefresh = true
}

underwater = false
function underwaterChange(on) {
	if on {
		underwater = true
		water.on = true
		lighting.on = true
		if !audio_is_playing(sound_underwater) {
			audio_play_sound(sound_underwater,0,true)
			audio_sound_gain(sound_underwater,sound.volumeSound,0)	
		}
	}
	else {
		underwater = false
		water.on = false
		lighting.on = false
		if audio_is_playing(sound_underwater) {
			audio_stop_sound(sound_underwater)
		}
	}
}

roomTransitionTimer = -1
roomTransitionTo = -1
roomTransitionLerp = -1
roomTransitionLerpStart = -1
roomTransitionSpeed = -1
roomTransitionStage = -1
roomTransitionBuffer = -1
function roomTransition(Room, Speed) {
	roomTransitionTo = Room
	roomTransitionSpeed = Speed
	
	roomTransitionLerp = display_get_gui_width()
	roomTransitionLerpStart = roomTransitionLerp
	
	roomTransitionStage = 0
	
	depth = -2000
}

function roomTransitioning() {
	var Width = display_get_gui_width()
	var Height = display_get_gui_height()
	var surface = surface_create(Width,Height)
	surface_set_target(surface)
	draw_clear_alpha(c_black, 0)
	
	switch(roomTransitionStage)
	{
		//	Old room
		case 0:
			draw_set_color(c_black)
			draw_set_alpha(1)
			draw_rectangle(0,0,Width,Height,false)
	
			gpu_set_blendmode(bm_subtract)
	
			var coorX, coorY
			//if instance_exists(player) {
			//	coorX = player.x
			//	coorY = player.y-player.z
			//}
			//else {
				coorX = camera_get_view_x(app.camera) + (camera_get_view_width(app.camera)/2)	
				coorY = camera_get_view_y(app.camera) + (camera_get_view_height(app.camera)/2)	
				coorX = (camera_get_view_width(app.camera)/2)	
				coorY = (camera_get_view_height(app.camera)/2)	
			//}
			draw_circle(coorX,coorY,roomTransitionLerp,false)
	
			gpu_set_blendmode(bm_normal)
	
			surface_reset_target()
			
			roomTransitionLerp = approach(roomTransitionLerp, 0, roomTransitionSpeed)
			
			//	Transition over, lets go to the next room
			if roomTransitionLerp == 0 {
				room_goto(roomTransitionTo)
				app.cameraRefresh = true
				roomTransitionStage = 1
				if roomTransitionTo == Room1 app.underwaterChange(true)
				else app.underwaterChange(false)
				roomTransitionTimer = 5
			}
		break
		//	Pause on new room
		case 1:
			draw_set_color(c_black)
			draw_set_alpha(1)
			draw_rectangle(0,0,Width,Height,false)
			
			surface_reset_target()
			
			if surface_exists(shadows.surface) surface_free(shadows.surface)
		
			if roomTransitionTimer > -1 roomTransitionTimer--
			else {
				roomTransitionStage = 2
			}
		break
		//	New room
		case 2:
			draw_set_color(c_black)
			draw_set_alpha(1)
			draw_rectangle(0,0,Width,Height,false)
			
			gpu_set_blendmode(bm_subtract)
	
			var coorX, coorY
			//if instance_exists(player) {
			//	coorX = player.x
			//	coorY = player.y-player.z
			//}
			//else {
				coorX = camera_get_view_x(app.camera) + (camera_get_view_width(app.camera)/2)	
				coorY = camera_get_view_y(app.camera) + (camera_get_view_height(app.camera)/2)	
				coorX = (camera_get_view_width(app.camera)/2)	
				coorY = (camera_get_view_height(app.camera)/2)	
			//}
			draw_circle(coorX,coorY,roomTransitionLerp,false)
	
			gpu_set_blendmode(bm_normal)
	
			surface_reset_target()
			
			roomTransitionLerp = approach(roomTransitionLerp, Width, roomTransitionSpeed)
			
			//	Transition over, lets go to the next room
			if roomTransitionLerp == Width {
				roomTransitionTo = -1
				roomTransitionLerp = -1
				roomTransitionLerpStart = -1
				roomTransitionSpeed = -1
				roomTransitionStage = -1
				depth = 1
			}
		break	
	}
	
	draw_surface(surface,camera_get_view_x(app.camera),camera_get_view_y(app.camera))
	
	{
		if buffer_exists(roomTransitionBuffer) buffer_delete(roomTransitionBuffer)
		roomTransitionBuffer = buffer_create(Width*Height*4, buffer_grow, 1)
		buffer_get_surface(roomTransitionBuffer,surface, 0)
	}
	
	surface_free(surface)
	
	//debug.log("roomTransitionLerp: "+string(roomTransitionLerp))
}