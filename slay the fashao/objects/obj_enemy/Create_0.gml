//enemies
enum EnemyType {
	BABY,
	GIANT,
	MANTICORE,
	NIGHTMARE
} 

death_callback = undefined

death_callback = undefined

enum EnemyState {
	APPEAR,
	IDLE,
	ATTACK,
}

enemy_state = EnemyState.APPEAR;
type = choose(EnemyType.BABY,
			  EnemyType.GIANT,
			  EnemyType.MANTICORE,
			  EnemyType.NIGHTMARE);

switch (type) {
	case EnemyType.BABY:
		enemy_attacks = [];
	break;
	case EnemyType.GIANT:
		enemy_attacks = [];
	break;
	case EnemyType.MANTICORE:
		enemy_attacks = [];
	break;
	case EnemyType.NIGHTMARE:
		enemy_attacks = [];
	break;
	default:
		enemy_attacks = [];
}


enemy_attack = 0;
attacking = false; //SET THIS TO TRUE IF YOU WANT ENEMY TO ATTACK
//attack effect
attack_a = pi/2;
enemy_scale = 0.5;
enemy_rot = 0;
enemy_a = pi / 4;
enemy_attack_a = - pi / 4 * 3;

//enemy appear effect
enemy_alpha = 0;