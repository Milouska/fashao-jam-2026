global.enemy_attacks = [
  // Baby
  {
    attacks: [1, 1],
    hp: 6,
  },
  // Giant
  {
    attacks: [0, 1, 2, 3, 4],
    hp: 12,
  },
  // Manticore
  {
    attacks: [2, 0],
    hp: 8,
  },
  // Nightmare
  {
    attacks: [0, 0, 5],
    hp: 15,
    tokens: 4,
  },
  // Firelord
  {
    attacks: [2, 1],
    hp: 11,
  },
  // Cloud monkey
  {
    attacks: [2, 1, 2, 0],
    hp: 8,
    clouds: 9,
  },
  // Split screen
  {
    attacks: [5, 4, 3, 2, 0, 5, 4, 3, 1],
    hp: 12,
  },
  // Thorns
  {
    attacks: [3, 4, 0],
    hp: 19,
  },
  // Leech
  {
    attacks: [3, 3],
    hp: 14,
	  leech: 1, //how many stats does leech take
  }
]

// Base enemy pool
global.enemy_pool = [
    EnemyType.BABY,
	EnemyType.MANTICORE,
    EnemyType.GIANT,
]