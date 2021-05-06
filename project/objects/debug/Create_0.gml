on = false
depth = -10000
selected_unit = -1

function log(String) {
	
	var Time = "[" + string(time.stream) + "] "
	
	var Object = string_upper(object_get_name(other.object_index))
	
	var fullMessage = Time + Object + " " + String
	
	show_debug_message(fullMessage)
}
	
function draw_button_ext(x,y,width,height,text) {
	
	var clicked = false
	
	draw_set_color(c_black)
	draw_rectangle(x-2,y-2,x+width+2,y+height+2,false)
	
	if point_in_rectangle(mouse_gui_x,mouse_gui_y, x,y,x+width,y+height) {
		draw_set_color(c_ltgray)
		if input.mouseLeftPress {
			clicked = true	
		}
	} else {
		draw_set_color(c_gray)
	}
	draw_rectangle(x,y,x+width,y+height,false)
	
	draw_set_color(c_black)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text(x+width/2,y+height/2,text)
	
	return clicked
}
	
rebuilding = false
rebuildIndex = -1
rebuildList = ds_list_create()
rebuildTimer = -1
function rebuild() {
	
	rebuildList[| 0] = RoomCityHub
	rebuildList[| 1] = RoomDocks
	rebuildList[| 2] = RoomDocks_Underwater
	rebuildList[| 3] = RoomAlleyHub
	
	app.mode = mode_DEBUG
	
	rebuilding = true
	
}
function _rebuild() {
	
	if rebuildIndex == -1 {
		if !ds_list_empty(rebuildList) {
			rebuildIndex = rebuildList[| 0]
			ds_list_delete(rebuildList, 0)
			room_goto(rebuildIndex)
			app.collisionMaps = 0
		}
		//	Done rebuilding
		else {
			rebuilding = false
			rebuildIndex = -1
			rebuildTimer = -1
			app.roomTransition(RoomMainMenu, 20)
			app.mode = mode_PRODUCTION
		}
	}
	//	Save collisionMap surfaces into buffers
	else {
		if room == rebuildIndex {
			if rebuildTimer < 5 rebuildTimer++	
			else {
				
				var carton = carton_create()
				
				with collisionMap {
					var bufferName = room_get_name(room) + string(ID)
					
					carton_add(carton, bufferName+"finalSurface", surfaceBuffer)
					carton_add(carton, bufferName+"inverseSurface", inverseSurfaceBuffer)
					carton_add(carton, bufferName+"cookieCutSurface", cookieBuffer)
					
				}
				carton_save(carton, room_get_name(room)+"buffers.bin", true)
				carton_destroy(carton)
				
				rebuildIndex = -1
				rebuildTimer = 0
			}
		}
	}
	
}