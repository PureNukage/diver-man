function approach(a, b, amount) {
	if (a < b) {
		a += amount
		if (a > b)
		return b
	} else {
		a -= amount
		if (a < b)
		return b
	}
	return a 	
}

function wave(from, to, duration, offset) {
	var a4 = (to - from) * 0.5
	return from + a4 + sin((((current_time * 0.0001) + duration * offset) / duration) * (pi*2)) * a4	
}

function wrap(value, Min, Max) {
	var _val = value
	var _max = Min
	var _min = Max

	if(_val mod 1 == 0) {
		while(_val > _max || _val < _min) {
			if(_val > _max) {
				_val = _min + _val - _max - 1	
			} else if (_val < _min) {
				_val = _max + _val - _min + 1
			} else _val = _val 
		}
		return _val
	} else {
		var _old = value + 1
		while (_val != _old) {
			_old = _val
			if(_val<_min) {
				_val = _max - (_min - _val)	
			} else if (_val > _max) {
				_val = _min + (_val - _max)
			} else _val = _val
		}
		return _val
	}	
}
	
function draw_text_outlined(x, y, String, text_color, outline_color) {
	var xx = x;
	var yy = y;
	var s = String;
	var c1 = text_color;
	var c2 = outline_color;

	draw_set_color(c2);
	draw_text(xx+1, yy+1, s);
	draw_text(xx-1, yy+1, s);
	draw_text(xx+1, yy-1, s);
	draw_text(xx-1, yy-1, s);

	draw_set_color(c1);
	draw_text(xx, yy, s);
}
	
function draw_reset() {
	
	draw_set_color(c_black)
	draw_set_alpha(1)
	draw_set_font(-1)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	
}
	
function createParticle(X, Y, Enum, Duration, Speed) {
	var Particle = instance_create_layer(X,Y,"Instances",particle)
	Particle.Speed = Speed
	Particle.duration = Duration
	Particle.durationMax = Particle.duration
	Particle.particles = Enum
	
	return Particle
}
	
function pathfind(mp_grid, Path, xStart, yStart, xGoal, yGoal, allowdiag) {
	
	if mp_grid_path(mp_grid, Path, xStart, yStart, xGoal, yGoal, allowdiag) {
		return true
	}
	
	else {
		debug.log("Can't pathfind to the desired goal")	
		return false
	}
	
}
	
function instance_place_highest(x, y, object) {
	var instance = noone;
	var list = ds_list_create();
	var num = instance_place_list(x, y, object, list, false);
	for(var i = 0; i < num; i++){
	if (instance == noone || list[| i].z > instance.z)
	    instance = list[| i];
	}
	
	//	Filter down to a map that we're actually colliding with
	var Y = self.y
	if ds_list_size(list) > 1 and list[| 1].z == instance.z {
		for(var i=0;i<num;i++) {
			if Y > (list[| i].bbox_bottom - list[| i].width) and list[| i].z == instance.z
			instance = list[| i]
		}
	}
  
	ds_list_destroy(list);

	return instance;
}
	
function instance_place_count(x, y, object) {
	var list = ds_list_create()
	var count = instance_place_list(x,y,object,list,true)
	ds_list_destroy(list)
	return count
}
	
function maps_collision_count(x,y) {
	
	var list = ds_list_create()
	var count = instance_place_list(x,y, collisionMap, list, true)
	
	var collisionCount = 0
	for(var i=0;i<count;i++) {
		var Map = list[| i]
		if y > Map.bbox_bottom - Map.width {
			collisionCount++
		}
	}
	
	ds_list_destroy(list)
	
	return collisionCount
	
}
	
