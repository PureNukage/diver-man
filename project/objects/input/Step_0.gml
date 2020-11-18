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

keyRun = keyboard_check(vk_shift)

keyJump = keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(0, gp_face1)

keyInteract = keyboard_check_pressed(ord("E")) or gamepad_button_check_pressed(0, gp_face2)
keyInteractHold = keyboard_check(ord("E")) or gamepad_button_check(0, gp_face2)

keyAttack = keyboard_check(ord("Q"))

keyPause = keyboard_check_pressed(vk_escape)

gamepadAxisLV = gamepad_axis_value(0, gp_axislv)
gamepadAxisLH = gamepad_axis_value(0, gp_axislh)