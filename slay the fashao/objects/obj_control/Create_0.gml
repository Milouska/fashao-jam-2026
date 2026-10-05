depth = -1
randomize()

defaults = {
    HP: 6,
    STRENGHT: 1,
    ENDURANCE: 1,
    STAMINA: 5,
    WISDOM: 0,
    INTELLIGENCE: 4,
}

stats = {
    enemies_killed: 0,
    damage_taken: 0,
    damage_given: 0,
    tokens_sliced: 0,
}

swipe_started = false;

//////////////////////////////////////////
/// Tokens
//////////////////////////////////////////
strength = defaults.STRENGHT;
strength_col = make_colour_rgb(209, 15, 76);
endurance = defaults.ENDURANCE;
endurance_col = make_colour_rgb(100, 164, 164);
stamina = defaults.STAMINA;
stamina_col = make_colour_rgb(99, 179, 29);
wisdom = defaults.WISDOM;
wisdom_col = make_colour_rgb(254, 72, 222);
inteligence = defaults.INTELLIGENCE;
inteligence_col = make_colour_rgb(68, 48, 186);
player_hp = defaults.HP;
player_max_hp = defaults.HP

stamina_cd = 0;
stamina_inc = 9;
stamina_y = 0;

thorned = false; //for checking thorn interaction

function heal(by = 1) {
    player_hp = min(player_hp + by, player_max_hp)    
}

game_state = GameState.WALK
game_rounds = 0

var enemy = noone


////////////// DO NOT REORDER THESE vvvvvv
enum TokenType {
    // THESE ICONS HAVE DIFFERENT SHAPES
    STRENGTH,
    ENDUREANCE,
    STAMINA,
    WISDOM,
	INTELIGENCE,
    
    // THESE ICONS ARE ROUND, WITH SOME ART IN IT
    EVENT_FOUNTAIN,
    EVENT_BALANCE,
    EVENT_FORK,
    //EVENT_CHEST,
    EVENT_WALK,
    EVENT_HEAL,
    EVENT_COMBAT,
	
	// ENEMY TOKENS
	NIGHTMARE_TOKEN,
    
    BASIC_QUIT,
    BASIC_RESTART,
    BASIC_SCREENSHOT,
}
////////////// DO NOT REORDER THESE ^^^^^^

// Handle player turn & token collisions
collided_first_type = -1
collided_tokens = []
turn_finished = false

// Should be called when player can start turn
function start_player_turn() {
    turn_endurance = 0
    turn_finished = false
    
    repeat(strength) { spawn_token(TokenType.STRENGTH) }
    repeat(endurance) { spawn_token(TokenType.ENDUREANCE) }
    repeat(wisdom) { spawn_token(TokenType.WISDOM) }
	
	with(obj_enemy) {
		if (type == EnemyType.NIGHTMARE) {
			repeat(tokens_spawn) {
				obj_control.spawn_token(TokenType.NIGHTMARE_TOKEN);
			}
		}
	}
}

