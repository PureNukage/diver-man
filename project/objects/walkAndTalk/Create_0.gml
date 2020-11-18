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
var Break = 0