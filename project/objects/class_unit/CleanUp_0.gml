if path_exists(path) path_delete(path)
if ds_exists(inventory, ds_type_list) ds_list_destroy(inventory)
if buffer_exists(shadeBuffer) buffer_delete(shadeBuffer)
if surface_exists(shadeSurface) surface_free(shadeSurface)