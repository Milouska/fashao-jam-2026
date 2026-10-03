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
    EVENT,
    COMBAT,
    CHEST,
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

    // Evaluate    
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
        }
    }
    
    with(obj_token) instance_destroy()
    collided_tokens = []

    enemy.pending_slash = turn_strength;
    enemy.pending_fireball = turn_fireball;
    enemy.alarm[0] = 15
}

function spawn_token(token_type) {
    var ang = random(360);
    var len = random_range(0, );
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
    // Chest or some other non-combat event
    CHOICE,
    // Game over screen
    OVER,
}

game_state = GameState.WALK

// Place code initiating an event HERE, spawning enemy, creating choice, etc
function start_event(state_type) {
    game_state = state_type
    
    switch(game_state) {
        case GameState.COMBAT:
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
            // Walking to the next stage
            //start_event(choose(GameState.COMBAT, GameState.CHOICE))
            
            // 1. spawn two random tokens
            repeat(2) {
                //spawn_token(choose(
                    //TokenType.EVENT,
                    //TokenType.RANDOM,
                    //TokenType.,
                //))
            }
            // 2. player slashes one, something happens,
            // 3. start_event based on result

            break
        
        case GameState.CHOICE:
            
            // 1. Spawn 2-3 choice tokens
            // 2. Allow player to only slash one
            // 3. after some effect / timeout call start_event() based on player choice
            
            // choice
            break    
        
         case GameState.OVER:
            // game over screen
            break
        
    }
}

start_event(GameState.COMBAT)