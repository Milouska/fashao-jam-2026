shader_set(sh_effects);
shader_set_uniform_f(u_tint, death_color[0], death_color[1], death_color[2]);
shader_set_uniform_f(u_amount, death_amount);
shader_set_uniform_f(u_impact, impact_timer > 0 ? 1.0 : 0.0);
draw_surface_stretched(application_surface, 0, 0, window_get_width(), window_get_height());
shader_reset();