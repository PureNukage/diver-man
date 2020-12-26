var Dialogue = text
if string_count("%",Dialogue) >= 2 {
	for(var a=0;a<string_length(Dialogue);a++) {
		//	A variable
		if string_char_at(Dialogue,a) == "%" {
			var endIndex = -1
			//	Find the other percentage
			for(var s=a;s<string_length(Dialogue);s++) {
				//	Found it
				if s != a and string_char_at(Dialogue,s) == "%" {
					endIndex = s
					s = 500
				}
			}
			if endIndex > -1 { 
				//	Found it, lets find our variable
				var substring = string_copy(Dialogue,a, endIndex+1-a)
				var variableString = substring
				while string_count("%",substring) > 0 {
					substring = string_delete(substring,string_pos("%",substring),1)	
				}
						
				//	Substring only has variable now, separate into object and variable using the period
				var periodIndex = string_pos(".",substring)
				var Object = asset_get_index(string_copy(substring,0,periodIndex-1))
				var Variable = string_copy(substring,periodIndex+1,string_length(substring)+1-periodIndex)
						
				//	Check if object exists
				if instance_exists(Object) and variable_instance_exists(Object,Variable) {
					//	Replace the variable in the dialogue with a string of the actual variable
					var newString = string(variable_instance_get(Object,Variable))
					Dialogue = string_replace(Dialogue,variableString,newString)
					text = Dialogue
				}
				else {
					//debug.log("ERROR with dialogue. KEY: "+string(Key)+" at: "+string(a))	
				}
							
			}
		}
	}
}