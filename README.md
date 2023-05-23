# Fred Metabolism

 This is my edit of Fred Meatbolism for VORP. 
  In this edit you will be able to create consumables. Each one can affect player cores, increasing stamina or health and even overpowers (gold cores). You have some items created as an example. This script works with fred_hud. This is a script for RedM and VORP framework.

 IMPORTANT: USE THE HUD - or make your own, start with the provided hud as your base.
 
 SUPER IMPORTANT: Do not register items for use in multiple scripts. 
 Examples: 
 Apples in the syn_horse_items script and apples in metabolism. 
 Medicines in any doctors scripts and medicines in the metabolism script. 
 Alcohol in any saloon scripts and alcohol in the metabolism script. 
 Only list items for use in one scripts.

Limited support is available in our discord for this DB version, so long as it has not been modified. 
[DISCORD]  https://discord.gg/pTgJNjVDby  
 **Hope it helps!**

# Content
- Configure your items in the database with easy on off flags.
- Generates items using standard templates, and a multiplier. 
- Add special items that load last, so you can have special effects for specific players or stores.
Previous features.
- Weather effect on metabolism depending if it is cold or hot. 
- Multiple core effects and Gold overpowers.
- Many configs to play with.

# Event
Use 
```
TriggerEvent("fred:consume", hunger, thirst, innercorestamina, innercorestaminagold, outercorestaminagold, innercorehealth, innercorehealthgold, outercorehealthgold)
```
This will work on any other resource, it is useful if you want to make a specific change on any value.

# TODO: 
- [X] Add animation for eat/bread. 
- [X] Add animation for soup/bowl. 
- [X] Add animation for drink (non alcohol). 
- [X] Add animation for drink (alcohol). 
- [X] Config.lua file for easy configuration.
- [X] Add databased items.
- [X] Add flags to items database. 
- [X] Added more animations options. 
- [ ] Add db table for custom objects paired with animations with key in items table.
- [ ] Added more animations options.
- [ ] Add animation for eat/plate. 
- [ ] Add animation for smoking.  
- [ ] Add animation for medicine (elixir).  
- [ ] Add animation for medicine (salve).  
- [ ] Add animation for medicine (pills).  
- [ ] Transfer client/server now supports arrays, update data pass.  

## CHANGELOG:
```
10/01/22 - Add DB features
05/01/23 - Add Special Items feature
```

```
22/01/21 - Added event "fred:consume". You can use this in any other script to change the metabolism values. Read the section Event.
```