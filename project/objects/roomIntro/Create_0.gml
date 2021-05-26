if file_exists("save.ini") {
	file_delete("save.ini")	
}

//	Add the intro quest
questManager.add_quest(quests.intro)

//	Add brother as a character
characterManager.add_character(characters.brother)

text1 = "1930s"
text2 = "a year after the sickness took your parents"

text1FadeIn = 0
text2FadeIn = 0

playerFadeIn = 0
brotherFadeIn = 0 
backgroundFadeOut = 100

timer = 0

var xx = display_get_gui_width()/2 + 33
var yy = display_get_gui_height()/2 - 56
var adjustY = 136
brotherShadow = instance_create_layer(xx+96,yy+adjustY,"Instances",brother)
brotherShadow.image_alpha = 0
brotherShadow.mask_index = brotherShadow.sprite_index
brotherShadow.sprite_index = s_brother_walk
brotherShadow.moving = true

playerShadow = instance_create_layer(xx,yy+adjustY,"Instances",player)
playerShadow.image_alpha = 0
playerShadow.canMove = false
playerShadow.muted = true
playerShadow.sprite_index = s_kid_player_walk

createdBackground = false

//sound.playSoundEffect(sound_music)