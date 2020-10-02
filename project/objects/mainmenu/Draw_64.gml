draw_set_font(font_menu)


var String = "Dive!"
var spacer = 32
var Width = string_width(String) + spacer*4
var Height = string_height(String) + spacer
var X = display_get_gui_width()/2 - Width/2
var Y = display_get_gui_height()/2

draw_set_color(c_black)
draw_roundrect(X-2,Y-2,X+Width+2,Y+Height+2,false)

if point_in_rectangle(mouse_gui_x,mouse_gui_y,X,Y,X+Width,Y+Height) {
	draw_set_color(c_ltgray)
	if input.mouseLeftPress {
		room_goto(RoomDock)
		app.cameraRefresh = true
		app.underwaterChange(false)
		//audio_play_sound(sound_underwater,0,true)
		//audio_sound_gain(sound_underwater,sound.volumeSound,0)
	}
} else {
	draw_set_color(c_gray)
}
draw_roundrect(X,Y,X+Width,Y+Height,false)

draw_set_color(c_white)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text(X+Width/2,Y+Height/2,String)

draw_reset()
