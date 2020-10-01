on = false

application_surface_draw_enable(false)

u_resolution = shader_get_uniform(shader_godrays, "iResolution")

u_seconds = shader_get_uniform(shader_godrays, "iTime")

q_seconds = shader_get_uniform(shader_quake, "iTime")

caustic_resolution = shader_get_uniform(shader_caustic, "iResolution")

caustic_seconds = shader_get_uniform(shader_caustic, "iTime")

groundSurface = -1

sec = 0