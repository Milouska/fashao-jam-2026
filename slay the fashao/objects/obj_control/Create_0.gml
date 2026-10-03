depth = -1
randomize()

//////////////////////////////////////////
/// Tokens
//////////////////////////////////////////
strength = 3;
strength_col = make_colour_rgb(209, 15, 76);
endurance = 3;
endurance_col = make_colour_rgb(100, 164, 164);
stamina = 5;
stamina_col = make_colour_rgb(99, 179, 29);
wisdom = 0;
wisdom_col = make_colour_rgb(254, 72, 222);
inteligence = 0;
inteligence_col = make_colour_rgb(68, 48, 186);
player_hp = 10;

var enemy = noone

enum TokenType {
    STRENGTH,
    ENDUREANCE,
    STAMINA,
    WISDOM,
    
    // Other tokens
    RANDOM,
    //EVENT,
    //COMBAT,
    //CHEST,
}

// Handle player turn & token collisions
collided_first_type = -1
collided_tokens = []
turn_finished = false

turn_endurance = 0

// Should be called when player can start turn
function start_player_turn() {
    turn_endurance = 0
    turn_finished = false
    
    repeat(strength) { spawn_token(TokenType.STRENGTH) }
    repeat(endurance) { spawn_token(TokenType.ENDUREANCE) }
    repeat(wisdom) { spawn_token(TokenType.WISDOM) }
}

function end_player_turn() {
    with(obj_line) disappear = true;

    turn_finished = true
    collided_first_type = -1

    var turn_strength = 0
    var turn_fireball = 0
    var turn_endurance_temp = 0

    // Evaluate    
    for (var i = 0; i < array_length(collided_tokens); i++) {
        var token = collided_tokens[i]
        switch(token.type) {
            case TokenType.ENDUREANCE:
                turn_endurance_temp += token.value
                break
            case TokenType.STRENGTH:
                turn_strength += token.value
                break
            case TokenType.WISDOM:
                turn_fireball += token.value
                break
        }
    }
    
    with(obj_token) instance_destroy()

    // Up until here, we can treat WALK the same as COMBAT, however
    // there are no enemies. We simply change the global values here
    // THIS MUST RUN BEFORE ANY OTHER COMBAT PROCESSING CODE
    if (game_state == GameState.WALK) {
        strength += turn_strength
        wisdom += turn_fireball
        endurance += turn_endurance_temp
        
        // ENDS AND CHANGE STATE
        call_later(1, time_source_units_seconds, method(self, function() {
            start_random_event()
        }))
        
        return
    }
    // HERE VVVVVVVVVVVVVVVVVVV 
	
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
    
    collided_tokens = []
    turn_endurance = turn_endurance_temp

    enemy.pending_slash = turn_strength;
    enemy.pending_fireball = turn_fireball;
    enemy.alarm[0] = 15
}

function spawn_token(token_type) {
    var ang = random(360);
    var len = random_range(0, 22);
    var token = instance_create_depth(room_width / 2 + lengthdir_x(len, ang), room_height / 2 + lengthdir_y(len, ang), 0, obj_token);
    token.type = token_type
}

mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

//////////////////////////////////////////
/// Inventory
//////////////////////////////////////////
enum InventoryItems {
    BOMB,
    HEAL_POTION,
}

inventory = [];
array_push(inventory, InventoryItems.BOMB);
array_push(inventory, InventoryItems.HEAL_POTION);
inventory_col = make_colour_rgb(232, 234, 74);

//////////////////////////////////////////
/// GAME STATE
//////////////////////////////////////////

enum GameState {
    // Transition to next level
    WALK, 
    // Combat, normal & boss (boss has its own flag)
    COMBAT,
    // Choose between two random items
    CHEST,
    // ADD 2 points to something, remove two points from something else
    BALANCING,
    // Choose if you full-heal, or gain a WALK,
    FOUNTAIN,
    // Player gets to choose between two random game events (COMBAT, CHEST, BALANCING, FORK, WALK, FOUNTAIN)
    FORK,
    // Game over screen
    OVER,
    BOSS,
}

game_state = GameState.WALK
game_rounds = 0

// Place code initiating an event HERE, spawning enemy, creating choice, etc
function start_event(state_type) {
    game_state = state_type
    game_rounds++
    
    switch(game_state) {
        case GameState.COMBAT:
            log("=== STARTING COMBAT ===")
            // Spawn
            enemy = instance_create_depth(x + window_get_width() / 2, y + window_get_height() / 2, 0, obj_enemy)
            enemy.on_death = method({ self }, function () {
                // FOR TESTING: we only start a new combat, but we SHOULD walk first
                call_later(1, time_source_units_seconds, method(self, function() {
                    //start_player_turn()
                    start_event(GameState.WALK)
                }))
            })

            start_player_turn()
            break 
        
        case GameState.WALK:
            log("=== STARTING WALK ===")
            // Walking to the next stage
            //start_event(choose(GameState.COMBAT, GameState.CHOICE))
            
            // 1. spawn two random tokens
            turn_finished = false
            spawn_token(TokenType.STRENGTH)
            spawn_token(TokenType.ENDUREANCE)
            spawn_token(TokenType.WISDOM)
            spawn_token(TokenType.STAMINA)
            
            // turn finished is

            break
        
        case GameState.FORK:
            log("=== STARTING FORK ===")
            // 1. Spawn 2-3 choice tokens
            // 2. Allow player to only slash one
            // 3. after some effect / timeout call start_event() based on player choice
            
            // choice
            break    
        
         case GameState.OVER:
            log("=== GAME OVER ===")
            // game over screen
            break
        
        default:
            log("=== UNKNOWN EVENT ===")
            
        
    }
}

function start_random_event() {
    var new_event = choose(
        GameState.FORK,
        GameState.COMBAT,
        GameState.BALANCING,
        GameState.CHEST,
        GameState.FORK,
    )
}

start_event(GameState.WALK)