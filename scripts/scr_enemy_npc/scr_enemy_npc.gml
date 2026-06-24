enum enemy_type{
	generic
}
enum enemy_trait{
	Standard,
	Flying,
	Healing,
	Armored,
	Quick,
	Heavy,
	Explosive,
	Shaman,
	Hunter
}
function Enemy_Entity(new_enemy_type,
						new_enemy_traits = [enemy_trait.Standard],
						new_size = npc_size.medium,new_grid = "",
						new_move_speed,
						new_name,
						new_type,
						new_health = 1,
						new_invincible = false,
						new_object_reference
						) : NPC_Entity(new_size = npc_size.medium,new_grid = "",new_move_speed, new_name,new_type,new_health = 1,new_invincible = false,new_object_reference) constructor{
	en_type = new_enemy_type
	enemy_traits = new_enemy_traits
}