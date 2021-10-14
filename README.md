# Oracle

Every so often you will receive a vision that may help you solve the case.
Be careful, you will be vulnerable during your visions, however.

## Description

- Member of the Detective Team
- Will periodically receive a vision that will tell them something about the round that may help the innocents
- Visions can give additional information about certain players on other teams, dead bodies, or general information
- Modular and can load custom visions made by others

## Warning

Some of the visions only work on Custom Roles 1.3.1

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

Informs the player what weapon one of the opposing players is holding.

## Distance

How far away a random player on a different team is from the oracle is.

There is one additional Convar for this vistion:

```cpp
ttt_oracle_distance_unit        0                    // The distance reported in ft (0) or m (1)
```

## Body

Reports to the player that there is a dead body that hasn't been investigated, as well as who the dead body is.

## Outline

The player will be able to see the outline of other players while they are blind.

## Role

The player can see the specific role of another player.

There is one additional Convar for this vision:

```cpp
ttt_oracle_role_enemy_only      1                    // Shows only enemy roles to the player
```

## Team

Reports to the player that there is a member of a certain team left alive.

There is one additional Convar for this vision:

```cpp
ttt_oracle_team_enemy_only      1                    // Shows only enemy teams to the player
```

## Alive

How many players are left

# Reveal

One of a certain number of players are on a different team. 

There are two additional Convars for this vision:

```cpp
ttt_oracle_reveal_players       4                    // The max number of players selected that could be bad.
ttt_oracle_reveal_mode          3                    // 1 = One of, 2 = At least one of, 3 = Either
```

## Special Thanks:
- [Noxx](https://steamcommunity.com/id/noxxflame) and [Malivil](https://steamcommunity.com/id/malivil) for all their work on Custom Roles for TTT
- LewisKane on the Yogscast subreddit for the idea
- [Ianthina](https://steamcommunity.com/id/2ahlamfatin) for the idea for Reveal