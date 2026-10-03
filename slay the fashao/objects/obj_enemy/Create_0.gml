//enemies
enum EnemyType {
	GHOST, //attack, dont attack
	SPIKY, //always one attack
}

type = choose(EnemyType.GHOST,
			  EnemyType.SPIKY);

switch (type) {
	case EnemyType.GHOST:
	
	break;
	case EnemyType.SPIKY:
	
	break;
	default:
		enemy_attacks = [];
}
enemy_attack = 0;