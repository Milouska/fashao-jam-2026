draw_set_font(font_zh)
font_add_enable_aa(false)

var g_col = make_color_rgb(120,120,120);

var t_x = 64;
var t_y = 12;

//STATS
draw_text(t_x - 48, t_y, "STATS");

// TODO: render these by splitting the translation at the 3rd character in ENGLISH, in CHINESE the 

draw_set_halign(fa_right);

draw_text_color(t_x, t_y + 16, string(strength) + (global.BABYMODE ? " : STR" : global.t("ui.strength")),strength_col,strength_col,strength_col,strength_col,1);
draw_text_color(t_x, t_y + 32, string(endurance) + (global.BABYMODE ? " : END" : global.t("ui.endurance")),endurance_col,endurance_col,endurance_col,endurance_col,1);
draw_text_color(t_x, t_y + 48, string(stamina) + (global.BABYMODE ? " : CON" : global.t("ui.stamina")),stamina_col,stamina_col,stamina_col,stamina_col,1);
draw_text_color(t_x, t_y + 64, string(wisdom) + (global.BABYMODE ? " : WIS" : global.t("ui.wisdom")),wisdom_col,wisdom_col,wisdom_col,wisdom_col,1);
draw_text_color(t_x, t_y + 80, string(inteligence) + (global.BABYMODE ? " : INT" : global.t("ui.intelligence")),inteligence_col,inteligence_col,inteligence_col,inteligence_col,1);

// Only draw 2nd half in ENGLISH
if (global.BABYMODE) {
    draw_set_halign(fa_left);
    draw_text_color(t_x + 2, t_y + 16, "ength", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 32, "urance", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 48, "centration", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 64, "dom", g_col, g_col, g_col, g_col, 1);
    draw_text_color(t_x + 2, t_y + 80, "eligence", g_col, g_col, g_col, g_col, 1);
}

//HP
var t_hp_y = 86 + 48;
var hp_text = "";
var current_hp = 0;
repeat(player_hp) {
	hp_text += "*";
	current_hp ++;
	if (current_hp >= 10) {
		hp_text += "\n";
		current_hp = 0;
	}
}
draw_text_color(t_x - 64, t_hp_y, global.t("ui.health") + ":\n" + hp_text,strength_col,strength_col,strength_col,strength_col,1);

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


//DRAW CIRCULAR BAR AROUND MOUSE
//draw_circular_bar(mouse_x,y,value, _max, colour, radius, transparency, width)