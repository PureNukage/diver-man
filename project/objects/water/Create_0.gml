on = false

application_surface_draw_enable(false)

q_seconds = shader_get_uniform(shader_quake, "iTime")

caustic_resolution = shader_get_uniform(shader_caustic, "iResolution")

caustic_seconds = shader_get_uniform(shader_caustic, "iTime")

causticSurfaceOriginal = -1
causticSurface = -1

sec = 0