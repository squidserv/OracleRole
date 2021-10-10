# Oracle

Every so often you will receive a vision that may help you solve the case.
Be careful, you will be vulnerable during your visions, however.

## Description

- Member of the Detective Team
- Will periodically receive a vision that will tell them something about the round that may help the innocents
- Visions can give additional information about certain players on other teams, dead bodies, or general information
- Modular and can load custom visions made by others

## Warning

This role only works on Custom Roles version 1.3.1 or newer

## Convars

Add the following to your server.cfg (for dedicated servers) or listenserver.cfg (for peer-to-peer servers):

```cpp
ttt_oracle_enabled              0                   // Used to enable or disable the role
ttt_oracle_spawn_weight         1                   // The weight assigned for spawning the role
ttt_oracle_min_players          0                   // The minimum number of player required to spawn the role
ttt_oracle_starting_health      100                 // The amount of health the role starts each round with
ttt_oracle_max_health           100                 // The maximum health of the role
ttt_oracle_starting_credits     1                   // The player's starting credits
ttt_oracle_blind                1                   // If the oracle is blinded during the vision
ttt_oracle_vision_time          10                  // How long the vision will be on the screen
ttt_oracle_vision_gap           30                  // How long between visions
ttt_oracle_chatbox              1                   // If the information from the vision should be sent to the player in chat too
ttt_oracle_vision               1                   // Whether a vision is enabled or not. Replace "vision" with the name (all lowercase) of each vision you want to enable
```

# Visions

TODO: All of them

## Weapon

The weapon a bad player is holding

## Distance

How far away a random enemy is

## Body

A dead body that has not been investigated

## Outline

Wallhacks while blind

## Role

The specific role of one of players

## Team

If there is a member of a team alive

## Alive

How many players are left

# Reveal

One of 4 players is bad

## Special Thanks:
- [Noxx](https://steamcommunity.com/id/noxxflame) and [Malivil](https://steamcommunity.com/id/malivil) for all their work on Custom Roles for TTT
- LewisKane on the Yogscast subreddit for the idea
- [Ianthina](https://steamcommunity.com/id/2ahlamfatin) for the idea for Reveal