draw_set_font(font_zh)
font_add_enable_aa(false)

var g_col = make_color_rgb(120,120,120);

var t_x = 88
var t_y = 24

// Turn
var turn_text = string(global.t("ui.turn"), game_rounds)
draw_text(room_width - string_width(turn_text) - 24, t_y, turn_text)

//STATS
draw_text(global.BABYMODE ? t_x - 48 : t_x + 20, t_y, global.t("ui.stats"));

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

draw_text_color(global.BABYMODE ? t_x : t_x + 16, t_y + 20, string(strength) + (global.BABYMODE ? " : STR" : (" " + global.t("ui.strength"))),strength_col,strength_col,strength_col,strength_col,1);
draw_text_color(global.BABYMODE ? t_x : t_x + 16, t_y + 40, string(endurance) + (global.BABYMODE ? " : END" : (" " + global.t("ui.endurance"))),endurance_col,endurance_col,endurance_col,endurance_col,1);
draw_text_color(global.BABYMODE ? t_x : t_x + 16, t_y + 60, string(stamina) + (global.BABYMODE ? " : CON" : (" " + global.t("ui.stamina"))),stamina_col,stamina_col,stamina_col,stamina_col,1);
draw_text_color(global.BABYMODE ? t_x : t_x + 16, t_y + 80, string(wisdom) + (global.BABYMODE ? " : WIS" : (" " + global.t("ui.wisdom"))),wisdom_col,wisdom_col,wisdom_col,wisdom_col,1);
draw_text_color(global.BABYMODE ? t_x : t_x + 16, t_y + 100, string(inteligence) + (global.BABYMODE ? " : INT" : (" " + global.t("ui.intelligence"))),inteligence_col,inteligence_col,inteligence_col,inteligence_col,1);

// Only draw 2nd half in ENGLISH
if (global.BABYMODE) {
    draw_set_halign(fa_left);
    draw_text_color(t_x + 2, t_y + 20, "ength", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 40, "urance", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 60, "centration", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 80, "dom", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 100, "eligence", g_col, g_col, g_col, g_col, 1);
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

draw_text_color(global.BABYMODE ? t_x - 48 : t_x + 32, t_hp_y, global.t("ui.health") + ":\n" + max_hp_text,c_dkgray,c_dkgray,c_dkgray,c_dkgray,1);
draw_text_color(global.BABYMODE ? t_x - 48 : t_x + 32, t_hp_y, global.t("ui.health") + ":\n" + hp_text,strength_col,strength_col,strength_col,strength_col,1);

//INVENTORY
//var t_inv_y = 130 + 48 + 24 * floor(player_hp / 10);
//
//draw_text(t_x - 48, t_inv_y, global.t("ui.inventory"));
//for (var i = 0; i < array_length(inventory); i++) {
	//var inv_text = "";
	//switch (inventory[i]) {
		//case InventoryItems.BOMB:
			//inv_text = global.t("item.bomb");
		//break;
		//case InventoryItems.HEAL_POTION:
			//inv_text = global.t("item.healing_potion");
		//break;
	//}
	//
	//draw_text_color(t_x - 64, t_inv_y + 16 + i*16, inv_text, inventory_col, inventory_col, inventory_col, inventory_col, 1);
//}


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