if roomTransitionTo == -1 scene_loader()
newRoom = true

////	Prep collisionMap buffers and metadata
//var filename = room_get_name(room)+"buffers.bin"
//if file_exists(filename) {
//	var carton = carton_load(filename, true)
//	if collisionMapsBuffers > -1 ds_list_destroy(collisionMapsBuffers)
//	if collisionMapsMetadata > -1 ds_list_destroy(collisionMapsMetadata)
//	collisionMapsBuffers = carton_unpack(carton, false)
//	collisionMapsMetadata = carton_unpack(carton, true)
//	carton_destroy(carton)
//}