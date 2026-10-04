if (type = EnemyType.CLOUD_MONKEY) {
	with(obj_cloud) {
		gone = true;
	}
}

if (death_callback)
    death_callback()