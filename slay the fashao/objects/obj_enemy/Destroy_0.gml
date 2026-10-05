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

if (death_callback)
    death_callback()