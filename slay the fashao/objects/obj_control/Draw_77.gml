var _ww = window_get_width();
var _wh = window_get_height();
// window minimized
if (_ww <= 0 || _wh <= 0) exit; 
var _sw = surface_get_width(application_surface);
var _sh = surface_get_height(application_surface);
var _scale = min(_ww / _sw, _wh / _sh);
var _dw = _sw * _scale;
var _dh = _sh * _scale;
var _dx = (_ww - _dw) * 0.5;
var _dy = (_wh - _dh) * 0.5;
draw_clear(c_black);
shader_set(sh_effects);
shader_set_uniform_f(u_tint, death_color[0], death_color[1], death_color[2]);
shader_set_uniform_f(u_amount, death_amount);
shader_set_uniform_f(u_impact, impact_timer > 0 ? 1.0 : 0.0);
draw_surface_ext(application_surface, _dx, _dy, _scale, _scale, 0, c_white, 1);

if (global.screenshot_path != "") {
    screen_save(global.screenshot_path);
    global.screenshot_path = "";
}

shader_reset();