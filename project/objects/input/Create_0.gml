mouseLeftPress = mouse_check_button_pressed(mb_left)
mouseLeftRelease = mouse_check_button_released(mb_left)
mouseLeft = mouse_check_button(mb_left)

mouseRightPress = mouse_check_button_pressed(mb_right)
mouseRightRelease = mouse_check_button_released(mb_right)
mouseRight = mouse_check_button(mb_right)

debugToggle = keyboard_check_pressed(vk_control)

keyRight = keyboard_check(ord("D"))
keyLeft = keyboard_check(ord("A"))
keyUp = keyboard_check(ord("W"))
keyDown = keyboard_check(ord("S"))

keyRightPress = keyboard_check_pressed(ord("D"))
keyLeftPress = keyboard_check_pressed(ord("A"))
keyUpPress = keyboard_check_pressed(ord("W"))
keyDownPress = keyboard_check_pressed(ord("S"))

keyRun = keyboard_check(vk_shift)

keyInventory = keyboard_check_pressed(vk_tab) or gamepad_button_check_pressed(0, gp_select)

keyJump = keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(0, gp_face1)
keyJumping = keyboard_check(vk_space) or gamepad_button_check(0, gp_face1)

keyInteract = keyboard_check_pressed(ord("E"))
keyInteractHold = keyboard_check(ord("E"))

keyAttack = keyboard_check(ord("Q"))

keyPause = keyboard_check_pressed(vk_escape)

gamepad_set_axis_deadzone(0, 0.25)

gamepadAxisLV = gamepad_axis_value(0, gp_axislv)
gamepadAxisLH = gamepad_axis_value(0, gp_axislh)

keyEnterPress = keyboard_check_pressed(vk_enter)

keyArrowRight = keyboard_check(vk_right)
keyArrowLeft = keyboard_check(vk_left)
keyArrowUp = keyboard_check(vk_up)
keyArrowDown = keyboard_check(vk_down)

keyboardOrController = 0	//	0 = keyboard, 1 = controller
controllerType = -1