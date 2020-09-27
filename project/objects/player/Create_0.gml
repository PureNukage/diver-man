hspd = 0
vspd = 0
onGround = true
groundX = x
groundY = y
grav = 0.4
z = 0
xx = 0
yy = 0
var Scale = 1
xscale = Scale
yscale = Scale
image_xscale = xscale
image_yscale = yscale
moveForce = 0
moveDirection = -1
knockbackForce = 0
knockbackDirection = -1
thrust = 0
map = -1

madeFootprint = false

function setForce(force, direction) {
	
	xx = lengthdir_x(force, direction)
	yy = lengthdir_y(force, direction)

}


function applyMovement() {
	
	for(var X=0;X<abs(xx);X++) {
		if !place_meeting(groundX + sign(xx), groundY, collision) groundX += sign(xx)
	}
	
	for(var Y=0;Y<abs(yy);Y++) {
		if !place_meeting(groundX, groundY + sign(yy), collision) groundY += sign(yy)
	}
	
	xx = 0
	yy = 0
	
}




bubbleTimer = -1
bubbleTimerMax = irandom_range(120,180)
function bubbles() {
	if bubbleTimer > 0 bubbleTimer--
	else {
		
		bubbleTimer = irandom_range(120,180)
		
		var bubbleCount = irandom_range(3,6)
		
		for(var i=0;i<bubbleCount;i++) {
			
			var Size = random_range(0.3,0.8)
			
			var scatter = 12
			var scatterX = irandom_range(x - scatter, x + scatter)
			var scatterY = irandom_range(y - 32 - scatter, y - 32 + scatter)
			
			var Speed = irandom_range(1,2)
			
			//var Bubble = instance_create_layer(scatterX,scatterY,"Instances",particle)
			//Bubble.image_xscale = Size
			//Bubble.image_yscale = Size
			//Bubble.Speed = Speed
			//Bubble.duration = irandom_range(30,60)
			//Bubble.durationMax = Bubble.duration
			//Bubble.particles = particles.bubble
			var Bubble = createParticle(scatterX,scatterY,particles.bubble,irandom_range(30,60),Speed)
			Bubble.image_xscale = Size
			Bubble.image_yscale = Size
			
		}
		
	}
}