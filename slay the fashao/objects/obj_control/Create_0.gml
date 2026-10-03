//stats
strength = 0;
strength_col = make_colour_rgb(209, 15, 76);
endurance = 0;
endurance_col = make_colour_rgb(100, 164, 164);
stamina = 0;
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

// Handle collision with tokens when drawing
collided_tokens = []


//line
mouse_xprevious = mouse_x;
mouse_yprevious = mouse_y;

//events that happen in the dungeon
enum EventState {
    WALK, //walk to the next event
    COMBAT, //combat event
}

//inventory
enum InventoryItems {
    BOMB,
    HEAL_POTION,
}

inventory = [];
array_push(inventory, InventoryItems.BOMB);
array_push(inventory, InventoryItems.HEAL_POTION);
inventory_col = make_colour_rgb(232, 234, 74);