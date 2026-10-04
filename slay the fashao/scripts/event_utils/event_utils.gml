function get_random_weighted_event() {
    return choose(
        GameState.COMBAT,
        GameState.COMBAT,
        GameState.COMBAT,
        GameState.COMBAT,
        GameState.COMBAT,
        GameState.COMBAT,
        GameState.COMBAT,
        GameState.COMBAT,
        GameState.FORK,
        GameState.FORK,
        GameState.FORK,
        GameState.BALANCE,
        GameState.BALANCE,
        GameState.FOUNTAIN,
    )
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
        //case GameState.CHEST: 
            //return TokenType.EVENT_CHEST
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
        //case TokenType.EVENT_CHEST:
            //return GameState.CHEST;
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
            return global.t("event.combat.text")
        case GameState.WALK: 
            return global.t("event.walk.text")
        case GameState.FOUNTAIN: 
            return global.t("event.fountain.text") 
        case GameState.FORK: 
            return global.t("event.fork.text") 
        case GameState.OVER: 
            return global.t("event.over.text") 
        default:
            log("WE GOT UNKNOWN TOKEN FOR EVENT")
            log(event)    
    }
}