function draw_path_sprite(path, sprite, subimg) {
	///@func draw_path_sprite(path,sprite,subimg)
	///@desc Draws a path with a sprite (smoothly, not absolute)
	///@auth Lord von Adel
	///@arg path
	///@arg sprite
	///@arg index
	var _path = path;
	var _sprite = sprite;
	var _subimg = subimg;

	var sW = sprite_get_width(_sprite);
	var sH = sprite_get_height(_sprite);
	var _col = draw_get_color();
	draw_set_color(c_white);

	for (var i=0; i<path_get_length(_path); i++) {
		var x1, y1, x2, y2, x0, y0, dir, m;
	
		x1 = path_get_x(_path,i/(path_get_length(_path)/sprite_get_width(_sprite)));
		y1 = path_get_y(_path,i/(path_get_length(_path)/sprite_get_width(_sprite)));
		x2 = path_get_x(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
		y2 = path_get_y(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
	
		if(i > 0) {
			x0 = path_get_x(_path,(i-1)/(path_get_length(_path)/sprite_get_width(_sprite)));
			y0 = path_get_y(_path,(i-1)/(path_get_length(_path)/sprite_get_width(_sprite)));
		} else {
			x0 = path_get_x(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
			y0 = path_get_y(_path,(i+1)/(path_get_length(_path)/sprite_get_width(_sprite)));
		}
	
		m = 1;
		if(i > path_get_length(_path)/sH - 1) { m = (path_get_length(_path)/sH) - floor(path_get_length(_path)/sH); }
	
		dir = point_direction(x0,y0,x1,y1);
		if(i == 0) { dir += 180; }
		draw_primitive_begin_texture(pr_trianglestrip,sprite_get_texture(_sprite,_subimg));
		draw_vertex_texture(x1+lengthdir_x(sW/2,dir+90),y1+lengthdir_y(sW/2,dir+90),0,0);
		draw_vertex_texture(x1+lengthdir_x(-sW/2,dir+90),y1+lengthdir_y(-sW/2,dir+90),1,0);
	
		dir = point_direction(x1,y1,x2,y2);
		draw_vertex_texture(x2+lengthdir_x(sW/2,dir+90),y2+lengthdir_y(sW/2,dir+90),0,m);
		draw_vertex_texture(x2+lengthdir_x(-sW/2,dir+90),y2+lengthdir_y(-sW/2,dir+90),1,m);
		draw_primitive_end();
	};

	draw_set_color(_col);	
}
	
function drawLineSprite(sprite, x1,y1, x2,y2, width, color, alpha) {
    var _pixel = sprite,
    _x1=x1+1,
    _y1=y1+1,
    _x2=x2+1,
    _y2=y2+1,
    _width=argument_count > 5 ? width : 1,
    _color=argument_count > 6 ? color : draw_get_color(),
    _alpha=argument_count > 7 ? alpha : draw_get_alpha(),
    _dir = point_direction(_x1, _y1, _x2, _y2),
    _len = point_distance(_x1, _y1, _x2, _y2);

    draw_sprite_ext(_pixel, 0, 
                _x1+lengthdir_x(_width/2,_dir+90), 
                _y1+lengthdir_y(_width/2,_dir+90), 
                _len, _width, _dir, _color, _alpha);
}
	
function load_dialogue() {
	
	var csv = "dialogue.csv"
	var key = npcKey
	
	var dialogue = load_csv(csv)
	
	myDialogue = [[]]
	
	var height = ds_grid_height(dialogue)
	
	var foundDialogue = false
	var DialogueIndex = 0
	for(var i=0;i<height;i++) {
		var Key = dialogue[# 0, i]
		var nextIndex = dialogue[# 1, i]
		var Dialogue = dialogue[# 2, i]
		var Sprite = dialogue[# 3, i]
		
		var SpriteIndex = asset_get_index(Sprite)
		
		if string_count(key,Key) > 0 {
			myDialogue[0, DialogueIndex] = nextIndex
			myDialogue[1, DialogueIndex] = Dialogue
			
			if SpriteIndex > -1 {
				npcSprite = SpriteIndex	
				myDialogue[2, DialogueIndex] = SpriteIndex
			}
			else myDialogue[2, DialogueIndex] = s_brother_face
			
			foundDialogue = true
			DialogueIndex++
		}
	}
	if foundDialogue {
		dialogueIndex = 0	
	}
	else dialogueIndex = -1
	
	ds_grid_destroy(dialogue)
	
}
	
function draw_nine_tile(slice_index, width, height, xx, yy, _string) {
	//draw_set_font(font_dialogue)
	var pixels = 42
	var tilesWidth = ceil(width / pixels)
	var tilesHeight = ceil(height / pixels)
	var XX = xx
	var YY = yy
	//debug.log(string(tilesWidth))
	//debug.log(string(tilesHeight))
	for(var w=0;w<tilesWidth;w++) {
		for(var h=0;h<tilesHeight;h++) {
			//	Top left corner
			if w == 0 and h == 0 {
				draw_sprite_part(slice_index,0, 0,0,pixels,pixels, XX,YY)
			}
			//	Top piece
			else if w > 0 and w < tilesWidth-1 and h == 0 {
				draw_sprite_part(slice_index,0, pixels,0, pixels,pixels, XX,YY)
			}
			//	Top right corner
			else if w == tilesWidth-1 and h == 0 {
				draw_sprite_part(slice_index,0, pixels*2+2,0, pixels,pixels, XX,YY)	
			}
			//	Left side piece
			else if w == 0 and h > 0 and h < tilesHeight-1 {
				draw_sprite_part(slice_index,0, 0,pixels, pixels,pixels, XX,YY)	
			}
			//	Bottom left corner
			else if w == 0 and h == tilesHeight-1 {
				draw_sprite_part(slice_index,0, 0,pixels*2+2, pixels,pixels, XX,YY)		
			}
			//	Bottom piece
			else if w > 0 and w < tilesWidth-1 and h == tilesHeight-1 {
				draw_sprite_part(slice_index,0, pixels,pixels*2+2, pixels,pixels, XX,YY)		
			}
			//	Bottom right corner
			else if w == tilesWidth-1 and h == tilesHeight-1 {
				draw_sprite_part(slice_index,0, pixels*2+2,pixels*2+2, pixels,pixels, XX,YY)	
			}
			//	Right side piece
			else if w == tilesWidth-1 and h < tilesHeight-1 and h > 0 {
				draw_sprite_part(slice_index,0, pixels*2+2,pixels*1, pixels,pixels, XX,YY)		
			}
			//	Center tile
			else {
				draw_sprite_part(slice_index,0, pixels,pixels, pixels,pixels, XX,YY)		
			}
			YY += pixels
		}
		YY = yy
		XX += pixels
	}
	
	draw_set_color(c_black)
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_text_ext(xx+(tilesWidth*pixels)/2, yy+(tilesHeight*pixels)/2, _string, string_height(_string), 430)
}