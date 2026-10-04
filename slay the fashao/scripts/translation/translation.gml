global.en = {
    "event.combat.text": "Fight to the death",
    "event.walk.text": "Improve one stat by a point",
    "event.balance.increase.text": "Choose stat to increase by 2",
    "event.balance.decrease.text": "Choose stat to decrease by 2",
    "event.chest.text": "You stumble upon a chest. It asks you to take one item",
    "event.fountain.text": "Max hp +1 and 1hp heal or stat +1?",
    "event.fork.text": "It appears the road splits into two.",
    "event.over.text": "You died. Again.",

    "event.over.enemies": "Kills",
    "event.over.damage": "Damage given",
    "event.over.taken": "Damage taken",
    "event.over.rounds": "Rounds",
    "event.over.tokens": "Tokens sliced",
    "event.over.intelligence": "Intelligence",
    "event.over.intelligence.high": "brilliant",
    "event.over.intelligence.mid": "curious...",
    "event.over.intelligence.low": "dumbass",

    "ui.stats": "STATS",
    "ui.strength": "Strength",
    "ui.endurance": "Endurance",
    "ui.stamina": "Stamina",
    "ui.wisdom": "Wisdom",
    "ui.intelligence": "Intelligence",
    "ui.health": "Health",
    "ui.inventory": "Inventory",
    "ui.turn": "Turn {0}",
}

global.zh = {
    "event.combat.text": "战斗至死",
    "event.walk.text": "你可以提升一项属性",
    "event.balance.text": "为一项属性加2点，但从另一项属性中扣除2点",
    "event.chest.text": "你偶然发现了一个宝箱。它要求你拿走一件物品",
    "event.fountain.text": "你在魔法泉水中沐浴。选择完全恢复生命，或提升一项属性",
    "event.fork.text": "道路似乎分成了两条。你会选择哪一条？",
    "event.over.text": "你死了。又一次。",

    "ui.stats": "统计数据",
    "ui.strength": "力量",
    "ui.endurance": "耐力",
    "ui.stamina": "体力",
    "ui.wisdom": "智慧",
    "ui.intelligence": "智力",
    "ui.health": "生命值",
    "ui.inventory": "背包",
}

global.BABYMODE = true

global.t = function(key) {
    if (!struct_exists(global.en, key)) {
        throw (string("Translation key {0} does not exist", key));
    }
    return struct_get(global.BABYMODE ? global.en : global.zh, key)
}