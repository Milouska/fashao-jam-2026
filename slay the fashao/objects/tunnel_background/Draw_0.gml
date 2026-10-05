draw_set_alpha(0.3);
//left half
draw_sprite_part(spr_bg, 0, 0, 0, 160 + fork_x, 240, x - 160 - fork_x, y - 120);

//right half
draw_sprite_part(spr_bg, 0, 160 - fork_x, 0, 160 + fork_x, 240, x, y - 120);

draw_set_alpha(1);