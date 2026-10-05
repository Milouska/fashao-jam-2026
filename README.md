# In Japanese, "Katana" means "Chinese Sword"

Is a 2026 Fashao Meng game jam entry about slicing tokens in a limited time, which then determine your actions. With many unique enemies and non-combat events. Share screenshots of your death screens with us!

You are deaf and you embark on a journey through a long tube. What lies inside? Nobody knows. 

Game made by [Milouska](https://github.com/Milouska) and [dolanske](https://github.com/dolanske) :3

![Capsule](/fashao2026-capsule.png)

## Tools used

All images and sprites were either drawn or sourced online. With strong dilligence to avoid AI-generated content.

- Gamemaker 2
- Aseprite
- SLK Image 2 Pixel tool



## TODO

- [x] General gameplay loop (fight -> walk -> XP -> Choice)
- [x] Choice screen
- [x] Collect statistics
- [x] Screen backgrounds
- [x] XP screen
- [x] Translations
  - [x] Fix chinese text positions
  - [x] Redo translations when we have all english text in-game + add them to font
- [x] Change to pixel font which supports chinese
- [x] Token icons
- [x] Scale enemies after each bossfight
- [x] Add max HP
- [x] Implement wisdom token detection
- [x] Add shader effects
- [x] Add combat timer
- [x] If you hit token that you click it and go, it will instantly be clicked, starts a combat and immediately an attack is triggered
- [x] Dying does not delete all tokens  (just find out where they are getting spawned)
- [x] After initial walk, there is ALWAYS combat
- [x] Screen resize stretches game
- [x] End screen
- [x] Add objects to events
- [ ] Each enemy draws its own simple background. Each background should be super low alpha but with a different color
- [ ] Add enemy balancing after X turns
- [ ] Balancing
- [ ] Music and SFX
- [x] Add restart token to end screen. Needs `RESTART` token + sprite
- [ ] Add leech enemy
- [ ] Add screen-split enemy
- [ ] Add cursed tokens
- [ ] Add enemy that adds spikes to the border (should this be a new one or should an existing one do it?)
- [ ] Create game artwork
  - Thanos guy with gauntlet
- [ ] Create itch io page
- [ ] Animate stats changing