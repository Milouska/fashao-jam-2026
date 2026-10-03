function get_random_weighted_event() {
    randomise()
    var rand = random_range(0, 1)
    var result = undefined
    
    // Combat is always more likely
    if (rand <=0.5) {
        result = GameState.COMBAT
    } else if (rand > 0.5 && rand <= 0.8) {
        // Semi-rare
        result = choose(
            GameState.WALK,
            GameState.FORK,
            GameState.BALANCE,
        )
    } else {
        // Very rare
        result = choose(
            GameState.CHEST,
            GameState.FOUNTAIN,
        )
    }
    
    return result
}

// Convert GameState event to a TokenType
function get_event_token(event) {
    switch(event) {
        case GameState.COMBAT: 
            return TokenType.EVENT_COMBAT
        case GameState.WALK: 
            return TokenType.EVENT_WALK
        case GameState.BALANCE: 
            return TokenType.EVENT_BALANCE    
        case GameState.CHEST: 
            return TokenType.EVENT_CHEST
        case GameState.FOUNTAIN: 
            return TokenType.EVENT_FOUNTAIN
        case GameState.FORK: 
            return TokenType.EVENT_FORK
        default:
            log("WE GOT UNKNOWN TOKEN FOR EVENT")
            log(event)    
    }
}

// Convert TokenType to GameState
function get_token_event(token) {
    switch(token) {
        case TokenType.EVENT_COMBAT:
            return GameState.COMBAT;
        case TokenType.EVENT_WALK:
            return GameState.WALK;
        case TokenType.EVENT_BALANCE:
            return GameState.BALANCE;
        case TokenType.EVENT_CHEST:
            return GameState.CHEST;
        case TokenType.EVENT_FOUNTAIN:
            return GameState.FOUNTAIN;
        case TokenType.EVENT_FORK:
            return GameState.FORK;
        default:
            log("WE GOT UNKNOWN EVENT FOR TOKEN");
            log(token);
    }
}

function get_event_description(event) {
    switch(event) {
        case GameState.COMBAT: 
            return ""
        case GameState.WALK: 
            return TokenType.EVENT_WALK
        case GameState.BALANCE: 
            return TokenType.EVENT_BALANCE    
        case GameState.CHEST: 
            return TokenType.EVENT_CHEST
        case GameState.FOUNTAIN: 
            return TokenType.EVENT_FOUNTAIN
        case GameState.FORK: 
            return TokenType.EVENT_FORK
        default:
            log("WE GOT UNKNOWN TOKEN FOR EVENT")
            log(event)    
    }
}