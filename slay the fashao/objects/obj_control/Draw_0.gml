var g_col = make_color_rgb(120,120,120);

var t_x = 86;

draw_set_halign(fa_right);
draw_text_color(t_x, 16, string(strength) + " : STR",strength_col,strength_col,strength_col,strength_col,1);
draw_text_color(t_x, 32, string(endurance) + " : END",endurance_col,endurance_col,endurance_col,endurance_col,1);
draw_text_color(t_x, 48, string(stamina) + " : STA",stamina_col,stamina_col,stamina_col,stamina_col,1);
draw_text_color(t_x, 64, string(wisdom) + " : WIS",wisdom_col,wisdom_col,wisdom_col,wisdom_col,1);
draw_text_color(t_x, 80, string(inteligence) + " : INT",inteligence_col,inteligence_col,inteligence_col,inteligence_col,1);


draw_set_halign(fa_left);
draw_text_color(t_x + 2, 16, "ength", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, 32, "urance", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, 48, "mina", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, 64, "dom", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, 80, "eligence", g_col, g_col, g_col, g_col, 1);