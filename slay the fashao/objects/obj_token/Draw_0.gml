var thickness = 4;

if (type > 4) thickness = 6;

var bcol = make_color_rgb(100,100,100);

for (var i = 1; i < thickness; i++) {
	draw_sprite_ext(spr_token, type, x, y + i, image_xscale, image_yscale, image_angle, bcol, 1);
}

draw_sprite_ext(spr_token, type, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

if (selected) {
    draw_text(x, y, "*")
}

image_angle += spin * speed;