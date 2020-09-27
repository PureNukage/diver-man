//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float     iTime;                 // shader playback time (in seconds)

// Jason Allen Doucette
// http://xona.com/jason/
//
// Quake-style Underwater Distortion
// May 15, 2016


// ---- HOW IT'S DONE ----------------------------------------------------------------

// Click the mouse to see!


// ---- DESCRIPTION ----------------------------------------------------------------

// I always figured Quake's software underwater effect was merely shearing in X and Y -- 
// very efficient and effective (and noticeably breaks down if you go super high res,
// like 800x600 to 1024x768 or more, since it didn't scale for the resolution!).
// This is also something GPUs of the day couldn't do. These days, they can! 
// Much better than Quake's vertex shifting.

// NOTE:
// This scales to show the entire texture on-screen, maintaining aspect ratio, so it doesn't
// break down when you go fullscreen.  Since screen width is typically > height, this means 
// we're likely scaling to screen height.  The comments below assume this.


// ---- SETTINGS ----------------------------------------------------------------

#define speed 2.0

// the amount of shearing (shifting of a single column or row)
// 1.0 = entire screen height offset (to both sides, meaning it's 2.0 in total)
//	default 0.05
#define xDistMag 0.00125
#define yDistMag 0.00125

// cycle multiplier for a given screen height
// 2*PI = you see a complete sine wave from top..bottom
//	default 6.28
#define xSineCycles 25.0//6.126
#define ySineCycles 25.0//6.126


// ---- CODE ----------------------------------------------------------------

//void mainImage( out vec4 fragColor, in vec2 fragCoord )
void main()
{
	vec2 uv = v_vTexcoord;
    
    // the value for the sine has 2 inputs:
    // 1. the time, so that it animates.
    // 2. the y-row, so that ALL scanlines do not distort equally.
    float time = iTime*speed;
    float xAngle = time + uv.y * ySineCycles;
    float yAngle = time + uv.x * xSineCycles;
    
    bool bxHalf, byHalf;
    
    vec2 distortOffset = 
        vec2(sin(xAngle), sin(yAngle)) * // amount of shearing
        vec2(xDistMag,yDistMag); // magnitude adjustment
    
    // shear the coordinates
    uv += distortOffset;    
 
	
	gl_FragColor = texture2D(gm_BaseTexture, uv);
    
    // blue shift to look like water
    //gl_FragColor.rgb = vec3(0.0, 0.2, 0.9) + 
   // gl_FragColor.rgb * vec3(0.5, 0.6, 0.1);

}
