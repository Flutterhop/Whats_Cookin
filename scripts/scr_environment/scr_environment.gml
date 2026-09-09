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

function Environment_Stats(){
	
}

function Projectile_Stats(new_projectile_damage,new_projectile_speed,new_modifiers,new_path_shape,new_collision_targets,new_collision_exceptions) : Environment_Stats() constructor {
	projectile_damage = new_projectile_damage;
	projectile_speed = new_projectile_speed;
	modifiers = new_modifiers;
	path_shape = new_path_shape;
	collision_targets = new_collision_targets;
	collision_exceptions = new_collision_exceptions;
}

