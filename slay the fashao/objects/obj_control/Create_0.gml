//////////////////////////////////////////
/// Tokens
//////////////////////////////////////////
strength = 0;
strength_col = make_colour_rgb(209, 15, 76);
endurance = 0;
endurance_col = make_colour_rgb(100, 164, 164);
stamina = 5;
stamina_col = make_colour_rgb(99, 179, 29);
wisdom = 0;
wisdom_col = make_colour_rgb(254, 72, 222);
inteligence = 0;
inteligence_col = make_colour_rgb(68, 48, 186);

enum TokenType {
    STRENGTH,
    ENDUREANCE,
    STAMINA,
}

// Handle player turn & token collisions
collided_first_type = -1
collided_tokens = []
turn_finished = false
turn_count = 0
turn_data = {
    strength: 0,
    endurance: 0,
}


// Should be called when player can start turn
function start_player_turn() {
    collided_tokens = []
    turn_finished = false
    turn_data = {
        strength: 0,
        endurance: 0,
    }
    turn_count++
}

function end_player_turn() {
    with(obj_line) disappear = true;

    turn_finished = true
    collided_first_type = -1
    
    for (var i = 0; i < array_length(collided_tokens); i++) {
        var token = collided_tokens[i]
        switch(token.type) {
            case TokenType.ENDUREANCE:
                turn_data.endurance += token.value
                break
            case TokenType.STRENGTH:
                turn_data.strength += token.value
                break
        }
    }
    
    log("END TURN")
    log(string("Collected {0}", turn_data))
    
}

function spawn_tokens() {
    with(obj_token) instance_destroy()
    
    repeat(5) {
        var ang = random(360);
   	    var len = random_range(0,16);
   	    var token = instance_create_depth(room_width / 2 + lengthdir_x(len, ang), room_height / 2 + lengthdir_y(len, ang), 0, obj_token);
        token.type = round(random_range(0, 2))
        // TODO: set token type & value
    }
}

// TODO: this needs to be called when COMBAT turn begins
start_player_turn()

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

game_event = GameState.WALK 

// Place code initiating an event HERE, spawning enemy, creating choice, etc
function start_event(event_type) {
    game_event = event_type
    
    switch(game_event) {
        case GameState.COMBAT:
            // Spawn
            var enemy = instance_create_layer(x + window_get_width() / 2, y + window_get_height() / 2, 0, obj_enemy)
            
            enemy.on_death = function () {
                // Called when enemy dies
            }
            
            break 
        
        case GameState.WALK:
            // Walking to the next stage
            break
        
        case GameState.CHOICE:
            // choice
            break    
        
         case GameState.OVER:
            // game over screen
            break
        
    }
}