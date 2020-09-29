if opening open()

var spacer = 64
if player.onGround and player.z >= z and point_in_rectangle(player.groundX,player.groundY,x-spacer,y-spacer,x+spacer,y+spacer) {
	if input.keyInteract {
		if !opened {
			opening = true
			bubbleTimer = 0
			bubbleTimerMax = 0
			bubbles()
		} else if treasure > -1 {
			empty()		
		}
	}
	highlight = true
}
else if highlight highlight = false

depth = -y + -z