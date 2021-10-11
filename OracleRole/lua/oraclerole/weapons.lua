function ConvertOracleWeapons()
    local weps = "[{\"class_name\":\"weapon_zm_revolver\",\"sanitized_name\":\"a Deagle\"},{\"class_name\":\"weapon_zm_rifle\",\"sanitized_name\":\"a Scout\"},{\"class_name\":\"weapon_zm_shutgun\",\"sanitized_name\":\"a shotgun\"},{\"class_name\":\"weapon_ttt_g3sg1\",\"sanitized_name\":\"a G3SG1\"},{\"class_name\":\"weapon_t38\",\"sanitized_name\":\"an Arisaka\"},{\"class_name\":\"weapon_zm_sledge\",\"sanitized_name\":\"a Huge\"},{\"class_name\":\"weapon_ttt_sg552\",\"sanitized_name\":\"a SG 552\"},{\"class_name\":\"weapon_ttt_m16\",\"sanitized_name\":\"a M16\"},{\"class_name\":\"weapon_welrod\",\"sanitized_name\":\"a Welrod\"},{\"class_name\":\"weapon_zm_pilstol\",\"sanitized_name\":\"a Pistol\"},{\"class_name\":\"weapon_ttt_foolsgoldengun\",\"sanitized_name\":\"a Fools Golden Gun\"},{\"class_name\":\"weapon_ttt_unarmed\",\"sanitized_name\":\"Nothing\"},{\"class_name\":\"weapon_ttt_chickennade\",\"sanitized_name\":\"a Chicken Grenade\"},{\"class_name\":\"weapon_ttt_printer\",\"sanitized_name\":\"a Credit Printer\"},{\"class_name\":\"weapon_pha_exorcism\",\"sanitized_name\":\"a Phantom Exorcism\"},{\"class_name\":\"weapon_ttt_boomerang\",\"sanitized_name\":\"a Boomerang\"},{\"class_name\":\"weapon_ttt_rsb\",\"sanitized_name\":\"a Remote Sticky Bomb\"},{\"class_name\":\"weapon_t14nambu\",\"sanitized_name\":\"a Nambu\"},{\"class_name\":\"weapon_ttt_galil\",\"sanitized_name\":\"a Galil\"},{\"class_name\":\"weapon_ppsh41\",\"sanitized_name\":\"a PPSH41\"},{\"class_name\":\"weapon_ttt_dead_ringer\",\"sanitized_name\":\"a Dead Ringer\"},{\"class_name\":\"weapon_ttt_teleport\",\"sanitized_name\":\"a Teleporter\"},{\"class_name\":\"weapon_stenmk3\",\"sanitized_name\":\"a Sten MK III\"},{\"class_name\":\"weapon_ttt_binoculars\",\"sanitized_name\":\"Binoculars\"},{\"class_name\":\"manipulation_knife\",\"sanitized_name\":\"a Manipulation Knife\"},{\"class_name\":\"weapon_ttt_push\",\"sanitized_name\":\"a Newton Launcher\"},{\"class_name\":\"weapon_ttt_stungun\",\"sanitized_name\":\"a Stungun\"},{\"class_name\":\"weapon_hp_ares_shrike\",\"sanitized_name\":\"an Ares Strike\"},{\"class_name\":\"weapon_ttt_m4a1_s\",\"sanitized_name\":\"a Silenced M4A1\"},{\"class_name\":\"weapon_ap_hbadger\",\"sanitized_name\":\"a Honey Badger\"},{\"class_name\":\"weapon_hyp_brainwash\",\"sanitized_name\":\"a Brainwashing Device\"},{\"class_name\":\"weapon_ttt_powerdeagle\",\"sanitized_name\":\"a Golden Deagle\"},{\"class_name\":\"weapon_lee\",\"sanitized_name\":\"a Lee Enfield No.2\"},{\"class_name\":\"doom_shotgun_2016\",\"sanitized_name\":\"a Super Shotgun\"},{\"class_name\":\"weapon_zm_mac10\",\"sanitized_name\":\"a Mac10\"},{\"class_name\":\"weapon_med_defib\",\"sanitized_name\":\"a Defib\"},{\"class_name\":\"weapon_luger\",\"sanitized_name\":\"a Luger\"},{\"class_name\":\"weapon_ttt_adv_disguiser\",\"sanitized_name\":\"an Advanced Disguiser\"},{\"class_name\":\"stungun\",\"sanitized_name\":\"a Stungun\"},{\"class_name\":\"none\",\"sanitized_name\":\"Nothing\"},{\"class_name\":\"weapon_analgesic\",\"sanitized_name\":\"an Analgesic Bullet\"},{\"class_name\":\"weapon_ttt_homebat\",\"sanitized_name\":\"a Homerun Bat\"},{\"class_name\":\"weapon_ttt_prophide\",\"sanitized_name\":\"a Prop Disquiser\"},{\"class_name\":\"weapon_par_cure\",\"sanitized_name\":\"a Paracite cure\"},{\"class_name\":\"ttt_weeping_angel\",\"sanitized_name\":\"a Weaping Angel\"},{\"class_name\":\"weapon_tttbasegrenade\",\"sanitized_name\":\"a Grenade\"},{\"class_name\":\"weapon_ttt_famas\",\"sanitized_name\":\"a Famas\"},{\"class_name\":\"weapon_ttt_aug\",\"sanitized_name\":\"an Aug\"},{\"class_name\":\"weapon_ttt_ak47\",\"sanitized_name\":\"an AK47\"},{\"class_name\":\"weapon_shark_trap\",\"sanitized_name\":\"a Shark Trap\"},{\"class_name\":\"weapon_qua_bomb_station\",\"sanitized_name\":\"a Bomb Station\"},{\"class_name\":\"weapon_ap_tec9\",\"sanitized_name\":\"a Tec9\"},{\"class_name\":\"weapon_ttt_smg\",\"sanitized_name\":\"a MP7\"},{\"class_name\":\"weapon_doncombinesummoner\",\"sanitized_name\":\"a Doncombine Summoner\"},{\"class_name\":\"weapon_ttt_demonsign\",\"sanitized_name\":\"a Demonic Possession\"},{\"class_name\":\"weapon_vam_fangs\",\"sanitized_name\":\"Vampire Fangs\"},{\"class_name\":\"weapon_gewehr43\",\"sanitized_name\":\"a Gewehr\"},{\"class_name\":\"doom_shotgun_2016_triple\",\"sanitized_name\":\"a Super Shotgun\"},{\"class_name\":\"weapon_ttt_randomatdet\",\"sanitized_name\":\"a Randomat\"},{\"class_name\":\"weapon_ttt_flaregun\",\"sanitized_name\":\"a Flaregun\"},{\"class_name\":\"weapon_m3\",\"sanitized_name\":\"a Pump Shotgun\"},{\"class_name\":\"weapon_dp\",\"sanitized_name\":\"a DP-28\"},{\"class_name\":\"weapon_kil_crowbar\",\"sanitized_name\":\"a Crowbar\"},{\"class_name\":\"weapon_zom_claws\",\"sanitized_name\":\"Zombie Claws\"},{\"class_name\":\"weapon_ttt_sipistol\",\"sanitized_name\":\"a Silenced Pistol\"},{\"class_name\":\"ttt_m9k_harpoon\",\"sanitized_name\":\"a Harpoon\"},{\"class_name\":\"doom_shotgun_2016_grenade\",\"sanitized_name\":\"a Super Shotgun\"},{\"class_name\":\"weapon_zm_molotov\",\"sanitized_name\":\"an Incendiary Granade\"},{\"class_name\":\"weapon_ttt_headlauncher\",\"sanitized_name\":\"a Headcrab Launcher\"},{\"class_name\":\"weapon_ttt_suicide\",\"sanitized_name\":\"a Suicide Bomb\"},{\"class_name\":\"weapon_zm_carry\",\"sanitized_name\":\"a Magnito Stick\"},{\"class_name\":\"weapon_ttt_beenade\",\"sanitized_name\":\"a Beenade\"},{\"class_name\":\"weapon_controllable_manhack\",\"sanitized_name\":\"a Controllable Manhack\"},{\"class_name\":\"weapon_sp_winchester\",\"sanitized_name\":\"a Winchester\"},{\"class_name\":\"weapon_kil_knife\",\"sanitized_name\":\"a Knife\"},{\"class_name\":\"weapon_ttt_beacon\",\"sanitized_name\":\"a Beacon\"},{\"class_name\":\"weapon_ttt_xm8\",\"sanitized_name\":\"a Heckler & Koch\"},{\"class_name\":\"weapon_rp_railgun\",\"sanitized_name\":\"a Railgun\"},{\"class_name\":\"weapon_ttt_don_freezegun\",\"sanitized_name\":\"a Freeze Gun\"},{\"class_name\":\"weapon_tt\",\"sanitized_name\":\"a Tokarev\"},{\"class_name\":\"weapon_unoreverse\",\"sanitized_name\":\"a Uno Reverse\"},{\"class_name\":\"weapon_ttt_decoy\",\"sanitized_name\":\"a Decoy\"},{\"class_name\":\"weapon_ttt_wtester\",\"sanitized_name\":\"a DNA Scanner\"},{\"class_name\":\"weapon_ttt_death_link\",\"sanitized_name\":\"a Death Link\"},{\"class_name\":\"weapon_ttt_traitor_case\",\"sanitized_name\":\"a T Suitcase\"},{\"class_name\":\"weapon_rp_pocket\",\"sanitized_name\":\"a Pocket Rifle\"},{\"class_name\":\"weapon_ap_vector\",\"sanitized_name\":\"a Vector\"},{\"class_name\":\"weapon_ttt_traitor_lightsaber\",\"sanitized_name\":\"a Lightsaber\"},{\"class_name\":\"weapon_ttt_awp\",\"sanitized_name\":\"an AWP\"},{\"class_name\":\"weapon_zm_improvised\",\"sanitized_name\":\"a Crowbar\"},{\"class_name\":\"weapon_hcannon\",\"sanitized_name\":\"a Hand Cannon\"},{\"class_name\":\"surprisecombine\",\"sanitized_name\":\"a Surprise Combine\"},{\"class_name\":\"weapon_old_dbshotgun\",\"sanitized_name\":\"a Double Barrel\"},{\"class_name\":\"weapon_flechettegun\",\"sanitized_name\":\"a Flechett Gun\"},{\"class_name\":\"weapon_ttt_rsb_defuser\",\"sanitized_name\":\"a Defuser\"},{\"class_name\":\"weapon_ttt_defuser\",\"sanitized_name\":\"a Defuser\"},{\"class_name\":\"weapon_enfield_4\",\"sanitized_name\":\"a Lee Enfield No.4\"},{\"class_name\":\"weapon_holyhand_grenade\",\"sanitized_name\":\"a Holy Hand Grenade\"},{\"class_name\":\"weapon_ttt_pistol\",\"sanitized_name\":\"a USP\"},{\"class_name\":\"weapon_medkit\",\"sanitized_name\":\"a Medkit\"},{\"class_name\":\"weapon_ttt_phammer\",\"sanitized_name\":\"a Poltergeist\"},{\"class_name\":\"weapon_qua_fake_cure\",\"sanitized_name\":\"a Paracite cure\"},{\"class_name\":\"weapon_ttt_slam\",\"sanitized_name\":\"a Slam\"},{\"class_name\":\"weapon_antlionsummoner\",\"sanitized_name\":\"an Antlion Summoner\"},{\"class_name\":\"weapon_ttt_mp5\",\"sanitized_name\":\"a MP5\"},{\"class_name\":\"weapon_fists\",\"sanitized_name\":\"Fists\"},{\"class_name\":\"weapon_ttt_knife\",\"sanitized_name\":\"a Knife\"},{\"class_name\":\"weapon_ttt_cse\",\"sanitized_name\":\"a Visualizer\"},{\"class_name\":\"weapon_cigarrobase\",\"sanitized_name\":\"a Cigarette\"},{\"class_name\":\"weapon_bod_bodysnatch\",\"sanitized_name\":\"a Defib\"},{\"class_name\":\"weapon_ap_pp19\",\"sanitized_name\":\"a PP19\"},{\"class_name\":\"weapon_ttt_radio\",\"sanitized_name\":\"a Radio\"},{\"class_name\":\"doom_sshotgun_2016\",\"sanitized_name\":\"a Super Shotgun\"},{\"class_name\":\"weapon_fg42\",\"sanitized_name\":\"a FG42\"},{\"class_name\":\"weapon_gnome_grenade\",\"sanitized_name\":\"a Gnome Grenade\"},{\"class_name\":\"weapon_ttt_paper_plane\",\"sanitized_name\":\"a Paper Plane\"},{\"class_name\":\"weapon_ttt_randomat\",\"sanitized_name\":\"a Randomat\"},{\"class_name\":\"weapon_ttt_smokegrenade\",\"sanitized_name\":\"a Smoke Grenade\"},{\"class_name\":\"weapon_ttt_health_station\",\"sanitized_name\":\"a Health Station\"},{\"class_name\":\"weapon_cigarro\",\"sanitized_name\":\"a Cigarette\"},{\"class_name\":\"weapon_ttt_pump\",\"sanitized_name\":\"a Pump Shotgun\"},{\"class_name\":\"weapon_powerdeagle\",\"sanitized_name\":\"a Golden Deagle\"},{\"class_name\":\"weapon_m9\",\"sanitized_name\":\"a M9\"},{\"class_name\":\"donc_swep\",\"sanitized_name\":\"a Dunconnon\"},{\"class_name\":\"weapon_ttt_tmp_s\",\"sanitized_name\":\"a Silent Fox\"},{\"class_name\":\"weapon_ttt_barnacle_improved\",\"sanitized_name\":\"a Barnacle\"},{\"class_name\":\"weapon_ttt_confgrenade\",\"sanitized_name\":\"a Discombob\"},{\"class_name\":\"weapon_ttt_defib\",\"sanitized_name\":\"a Defib\"},{\"class_name\":\"magnumspawn\",\"sanitized_name\":\"a Magnum\"},{\"class_name\":\"weapon_ttt_detective_lightsaber\",\"sanitized_name\":\"a Lightsaber\"},{\"class_name\":\"weapon_blue_firework\",\"sanitized_name\":\"a Blue Firework\"},{\"class_name\":\"weapon_ttt_glock\",\"sanitized_name\":\"a Glock\"},{\"class_name\":\"weapon_ttt_handcuffs\",\"sanitized_name\":\"Handcuffs\"},{\"class_name\":\"weapon_sp_striker\",\"sanitized_name\":\"a Striker-12\"},{\"class_name\":\"weapon_ttt_c4\",\"sanitized_name\":\"a C4\"},{\"class_name\":\"weapon_ap_golddragon\",\"sanitized_name\":\"a Golden Dragon\"},{\"class_name\":\"weapon_mad_zombificator\",\"sanitized_name\":\"a Defib\"},{\"class_name\":\"weapon_gam_goldengun\",\"sanitized_name\":\"a Golden Gun\"},{\"class_name\":\"weapon_huntingbow\",\"sanitized_name\":\"a Hunting Bow\"},{\"class_name\":\"weapon_clt_shrine\",\"sanitized_name\":\"a Shrine\"},{\"class_name\":\"weapon_ttt_foolsgoldengun\",\"sanitized_name\":\"a Fools Golden Gun\"},{\"class_name\":\"weapon_ap_mrca1\",\"sanitized_name\":\"a MR-CA1\"}]"

    return util.JSONToTable(weps)
end