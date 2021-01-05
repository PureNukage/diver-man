if path_exists(path) path_delete(path)
if buffer_exists(shadeBuffer) buffer_delete(shadeBuffer)
if surface_exists(shadeSurface) surface_free(shadeSurface)