mouseLeftPress = mouse_check_button_pressed(mb_left)
mouseLeftRelease = mouse_check_button_released(mb_left)
mouseLeft = mouse_check_button(mb_left)

mouseRightPress = mouse_check_button_pressed(mb_right)
mouseRightRelease = mouse_check_button_released(mb_right)
mouseRight = mouse_check_button(mb_right)

debugToggle = keyboard_check_pressed(vk_control)

keyRight = keyboard_check(ord("D")) or gamepad_button_check(0, gp_padr)
keyLeft = keyboard_check(ord("A")) or gamepad_button_check(0, gp_padl)
keyUp = keyboard_check(ord("W")) or gamepad_button_check(0, gp_padu)
keyDown = keyboard_check(ord("S")) or gamepad_button_check(0, gp_padd)

keyRightPress = keyboard_check_pressed(ord("D")) or gamepad_button_check_pressed(0, gp_padr)
keyLeftPress = keyboard_check_pressed(ord("A")) or gamepad_button_check_pressed(0, gp_padl)
keyUpPress = keyboard_check_pressed(ord("W")) or gamepad_button_check_pressed(0, gp_padu)
keyDownPress = keyboard_check_pressed(ord("S")) or gamepad_button_check_pressed(0, gp_padd)

keyRun = keyboard_check(vk_shift) or gamepad_button_check(0, gp_face2)

keyInventory = keyboard_check_pressed(vk_tab) or gamepad_button_check_pressed(0, gp_select)

keyJump = keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(0, gp_face1)
keyJumping = keyboard_check(vk_space) or gamepad_button_check(0, gp_face1)

keyInteract = keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(0, gp_face4)
keyInteractHold = keyboard_check(ord("E")) or gamepad_button_check(0, gp_face4)

keyAttack = keyboard_check(ord("Q")) or gamepad_button_check_pressed(0, gp_face3)

keyJournal = keyboard_check_pressed(ord("J"))

keyPause = keyboard_check_pressed(vk_escape) or gamepad_button_check_pressed(0, gp_start)

gamepadAxisLV = gamepad_axis_value(0, gp_axislv)
gamepadAxisLH = gamepad_axis_value(0, gp_axislh)

keyEnterPress = keyboard_check_pressed(vk_enter)

keyArrowRight = keyboard_check(vk_right)
keyArrowLeft = keyboard_check(vk_left)
keyArrowUp = keyboard_check(vk_up)
keyArrowDown = keyboard_check(vk_down)

if keyboard_check(vk_anykey) {
	keyboardOrController = 0
}
else {
	//	Check for controller inputs
	var list = ds_list_create()
	ds_list_add(list, gp_face1)
	ds_list_add(list, gp_face2)
	ds_list_add(list, gp_face3)
	ds_list_add(list, gp_face4)
	ds_list_add(list, gp_axislv)
	ds_list_add(list, gp_axislh)
	ds_list_add(list, gp_start)
	ds_list_add(list, gp_padr)
	ds_list_add(list, gp_padl)
	ds_list_add(list, gp_padu)
	ds_list_add(list, gp_padd)
	
	for(var i=0;i<ds_list_size(list);i++) {
		if list[| i] == gp_axislv or list[| i] == gp_axislh {
			if gamepad_axis_value(0, list[| i]) != 0 {
				keyboardOrController = 1
			}
		} 
		else {
			if gamepad_button_check(0, list[| i]) {
				keyboardOrController = 1
			}
		}
	}
	
	ds_list_destroy(list)
	
	//	Determine Xbox or PS4 Controller
	var rawString = gamepad_get_description(0)
	if string_count("play", rawString) > 0 or string_count("PS4", rawString) or string_count("PS3", rawString) {
		controllerType = "PlayStation"	
	}
	else if string_count("xbox", rawString) > 0 or string_count("XInput", rawString) > 0 {
		controllerType = "Xbox"	
	}
	
}