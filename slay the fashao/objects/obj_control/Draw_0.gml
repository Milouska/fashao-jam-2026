var g_col = make_color_rgb(120,120,120);

var t_x = 64;
var t_y = 0;

//STATS
draw_text(t_x - 48, t_y, "STATS");

draw_set_halign(fa_right);
draw_text_color(t_x, t_y + 16, string(strength) + " : STR",strength_col,strength_col,strength_col,strength_col,1);
draw_text_color(t_x, t_y + 32, string(endurance) + " : END",endurance_col,endurance_col,endurance_col,endurance_col,1);
draw_text_color(t_x, t_y + 48, string(stamina) + " : STA",stamina_col,stamina_col,stamina_col,stamina_col,1);
draw_text_color(t_x, t_y + 64, string(wisdom) + " : WIS",wisdom_col,wisdom_col,wisdom_col,wisdom_col,1);
draw_text_color(t_x, t_y + 80, string(inteligence) + " : INT",inteligence_col,inteligence_col,inteligence_col,inteligence_col,1);


draw_set_halign(fa_left);
draw_text_color(t_x + 2, t_y + 16, "ength", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, t_y + 32, "urance", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, t_y + 48, "mina", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, t_y + 64, "dom", g_col, g_col, g_col, g_col, 1);
draw_text_color(t_x + 2, t_y + 80, "eligence", g_col, g_col, g_col, g_col, 1);

//INVENTORY
var t_inv_y = 96 + 48;

draw_text(t_x - 48, t_inv_y, "INVENTORY");
for (var i = 0; i < array_length(inventory); i++) {
	var inv_text = "";
	switch (inventory[i]) {
		case InventoryItems.BOMB:
			inv_text = "Bomb";
		break;
		case InventoryItems.HEAL_POTION:
			inv_text = "Healing potion";
		break;
	}
	
	draw_text_color(t_x - 64, t_inv_y + 16 + i*16, inv_text, inventory_col, inventory_col, inventory_col, inventory_col, 1);
}