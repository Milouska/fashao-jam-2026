if (type = EnemyType.CLOUD_MONKEY) {
	with(obj_cloud) {
		gone = true;
	}
}

if (type = EnemyType.THORNS) {
	with(obj_barier) {
		thorned = false;
	}
}

if (type = EnemyType.SPLIT_SCREEN) {
	with(obj_screen_slash) {
		gone = true;
	}
}

if (death_callback)
    death_callback()