function end_player_turn() {
    with(obj_line) disappear = true;
	with(tunnel_background) fork = false;
	with(obj_event_bg) {
		if (image_index = 2) {
			state = 1;
		}
	}
	with(obj_levelup_bg) state = 1;

    turn_finished = true
    swipe_started = false
    collided_first_type = -1

    var turn_strength = 0
    var turn_fireball = 0
    var turn_endurance = 0
    var turn_stamina = 0
    var turn_intelligence = 0
    
    var token_event_type = -1
    
    for (var i = 0; i < array_length(collided_tokens); i++) {
        var token = collided_tokens[i]
        switch(token.type) {
            case TokenType.ENDUREANCE:
                turn_endurance += token.value
                break
            case TokenType.STRENGTH:
                turn_strength += token.value
                break
            case TokenType.WISDOM:
                turn_fireball += token.value
                break
            case TokenType.STAMINA:
                turn_stamina += token.value
                break
            case TokenType.INTELIGENCE:
                turn_intelligence += token.value
                break
            case TokenType.BASIC_QUIT:
                call_later(20, time_source_units_frames, method({ token_event_type, inst: id }, function() {
                    game_end()
                }))
                break
            case TokenType.BASIC_RESTART:
                call_later(20, time_source_units_frames, method({ token_event_type, inst: id }, function() {
                    game_restart()
                }))
                break
            case TokenType.BASIC_SCREENSHOT:
                screenshot_prompt()
                with(obj_token) {
                    if (type == TokenType.BASIC_SCREENSHOT) {
                        instance_destroy()
                    }
                }
                return;
            // For heal event. We consume the token, heal player and get a random upcoming event
            case TokenType.EVENT_HEAL:
                player_max_hp += 1
                heal(3)
                token_event_type = get_random_weighted_event()
                break
            // All non-value tokens aka EVENT tokens can just be saved
            default:
                token_event_type = get_token_event(token.type)
                
        }
    }
    
    with(obj_token) instance_destroy()
    collided_tokens = []
        
    // For events, we do not want to run code related to combat etc, 
    // so after the switch we do our logic and cancel the rest of the method
    if (token_event_type > -1) {
        call_later(20, time_source_units_frames, method({ token_event_type, inst: id }, function() {
            inst.start_event(token_event_type)
        }))
        
        return
    }

    // Up until here, we can treat WALK the same as COMBAT, however
    // there are no enemies. We simply change the global values here
    if (game_state == GameState.WALK) {
        strength += turn_strength
        wisdom += turn_fireball
        endurance += turn_endurance
        stamina += turn_stamina
        inteligence += turn_intelligence
		
		if (turn_strength) {
			var stat = instance_create_depth(32, 55, -4, obj_stat);
			stat.type = TokenType.STRENGTH;
		}
		if (turn_endurance) {
			var stat = instance_create_depth(32, 75, -4, obj_stat);
			stat.type = TokenType.ENDUREANCE;
		}
		if (turn_stamina) {
			var stat = instance_create_depth(32, 95, -4, obj_stat);
			stat.type = TokenType.STAMINA;
		}
		if (turn_fireball) {
			var stat = instance_create_depth(32, 115, -4, obj_stat);
			stat.type = TokenType.WISDOM;
		}
		if (turn_intelligence) {
			var stat = instance_create_depth(32, 135, -4, obj_stat);
			stat.type = TokenType.INTELIGENCE;
		}
        
        call_later(20, time_source_units_frames, method(self, function() {
            // Always start combat after the first walk
            if (game_rounds == 1) {
                start_event(GameState.COMBAT)
            } else {
                start_random_event()
            }
        }))
        
        return
    } else if (game_state == GameState.BALANCE) {
        strength = balance_turn == 1 ? strength + (turn_strength * 2) : strength - (turn_strength * 2) 
        wisdom = balance_turn == 1 ? wisdom + (turn_fireball * 2) : wisdom - (turn_fireball * 2) 
        endurance = balance_turn == 1 ? endurance + (turn_endurance * 2) : endurance - (turn_endurance * 2) 
        stamina = balance_turn == 1 ? stamina + (turn_stamina * 2) : stamina - (turn_stamina * 2) 
        inteligence = balance_turn == 1 ? inteligence + (turn_intelligence * 2) : inteligence - (turn_intelligence * 2)
		
		if (turn_strength) {
			var stat = instance_create_depth(32, 55, -4, obj_stat);
			stat.type = TokenType.STRENGTH;
		}
		if (turn_endurance) {
			var stat = instance_create_depth(32, 75, -4, obj_stat);
			stat.type = TokenType.ENDUREANCE;
		}
		if (turn_stamina) {
			var stat = instance_create_depth(32, 95, -4, obj_stat);
			stat.type = TokenType.STAMINA;
		}
		if (turn_fireball) {
			var stat = instance_create_depth(32, 115, -4, obj_stat);
			stat.type = TokenType.WISDOM;
		}
		if (turn_intelligence) {
			var stat = instance_create_depth(32, 135, -4, obj_stat);
			stat.type = TokenType.INTELIGENCE;
		}
        
        if (balance_turn == 1) {
            start_event(GameState.BALANCE)
			with(obj_event_bg) image_index = 1;
        } else {
            balance_turn = 0
			with(obj_event_bg) state = 1;
            // Balance counts two rounds, remove one here
            game_rounds--
            call_later(20, time_source_units_frames, method(self, function() {
                start_random_event()
            }))
        }
        
        return
    }
    
    // PLACE ALL COMBAT RELATED CODE BELOW VVVVVVVVVVVVVVVVVVVVV
	var max_shield_row = 9;
	var shield_count = 0;
	var row = 0;
	repeat(turn_endurance) {
		var shield = instance_create_depth(room_width / 2 + choose(-1, 1), room_height + 16, - 5, obj_shield);
		if (shield_count = max_shield_row) {
			row ++;
			shield_count = 0;
		}
		shield.row = row;
		shield_count ++;
	}

    enemy.pending_slash = turn_strength;
    enemy.pending_fireball = turn_fireball;
    enemy.alarm[0] = 15
}

player_dead = false

function spawn_token(token_type, ang = random(360), len = random_range(0, 22), spd = 0, dir = 0) {
    if (player_dead && token_type != TokenType.BASIC_QUIT) && (player_dead && token_type != TokenType.BASIC_RESTART) && (player_dead && token_type != TokenType.BASIC_SCREENSHOT) {
        return
    }
    
    var token = instance_create_depth(room_width / 2 + lengthdir_x(len, ang), room_height / 2 + lengthdir_y(len, ang), 0, obj_token);
    token.type = token_type
	
	if (spd > 0) {
		token.speed = spd;
		token.direction = dir;
	}
}

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

