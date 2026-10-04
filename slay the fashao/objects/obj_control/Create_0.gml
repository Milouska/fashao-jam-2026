depth = -1
randomize()

defaults = {
    HP: 10,
    STRENGHT: 3,
    ENDURANCE: 3,
    STAMINA: 5,
    WISDOM: 0,
    INTELLIGENCE: 0,
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
// TODO: add player max hp


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
    EVENT_CHEST,
    EVENT_WALK,
    EVENT_HEAL,
    EVENT_COMBAT,
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
}

function end_player_turn() {
    with(obj_line) disappear = true;

    turn_finished = true
    collided_first_type = -1

    var turn_strength = 0
    var turn_fireball = 0
    var turn_endurance = 0
    var turn_stamina = 0

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
            // For heal event. We consume the token, heal player and get a random upcoming event
            case TokenType.EVENT_HEAL:
                // TODO: increase max HP by 1, heal 1
                player_hp = defaults.HP
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
        
        // ENDS AND CHANGE STATE
        call_later(20, time_source_units_frames, method(self, function() {
            start_random_event()
        }))
        
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
    // Transition to next level and add one skill point 
    WALK, 
    // Combat, normal & boss (boss has its own flag)
    COMBAT,
    // Choose between two random items
    CHEST,
    // ADD 2 points to something, remove two points from something else
    BALANCE,
    // Choose if you full-heal, or gain a WALK,
    FOUNTAIN,
    // Player gets to choose between two random game events (COMBAT, CHEST, BALANCING, FORK, WALK, FOUNTAIN)
    FORK,
    // Game over screen
    OVER,
    BOSS,
}

// Place code initiating an event HERE, spawning enemy, creating choice, etc
function start_event(state_type) {
    game_state = state_type
    game_rounds++
    
    switch(game_state) {
        case GameState.COMBAT:
            log("=== COMBAT ===")
            // Spawn
            enemy = instance_create_depth(x + window_get_width() / 2, y + window_get_height() / 2, 0, obj_enemy)
            enemy.on_death = method({ self }, function () {
                // FOR TESTING: we only start a new combat, but we SHOULD walk first
                call_later(1, time_source_units_seconds, method(self, function() {
                    //start_player_turn()
                    start_event(GameState.WALK)
                    enemy = noone
                }))
            })

            start_player_turn()
            break 
        
        case GameState.WALK:
            log("=== WALK ===")
            turn_finished = false
            // TODO: heal player by 1 hp
            spawn_token(TokenType.STRENGTH, 180, 7)
            spawn_token(TokenType.ENDUREANCE, 180, 20)
            spawn_token(TokenType.WISDOM, 0, 7)
            spawn_token(TokenType.STAMINA, 0, 20)
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
            
        case GameState.CHEST:
            log("=== CHEST ===")
            // TODO: same as fork, but only selects items
            break
        
        case GameState.BALANCE:
            log("=== BALANCE ===")
            // TODO: implement adding and removing
            break
        
        case GameState.FOUNTAIN:
            log("=== FOUNTAIN ===")
            turn_finished = false
            spawn_token(TokenType.EVENT_WALK, 180, 7)
            spawn_token(TokenType.EVENT_HEAL, 0, 7)
            break
        
         case GameState.OVER:
            log("=== GAME OVER ===")
            // TODO: implement game over screen
            break
        
        default:
            log("=== UNKNOWN EVENT ===")
            log(game_state)
            
        
    }
}

function start_random_event() {
    var result = get_random_weighted_event()
    start_event(result)
}

start_event(GameState.FORK)