cutscene = -1
stage = -1
timer = 0

cutsceneList = ds_list_create()

function start_cutscene(cutscene_index) {
	cutscene = cutscene_index
	stage = -1
	timer = 0
	debug.log("Starting cutscene: " + string(cutscene))
}

function find_cutscene(cutscene_index) {
	for(var i=0;i<ds_list_size(cutsceneList);i++) {
		if cutsceneList[| i] == cutscene_index return i	
	}
	return -1
}

function finish_cutscene() {
	if cutscene > -1 {
		debug.log("Finishing cutscene: " + string(cutscene))	
		
		ds_list_add(cutsceneList, cutscene)
		
		cutscene = -1
		stage = -1
		timer = 0 
	}
}