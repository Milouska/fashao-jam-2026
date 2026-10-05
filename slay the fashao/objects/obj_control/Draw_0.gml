draw_set_font(font_zh)
font_add_enable_aa(false)

var t_x = 88
var t_y = 100

if (game_state == GameState.OVER) {
    var over_text = global.t("event.over.text")
    draw_text(room_width / 2 -  string_width(over_text) / 2, y + 32, over_text)
    
    draw_set_halign(fa_right);
    
    draw_text_colour(room_width / 2 - 120, t_y + 20, global.t("event.over.enemies"), c_gray, c_gray, c_gray, c_gray, 1)
    draw_text_colour(room_width / 2 - 120, t_y + 40, global.t("event.over.tokens"), c_gray, c_gray, c_gray, c_gray, 1)
    draw_text_colour(room_width / 2 - 120, t_y + 60, global.t("event.over.rounds"), c_gray, c_gray, c_gray, c_gray, 1)
    draw_text_colour(room_width / 2 - 120, t_y + 80, global.t("event.over.damage"), c_gray, c_gray, c_gray, c_gray, 1)
    draw_text_colour(room_width / 2 - 120, t_y + 100, global.t("event.over.taken"), c_gray, c_gray, c_gray, c_gray, 1)
    draw_text_colour(room_width / 2 - 120, t_y + 120, global.t("event.over.intelligence"), c_gray, c_gray, c_gray, c_gray, 1)
	draw_text_colour(room_width / 2 - 120, t_y + 140, global.t("event.over.time"), c_gray, c_gray, c_gray, c_gray, 1)
    
    draw_set_halign(fa_left);

		var intelligence_comment = ""

		if (inteligence > 10) {
			intelligence_comment = global.t("event.over.intelligence.high")
		} else if (inteligence <= 10 && inteligence > 4) {
			intelligence_comment = global.t("event.over.intelligence.mid")
		} else {
			intelligence_comment = global.t("event.over.intelligence.low")
		}

    draw_text_colour(room_width / 2 + 150, t_y + 20, stats.enemies_killed, c_white, c_white, c_white, c_white, 1)
    draw_text_colour(room_width / 2 + 150, t_y + 40, stats.tokens_sliced, c_white, c_white, c_white, c_white, 1)
    draw_text_colour(room_width / 2 + 150, t_y + 60, game_rounds - 1, c_white, c_white, c_white, c_white, 1)
    draw_text_colour(room_width / 2 + 150, t_y + 80, stats.damage_given, c_white, c_white, c_white, c_white, 1)
    draw_text_colour(room_width / 2 + 150, t_y + 100, stats.damage_taken, c_white, c_white, c_white, c_white, 1)
    draw_text_colour(room_width / 2 + 150, t_y + 120, string("{0}, {1}", inteligence, intelligence_comment), c_white, c_white, c_white, c_white, 1)
    draw_text_colour(room_width / 2 + 150, t_y + 140, string("{0}s", game_length_seconds), c_white, c_white, c_white, c_white, 1)
	
    return
}

t_x = 88
t_y = 24


var g_col = make_color_rgb(120,120,120);

// Turn
var turn_text = string(global.t("ui.turn"), game_rounds)
draw_text(room_width - string_width(turn_text) - 24, t_y, turn_text)

//STATS
draw_text(t_x - 48, t_y, global.t("ui.stats"));

// Draw text at the bottom of the screen saying what is happening
var desc = ""

if (game_state == GameState.BALANCE) {
    desc = balance_turn == 1 ? global.t("event.balance.increase.text") : global.t("event.balance.decrease.text")
} else {
    desc = get_event_description(game_state)    
}

var desc_width = string_width(desc)
draw_text(x + room_width / 2 - desc_width / 2, y + room_height - 24, desc)

draw_set_halign(fa_right);

draw_text_color(t_x + 16 + (global.BABYMODE ? 0 : 9), t_y + 20, string(strength) + (global.BABYMODE ? " : STR" : (" : " + global.t("ui.strength"))),strength_col,strength_col,strength_col,strength_col,1);
draw_text_color(t_x + 16 + (global.BABYMODE ? 0 : 9), t_y + 40, string(endurance) + (global.BABYMODE ? " : END" : (" : " + global.t("ui.endurance"))),endurance_col,endurance_col,endurance_col,endurance_col,1);
draw_text_color(t_x + 16 + (global.BABYMODE ? 0 : 9), t_y + 60, string(stamina) + (global.BABYMODE ? " : CON" : (" : " + global.t("ui.stamina"))),stamina_col,stamina_col,stamina_col,stamina_col,1);
draw_text_color(t_x + 16 + (global.BABYMODE ? 0 : 9), t_y + 80, string(wisdom) + (global.BABYMODE ? " : WIS" : (" : " + global.t("ui.wisdom"))),wisdom_col,wisdom_col,wisdom_col,wisdom_col,1);
draw_text_color(t_x + 16 + (global.BABYMODE ? 0 : 9), t_y + 100, string(inteligence) + (global.BABYMODE ? " : INT" : (" : " + global.t("ui.intelligence"))),inteligence_col,inteligence_col,inteligence_col,inteligence_col,1);

draw_set_halign(fa_left);

// Only draw 2nd half in ENGLISH
if (global.BABYMODE) {
    draw_text_color(t_x + 20, t_y + 20, "ength", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 20, t_y + 40, "urance", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 20, t_y + 60, "centration", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 20, t_y + 80, "dom", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 20, t_y + 100, "eligence", g_col, g_col, g_col, g_col, 1);
}

//HP
var t_hp_y = 100 + 48;
var hp_text = "";
var current_hp = 0;

repeat(player_hp) {
	hp_text += "*";
	current_hp ++;
	if (current_hp >= 8) {
		hp_text += "\n";
		current_hp = 0;
	}
}

var max_hp_text = ""
var current_max_hp = 00
repeat(player_max_hp) {
	max_hp_text += "*";
	current_max_hp ++;
	if (current_max_hp >= 8) {
		max_hp_text += "\n";
		current_max_hp = 0;
	}
}

draw_text_color(t_x - 48, t_hp_y, global.t("ui.health") + ":\n" + max_hp_text,c_dkgray,c_dkgray,c_dkgray,c_dkgray,1);
draw_text_color(t_x - 48, t_hp_y, global.t("ui.health") + ":\n" + hp_text,strength_col,strength_col,strength_col,strength_col,1);

//STAMINA
var cam = view_camera[0];
var cam_w = camera_get_view_width(cam);
var cam_h = camera_get_view_height(cam);
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
//draw_sprite_ext(spr_stamina, 0, cam_x + cam_w, cam_y, 1, cam_h, 0, strength_col, 0.5);
//draw_sprite_ext(spr_stamina, 0, cam_x + cam_w, cam_y, 1, cam_h * stamina_cd / (stamina * stamina_inc), 0, stamina_col, 0.5);
draw_sprite_ext(spr_stamina, 1, cam_x + cam_w / 2, cam_y + stamina_y, cam_w / 2 * stamina_cd / (stamina * stamina_inc), 1, 0, c_white, 0.5);


//DRAW CIRCULAR BAR AROUND MOUSE
//draw_circular_bar(mouse_x,y,value, _max, colour, radius, transparency, width)