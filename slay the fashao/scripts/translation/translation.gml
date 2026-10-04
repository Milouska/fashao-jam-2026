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
    "event.walk.text": "任意属性提升1点",
    "event.balance.increase.text": "选择一项属性提升2点",
    "event.balance.decrease.text": "选择一项属性降低2点",
    "event.chest.text": "你偶然发现了一个宝箱。它要你拿走一件物品",
    "event.fountain.text": "最大生命值+1并恢复1点生命，还是属性+1？",
    "event.fork.text": "前方的道路似乎分成了两条。",
    "event.over.text": "你死了。又一次。",

    "event.over.enemies": "击杀数",
    "event.over.damage": "造成伤害",
    "event.over.taken": "承受伤害",
    "event.over.rounds": "回合数",
    "event.over.tokens": "已切割代币",
    "event.over.intelligence": "智力",
    "event.over.intelligence.high": "天才",
    "event.over.intelligence.mid": "好奇……",
    "event.over.intelligence.low": "蠢货",

    "ui.stats": "属性",
    "ui.strength": "力量",
    "ui.endurance": "耐力",
    "ui.stamina": "体力",
    "ui.wisdom": "智慧",
    "ui.intelligence": "智力",
    "ui.health": "生命值",
    "ui.inventory": "背包",
    "ui.turn": "第{0}回合"
}

global.BABYMODE = true

global.t = function(key) {
    if (!struct_exists(global.en, key)) {
        throw (string("Translation key {0} does not exist", key));
    }
    return struct_get(global.BABYMODE ? global.en : global.zh, key)
}