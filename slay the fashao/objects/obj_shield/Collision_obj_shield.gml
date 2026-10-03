if (row = other.row) and (y = room_height - 24 - row * 64) and (gone = false)
	x += sign(sign(x - other.x) + choose(-0.1, 0.1)) * spd * 2;