cutscene = -1
stage = -1
timer = 0

function finish_cutscene() {
	if cutscene > -1 {
		debug.log("Finishing cutscene: " + string(cutscene))	
		
		cutscene = -1
		stage = -1
		timer = 0 
	}
}