//////////////////////////////////////////
/// DEATH
//////////////////////////////////////////

application_surface_draw_enable(false);

u_tint   = shader_get_uniform(sh_effects, "u_tint");
u_amount = shader_get_uniform(sh_effects, "u_amount");
u_impact = shader_get_uniform(sh_effects, "u_impact");

death_amount = 0;   // 0 - 1 tint strength
death_color  = [0.8, 0.0, 0.1]; // rgb
impact_timer = 0;   // in frames

game_start_timestamp = current_time
game_length_seconds = 0

function take_damage(dmg) {
    player_hp -= dmg
	
	var iteration = dmg;
	repeat(dmg) {
		var stat = instance_create_depth(44 + (player_hp+iteration - 1)%8 * 11, room_height / 2 - 10 + floor((player_hp+iteration - 1)/8) * 20, -4, obj_stat);
		stat.type = 0;
		stat.damage = true;
		iteration --;
	}
    
    if (player_hp <= 0) {
        player_dead = true
        game_length_seconds = (current_time - game_start_timestamp) / 1000
        
        call_later(30, time_source_units_frames, method(self, function() {
            start_event(GameState.OVER)
        }))
    }
}

//////////////////////////////////////////
/// GAME STATE
//////////////////////////////////////////

enum GameState {
    // Transition to next level and add one skill point 
    WALK, 
    // Combat, normal & boss (boss has its own flag)
    COMBAT,
    // Choose between two random items
    // ADD 2 points to something, remove two points from something else
    BALANCE,
    // Choose if you full-heal, or gain a WALK,
    FOUNTAIN,
    // Player gets to choose between two random game events (COMBAT, CHEST, BALANCING, FORK, WALK, FOUNTAIN)
    FORK,
    // Game over screen
    OVER,
}

balance_turn = 0
queue_bossfight = false

