if (row = other.row) and (y = room_height - 24 - row * 64) and (gone = false) and (image_index = 0) and (other.image_index = 0)
	x += sign(sign(x - other.x) + choose(-0.1, 0.1)) * spd * 2;