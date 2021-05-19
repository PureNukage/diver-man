event_inherited()

mask_index = s_mudcrab_collision

//interactibility = false
npcKey = "crabLost"
npcSprite = s_mudcrab
load_dialogue()

maxMovespeed = 0.5

emote(s_emoji_cry, "~")

stage0map = -1
stage1map = -1
stage2map = -1

stage = 0
movingStage = 0

if place_meeting(x,y,collisionMap) {
	var Map = instance_place(x,y,collisionMap)
	map = Map
	z = Map.z
	y += z
}

function stunCheck() {
	if point_distance(x,y, player.x,player.y) < 30 and player.jumpHalt and abs(player.z-z) < 4 {
		state = state.stunned
		//sprite_index = s_crab_knocked
		setThrust(5)
		timer = 90
		
		//	Create gold coin
		//var Coin = instance_create_layer(x,y-z,"Instances",coin)
		//Coin.setThrust(5)
		
	}
}