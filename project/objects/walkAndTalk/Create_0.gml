Direction = right
stage = 0

destroy = false

if instance_exists(player) player.muted = true

gapMax = 96
gap = 0

inConversation = false
timer = 0
npcKey = "intro"
dialogueIndex = -1

load_dialogue()

playerShadow = instance_create_layer(x,y,"Instances",player)
playerShadow.image_alpha = -1
playerShadow.canMove = false

brotherShadow = instance_create_layer(x+96+gap,y,"Instances",brother)
brotherShadow.image_alpha = -1