//enemies
enum EnemyType {
	BABY,
	GIANT,
	MANTICORE,
	NIGHTMARE
} 

death_callback = undefined

enum EnemyState {
	APPEAR,
	IDLE,
	ATTACK,
}

pending_slash = 0
pending_fireball = 0

// Collection of enemy damage per turn. Damage is displayed by an amount of icons corresponding to the dmg
enemy_attacks = []
enemy_turn_index = 0
enemy_hp = 0

enemy_state = EnemyState.APPEAR;
type = choose(EnemyType.BABY,
			  EnemyType.GIANT,
			  EnemyType.MANTICORE,
			  EnemyType.NIGHTMARE);

switch (type) {
	case EnemyType.BABY:
		enemy_attacks = [1, 1, 1, 1, 1];
		enemy_hp = 6
	break;
	case EnemyType.GIANT:
		enemy_attacks = [0, 1, 2, 3, 4, 5, 6];
		enemy_hp = 15
	break;
	case EnemyType.MANTICORE:
		enemy_attacks = [3, 0, 3, 0, 3, 0];
		enemy_hp = 8
	break;
	case EnemyType.NIGHTMARE:
		enemy_attacks = [1, 0, 2, 0];
		enemy_hp = 13
	break;
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