enum Environment_Type{
	ENV_Mess = 31,
	ENV_Prop = 32,
	ENV_Projectile = 33
}

enum Projectile_Modifier{
	Homing,
	Ricochet,
	Target,
	Pierce,
	Boomerang
	
}

enum Path_Shape{
	Line,
	Circle,
	Arc,
	Zigzag
}

enum Impact_Type{
	Default
}

function Environment_Stats(new_name){
	name = new_name;
}

function Projectile_Stats(new_name,new_projectile_sprite,new_projectile_damage,new_projectile_speed,new_knockback_power,new_modifiers = [],new_path_shape,new_impact_type,new_collision_targets,new_collision_exceptions) : Environment_Stats(new_name) constructor {
	projectile_sprite = new_projectile_sprite
	projectile_damage = new_projectile_damage;
	projectile_speed = new_projectile_speed;
	knockback_power = new_knockback_power;
	modifiers = new_modifiers;
	path_shape = new_path_shape;
	impact_type = new_impact_type;
	collision_targets = new_collision_targets;
	collision_exceptions = new_collision_exceptions;
	if(path_shape == Path_Shape.Arc){ max_height = 20;}else{max_height = 0;}
	
	
	
}

