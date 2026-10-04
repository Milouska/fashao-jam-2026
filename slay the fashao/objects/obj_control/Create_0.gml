depth = -1
randomize()

defaults = {
    HP: 6,
    STRENGHT: 1,
    ENDURANCE: 1,
    STAMINA: 3,
    WISDOM: 0,
    INTELLIGENCE: 2,
}

stats = {
    enemies_killed: 0,
    damage_taken: 0,
    damage_given: 0,
    tokens_sliced: 0,
}

BABYMODE = false

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
stamina_inc = 15;
stamina_y = 0;

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
				spawn_token(TokenType.NIGHTMARE_TOKEN);
			}
		}
	}
}

function end_player_turn() {
    with(obj_line) disappear = true;

    turn_finished = true
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
            // For heal event. We consume the token, heal player and get a random upcoming event
            case TokenType.EVENT_HEAL:
                player_max_hp += 1
                heal(1)
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
        
        // ENDS AND CHANGE STATE
        call_later(20, time_source_units_frames, method(self, function() {
            start_random_event()
        }))
        
        return
    } else if (game_state == GameState.BALANCE) {
        strength = balance_turn == 1 ? strength + (turn_strength * 2) : strength - (turn_strength * 2) 
        wisdom = balance_turn == 1 ? wisdom + (turn_fireball * 2) : wisdom - (turn_fireball * 2) 
        endurance = balance_turn == 1 ? endurance + (turn_endurance * 2) : endurance - (turn_endurance * 2) 
        stamina = balance_turn == 1 ? stamina + (turn_stamina * 2) : stamina - (turn_stamina * 2) 
        inteligence = balance_turn == 1 ? inteligence + (turn_intelligence * 2) : inteligence - (turn_intelligence * 2) 
        
        if (balance_turn == 1) {
            start_event(GameState.BALANCE)
        } else {
            balance_turn = 0
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

function spawn_token(token_type, ang = random(360), len = random_range(0, 22)) {
    var token = instance_create_depth(room_width / 2 + lengthdir_x(len, ang), room_height / 2 + lengthdir_y(len, ang), 0, obj_token);
    token.type = token_type
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

player_dead = false

death_amount = 0;   // 0 - 1 tint strength
death_color  = [0.8, 0.0, 0.1]; // rgb
impact_timer = 0;   // in frames

function take_damage(dmg) {
    player_hp -= dmg
    
    if (player_hp <= 0) {
        player_dead = true
        
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

// Place code initiating an event HERE, spawning enemy, creating choice, etc
function start_event(state_type) {
    spawn_barier( state_type == GameState.COMBAT ? min(144 + game_rounds * 2, 200) : 144)
    
    game_state = state_type
    game_rounds++
    
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
                    
                    if (inst.stats.enemies_killed > 7 && inst.stats.enemies_killed <= 15) {
                        // Initial diff increase
                    } else if (inst.stats.enemies_killed > 15 && inst.stats.enemies_killed <= 25) {
                        // Mid-game
                    } else if (inst.stats.enemies_killed > 25) {
                        // End-game
                    }
                }))
            })

            start_player_turn()
            
            break 
        
        case GameState.WALK:
            log("=== WALK ===")
            turn_finished = false
            
            spawn_token(TokenType.STRENGTH, 0, 3)
            spawn_token(TokenType.ENDUREANCE, 72, 5)
            spawn_token(TokenType.WISDOM, 144, 3)
            spawn_token(TokenType.STAMINA, 216, 5)
            spawn_token(TokenType.INTELIGENCE, 288, 0)
            
            heal()
            
            break
        
        case GameState.FORK:
            log("=== FORK ===")
            turn_finished = false
            var first = get_random_weighted_event();
            var second = get_random_weighted_event()
            
            while(second == first) {
                second = get_random_weighted_event()
            }

            spawn_token(get_event_token(first), 180, 7)
            spawn_token(get_event_token(second), 0, 7)
            
            break
        
        case GameState.BALANCE:
            log("=== BALANCE ===")
            turn_finished = false
            balance_turn++

            if(balance_turn == 1 || balance_turn == 2 && strength >= 2) spawn_token(TokenType.STRENGTH, 0, 3)
            if(balance_turn == 1 || balance_turn == 2 && endurance >= 2) spawn_token(TokenType.ENDUREANCE, 72, 5)
            if(balance_turn == 1 || balance_turn == 2 && wisdom >= 2) spawn_token(TokenType.WISDOM, 144, 3)
            if(balance_turn == 1 || balance_turn == 2 && stamina >= 2) spawn_token(TokenType.STAMINA, 216, 5)
            if(balance_turn == 1 || balance_turn == 2 && inteligence >= 2) spawn_token(TokenType.INTELIGENCE, 288, 0)
                
            break
        
        case GameState.FOUNTAIN:
            log("=== FOUNTAIN ===")
            turn_finished = false
            spawn_token(TokenType.EVENT_WALK, 180, 7)
            spawn_token(TokenType.EVENT_HEAL, 0, 7)
            
            break
        
         case GameState.OVER:
            log("=== GAME OVER ===")
            with(obj_token) { instance_destroy() }
            obj_enemy.enemy_attacks = [0,0,0,0,0,0,0]
                
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
    }
}

/// START OF THE GAME VvvvvV
start_event(GameState.COMBAT)