// Place code initiating an event HERE, spawning enemy, creating choice, etc
function start_event(state_type) {
    spawn_barier( state_type == GameState.COMBAT ? min(144 + game_rounds * 2, 200) : 144)
    
    game_state = state_type
    game_rounds++
    
    // First fight after these specific rounds will be a bossfight
    if (game_rounds == 35 || game_rounds == 65 || game_rounds == 100) {
        queue_bossfight = true
    }
    
    switch(game_state) {
        case GameState.COMBAT:
            log("=== COMBAT ===")
            
            // Spawn
            enemy = instance_create_depth(x + window_get_width() / 2, y + window_get_height() / 2, 0, obj_enemy)
            enemy.death_callback = method({ inst: id }, function () {
                // FOR TESTING: we only start a new combat, but we SHOULD walk first
                call_later(1, time_source_units_seconds, method({ inst }, function() {
                    inst.start_event(GameState.WALK)
                    inst.stats.enemies_killed += 1
                    
                    // VVVVVVV BALANCE HERE VVVVVVVVV
                    if (inst.game_rounds > 12 && inst.game_rounds <= 30) {
                        global.enemy_pool = [
                            EnemyType.MANTICORE,
                            EnemyType.FIRELORD,
                            EnemyType.CLOUD_MONKEY,
                            EnemyType.NIGHTMARE
                        ]
                    } else if (inst.game_rounds > 30 && inst.game_rounds <= 50) {
                        global.enemy_attacks[EnemyType.BABY].hp = 11
                        global.enemy_attacks[EnemyType.BABY].attacks = [3, 3]
                        global.enemy_attacks[EnemyType.GIANT].attacks = [2, 3, 4, 5, 6, 7]
                        global.enemy_attacks[EnemyType.GIANT].hp = 18

                        global.enemy_attacks[EnemyType.NIGHTMARE].attacks = [0,0,6]
                        global.enemy_attacks[EnemyType.NIGHTMARE].hp = 14

                        global.enemy_attacks[EnemyType.CLOUD_MONKEY].clouds = 13
						global.enemy_attacks[EnemyType.NIGHTMARE].tokens = 7
                        global.enemy_attacks[EnemyType.NIGHTMARE].hp = 16
                        global.enemy_attacks[EnemyType.NIGHTMARE].attacks = [3, 2, 3, 0]

                        global.enemy_pool = [
                            EnemyType.BABY,
                            EnemyType.GIANT,
                            EnemyType.FIRELORD,
                            EnemyType.CLOUD_MONKEY,
                            EnemyType.NIGHTMARE,
                            EnemyType.LEECH,
                            EnemyType.THORNS,
                        ]
                    } else if (inst.game_rounds > 50) {
                        global.enemy_attacks[EnemyType.GIANT].attacks = [2, 3, 4, 5, 6, 7, 8, 9]
                        global.enemy_attacks[EnemyType.GIANT].hp = 32
						global.enemy_attacks[EnemyType.NIGHTMARE].tokens = 10
                        global.enemy_pool = [
                            EnemyType.BABY,
                            EnemyType.MANTICORE,
                            EnemyType.GIANT,
                            EnemyType.FIRELORD,
                            EnemyType.CLOUD_MONKEY,
                            EnemyType.NIGHTMARE,
                            EnemyType.LEECH,
                            EnemyType.THORNS,
                            EnemyType.SPLIT_SCREEN,
                        ]
                    }
                }))
            })

            start_player_turn()
            
            break 
        
        case GameState.WALK:
            log("=== WALK ===")
            turn_finished = false
			
			instance_create_depth(room_width / 2, room_height / 2, 100, obj_levelup_bg);
            
            spawn_token(TokenType.STRENGTH, 90, 24, 2, 90)
            spawn_token(TokenType.STAMINA, 18, 24, 2, 18)
            spawn_token(TokenType.WISDOM, 234, 24, 2, 234)
            spawn_token(TokenType.ENDUREANCE, 162, 24, 2, 162)
            spawn_token(TokenType.INTELIGENCE, 306, 24, 2, 306)
            
            break
        
        case GameState.FORK:
            log("=== FORK ===")
            turn_finished = false
			with(tunnel_background) fork = true;
            var first = get_random_weighted_event();
            var second = get_random_weighted_event()
            
            while(second == first) {
                second = get_random_weighted_event()
            }

            spawn_token(get_event_token(first), 40, 96, 2, 270)
            spawn_token(get_event_token(second), 140, 96, 2, 270)
            
            break
        
        case GameState.BALANCE:
            log("=== BALANCE ===")
            turn_finished = false
            balance_turn++

            if(balance_turn == 1 || balance_turn == 2 && strength >= 2) spawn_token(TokenType.STRENGTH, 0, 100, 3, 90 + (balance_turn - 1) * 180)
            if(balance_turn == 1 || balance_turn == 2 && endurance >= 2) spawn_token(TokenType.ENDUREANCE, 0, 50, 3, 90 + (balance_turn - 1) * 180)
            if(balance_turn == 1 || balance_turn == 2 && wisdom >= 2) spawn_token(TokenType.WISDOM, 0, 0, 4.5, 90 + (balance_turn - 1) * 180)
            if(balance_turn == 1 || balance_turn == 2 && stamina >= 2) spawn_token(TokenType.STAMINA, 180, 50, 3, 90 + (balance_turn - 1) * 180)
            if(balance_turn == 1 || balance_turn == 2 && inteligence >= 2) spawn_token(TokenType.INTELIGENCE, 180, 100, 3, 90 + (balance_turn - 1) * 180)
			
			if (!instance_exists(obj_event_bg)) or (instance_exists(obj_event_bg) and (obj_event_bg.state = 1)) {
				var bg = instance_create_depth(room_width / 2, room_height / 2, 100, obj_event_bg);
				bg.image_index = 0;
			}
                
            break
        
        case GameState.FOUNTAIN:
            log("=== FOUNTAIN ===")
            turn_finished = false
            spawn_token(TokenType.EVENT_WALK, 40, 96, 2, 270)
            spawn_token(TokenType.EVENT_HEAL, 140, 96, 2, 270)
			//heal(1)
			var bg = instance_create_depth(room_width / 2, room_height / 2, 100, obj_event_bg);
			bg.image_index = 2;
            
            break
        
         case GameState.OVER:
            log("=== GAME OVER ===")
            with(obj_token) { instance_destroy() }
            with(obj_enemy) { enemy_attacks = [0,0,0,0,0,0,0] }
            spawn_token(TokenType.BASIC_RESTART, 0, 20)
            spawn_token(TokenType.BASIC_QUIT, 180, 20)            
            spawn_token(TokenType.BASIC_SCREENSHOT, 270, 20)
                
            break
        
        default:
            log("=== UNKNOWN EVENT ===")
            throw string("Bro tried to use {0} as an event", game_state)
    }
}

function start_random_event() {
    var result = get_random_weighted_event()
    start_event(result)
}

function spawn_barier(radius = 144) {
    with(obj_barier) instance_destroy()
    
    var offset = 2;
    for (var i = 0; i < 360 / offset; i ++) {
    	var barier = instance_create_depth(room_width / 2 + lengthdir_x(radius, i * offset),room_height / 2+lengthdir_y(radius, i * offset),-1000,obj_barier)
    	barier.image_angle = i * offset;
        barier.radius = radius
		
		if (i%30 = 0) {
			barier.can_thorn = true;
		}
    }
}

/// START OF THE GAME - always walk VvvvvV
start_event(GameState.WALK)
