var documentation = [
{
"name":"pewpew",
"enums": [
{
"name":"EntityType",
"values": [
"ASTEROID",
"BAF",
"INERTIAC",
"MOTHERSHIP",
"MOTHERSHIP_BULLET",
"ROLLING_CUBE",
"ROLLING_SPHERE",
"UFO",
"WARY",
"CROWDER",
"CUSTOMIZABLE_ENTITY",
"SHIP",
"BOMB",
],
},
{
"name":"MothershipType",
"values": [
"THREE_CORNERS",
"FOUR_CORNERS",
"FIVE_CORNERS",
"SIX_CORNERS",
"SEVEN_CORNERS",
],
},
{
"name":"CannonType",
"values": [
"SINGLE",
"TIC_TOC",
"DOUBLE",
"TRIPLE",
"FOUR_DIRECTIONS",
"DOUBLE_SWIPE",
"HEMISPHERE",
],
},
{
"name":"CannonFrequency",
"values": [
"FREQ_30",
"FREQ_15",
"FREQ_10",
"FREQ_7_5",
"FREQ_6",
"FREQ_5",
"FREQ_3",
"FREQ_2",
"FREQ_1",
],
},
{
"name":"BombType",
"values": [
"FREEZE",
"REPULSIVE",
"ATOMIZE",
"SMALL_ATOMIZE",
],
},
{
"name":"WeaponType",
"values": [
"BULLET",
"FREEZE_EXPLOSION",
"REPULSIVE_EXPLOSION",
"ATOMIZE_EXPLOSION",
],
},
],
"functions": [
{
"return_types": [
],
"func_name":"print",
"comment":"Prints `str` in the console for debugging.",
"parameters": [
{
"name":"str",
"type":"String",
},
],
},
{
"return_types": [
],
"func_name":"print_debug_info",
"comment":"Prints debug info: the number of entities created and the amount of memory used by the script.",
"parameters": [
],
},
{
"return_types": [
],
"func_name":"set_level_size",
"comment":"Sets the level's size. Implicetely adds walls to make sure that entities can not go outside of the level's boundaries. `width` and `height` are clamped to the range ]0fx, 6000fx]. If this function is not called, the level size is (10fx, 10fx), which is uselessly small for most cases.",
"parameters": [
{
"name":"width",
"type":"FixedPoint",
},
{
"name":"height",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"Int32",
},
],
"func_name":"add_wall",
"comment":"Adds a wall to the level from (`start_x`,`start_y`) to (`end_x`,`end_y`), and returns its wall ID. A maximum of 200 walls can be added to a level.",
"parameters": [
{
"name":"start_x",
"type":"FixedPoint",
},
{
"name":"start_y",
"type":"FixedPoint",
},
{
"name":"end_x",
"type":"FixedPoint",
},
{
"name":"end_y",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"remove_wall",
"comment":"Remove the wall with the given `wall_id`.",
"parameters": [
{
"name":"wall_id",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"add_update_callback",
"comment":"Adds a callback that will be updated at each game tick.",
"parameters": [
{
"name":"update_callback",
"type":"Callback",
},
],
},
{
"return_types": [
{
"type":"Int32",
},
],
"func_name":"get_number_of_players",
"comment":"Returns the number of players in the game.",
"parameters": [
],
},
{
"return_types": [
],
"func_name":"increase_score_of_player",
"comment":"Increases the score of the player at the specified `player_index` by an amount of `delta`. `player_index` must in the range [0, get_number_of_players() - 1]. Note that `delta` can be negative.",
"parameters": [
{
"name":"player_index",
"type":"Int32",
},
{
"name":"delta",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"stop_game",
"comment":"Ends the current game.",
"parameters": [
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
{
"type":"FixedPoint",
},
{
"type":"FixedPoint",
},
{
"type":"FixedPoint",
},
],
"func_name":"get_player_inputs",
"comment":"Returns the inputs of the player at the specified `index`. The return values are in order: the movement joystick's angle (between 0 and 2pi), the movement joystick's distance (between 0 and 1), the shoot joystick's angle (between 0 and 2pi), and the shoot joystick's distance (between 0 and 1).",
"parameters": [
{
"name":"player_index",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"Int64",
},
],
"func_name":"get_score_of_player",
"comment":"Returns the score of the player at the specified `player_index`. `player_index` must in the range [0, get_number_of_players() - 1].",
"parameters": [
{
"name":"player_index",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"configure_player",
"comment":"Configures the player at the specified `player_index`. `player_index` must in the range [0, get_number_of_players() - 1]. A `camera_distance` less than 0fx makes the camera move away from the ship. `camera_rotation_x_axis` is in radian and rotates along the X axis.",
"parameters": [
{
"name":"player_index",
"type":"Int32",
},
{
"name":"configuration",
"type":"Map",
"map_entries": [
{
"name":"has_lost",
"type":"Boolean",
},
{
"name":"shield",
"type":"Int32",
},
{
"name":"camera_distance",
"type":"FixedPoint",
},
{
"name":"camera_rotation_x_axis",
"type":"FixedPoint",
},
{
"name":"move_joystick_color",
"type":"Int32",
},
{
"name":"shoot_joystick_color",
"type":"Int32",
},
],
},
],
},
{
"return_types": [
{
"type":"Map",
"map_entries": [
{
"name":"shield",
"type":"Int32",
},
{
"name":"has_lost",
"type":"Boolean",
},
],
},
],
"func_name":"get_player_configuration",
"comment":"Returns a map containing the configuration of the player at the specified `player_index`.",
"parameters": [
{
"name":"player_index",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"configure_player_ship_weapon",
"comment":"Configures the weapon of the ship identified with `ship_id` using `configuration`. `frequency` determines the frequency of the shots. `cannon` determines the type of cannon. `duration` determines the number of game ticks during which the weapon will be available. Once the duration expires, the weapon reverts to its permanent configuration. If `duration` is omitted, the weapon will be permanently set to this configuration. If `frequency` or `cannon` is omitted, the ship is configured to not have any weapon.",
"parameters": [
{
"name":"ship_id",
"type":"EntityId",
},
{
"name":"configuration",
"type":"Map",
"map_entries": [
{
"name":"frequency",
"type":"Int32",
"enum": "CannonFrequency",
},
{
"name":"cannon",
"type":"Int32",
"enum": "CannonType",
},
{
"name":"duration",
"type":"Int32",
},
],
},
],
},
{
"return_types": [
],
"func_name":"add_damage_to_player_ship",
"comment":"Reduces the amount of shield of the player that owns the ship by `damage` points. If the player receives damage while having 0 shields left, the player loses.",
"parameters": [
{
"name":"ship_id",
"type":"EntityId",
},
{
"name":"damage",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"Int32",
},
],
"func_name":"add_arrow_to_player_ship",
"comment":"Adds an arrow to the ship identified with `ship_id` pointing towards the entity identified with `entity_id`, and returns the identifier of the arrow. `color` specifies the arrow's color. The arrow is automatically removed when the target entity is destroyed.",
"parameters": [
{
"name":"ship_id",
"type":"EntityId",
},
{
"name":"target_id",
"type":"EntityId",
},
{
"name":"color",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"remove_arrow_from_player_ship",
"comment":"Removes the arrow identified by `arrow_id` from the ship identified by `ship_id`.",
"parameters": [
{
"name":"ship_id",
"type":"EntityId",
},
{
"name":"arrow_id",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"make_player_ship_transparent",
"comment":"Makes the player ship transparent for `transparency_duration` game ticks.",
"parameters": [
{
"name":"ship_id",
"type":"EntityId",
},
{
"name":"transparency_duration",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"set_player_ship_speed",
"comment":"Sets and returns the **effective speed** of the specified player ship as a function of the **base speed** of the ship. By default, a player ship moves according to its base speed, which is 10 distance units per tick (in the future, different ships may have different base speeds). Assuming the base speed of the ship is S, the new effective speed will be `(factor*S)+offset`. `duration` is the number of ticks during which the effective speed will be applied. Afterwards, the ship's speed reverts to its base speed. If `duration` is negative, the effective speed never reverts to the base speed.",
"parameters": [
{
"name":"ship_id",
"type":"EntityId",
},
{
"name":"factor",
"type":"FixedPoint",
},
{
"name":"offset",
"type":"FixedPoint",
},
{
"name":"duration",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"List",
},
],
"func_name":"get_entities_colliding_with_disk",
"comment":"Returns the list of collidable entities (which includes all enemies) that overlap with the given disk.",
"parameters": [
{
"name":"center_x",
"type":"FixedPoint",
},
{
"name":"center_y",
"type":"FixedPoint",
},
{
"name":"radius",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"Int32",
},
],
"func_name":"get_entity_count",
"comment":"Returns the number of entities of type `type` that are alive.",
"parameters": [
{
"name":"type",
"type":"Int32",
"enum": "EntityType",
},
],
},
{
"return_types": [
{
"type":"Int32",
},
],
"func_name":"get_entity_type",
"comment":"Returns the type of the given entity.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
],
},
{
"return_types": [
],
"func_name":"play_ambient_sound",
"comment":"Plays the sound described at `sound_path` at the index `index`.",
"parameters": [
{
"name":"sound_path",
"type":"String",
},
{
"name":"index",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"play_sound",
"comment":"Plays the sound described at `sound_path` at the in-game location of `x`,`y`.",
"parameters": [
{
"name":"sound_path",
"type":"String",
},
{
"name":"index",
"type":"Int32",
},
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"create_explosion",
"comment":"Creates an explosion of particles at the location `x`,`y`. `color` specifies the color of the explosion. `scale` describes how large the explosion will be. It should be in the range ]0, 10], with 1 being an average explosion. `particle_count` specifies the number of particles that make up the explosion. It must be in the range [1, 100].",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"color",
"type":"Int32",
},
{
"name":"scale",
"type":"FixedPoint",
},
{
"name":"particle_count",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_asteroid",
"comment":"Creates a new Asteroid at the location `x`,`y` and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_baf",
"comment":"Creates a new BAF at the location `x`,`y`, and returns its entityId. `angle` specifies the angle at which the BAF will move. `speed` specifies the maximum speed it will reach. `lifetime` indicates the number of game ticks after which the BAF is destroyed the next time it hits a wall. Specify a negative `lifetime` to create a BAF that lives forever.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"angle",
"type":"FixedPoint",
},
{
"name":"speed",
"type":"FixedPoint",
},
{
"name":"lifetime",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_bomb",
"comment":"Creates a new Bomb at the location `x`,`y`, and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"type",
"type":"Int32",
"enum": "BombType",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_customizable_entity",
"comment":"Creates a new customizable entity at the location `x`,`y`, and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_inertiac",
"comment":"Creates a new Inertiac at the location `x`,`y`, and returns its entityId. The inertiac will accelerate according to `acceleration`. It spawns with a random velocity in a direction specified by `angle`.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"acceleration",
"type":"FixedPoint",
},
{
"name":"angle",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_mothership",
"comment":"Creates a new Mothership at the location `x`,`y`, and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"type",
"type":"Int32",
"enum": "MothershipType",
},
{
"name":"angle",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_player_ship",
"comment":"Creates a new Player Ship at the location `x`,`y` for the player identified by `player_index`, and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"player_index",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_player_bullet",
"comment":"Creates a new bullet at the location `x`,`y` with the angle `angle` belonging to the player at the index `player_index`. Returns the entityId of the bullet.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"angle",
"type":"FixedPoint",
},
{
"name":"player_index",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_rolling_cube",
"comment":"Creates a new Rolling Cube at the location `x`,`y`, and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_rolling_sphere",
"comment":"Creates a new Rolling Sphere at the location `x`,`y`, and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"angle",
"type":"FixedPoint",
},
{
"name":"speed",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_wary",
"comment":"Creates a new Wary at the location `x`,`y`.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"EntityId",
},
],
"func_name":"new_ufo",
"comment":"Creates a new UFO at the location `x`,`y` moving horizontally at the speed of `dx`, and returns its entityId.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"dx",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"rolling_cube_set_enable_collisions_with_walls",
"comment":"Sets whether the rolling cube identified with `id` collides with walls. By default it does not.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"collide_with_walls",
"type":"Boolean",
},
],
},
{
"return_types": [
],
"func_name":"ufo_set_enable_collisions_with_walls",
"comment":"Sets whether the ufo identified with `id` collides with walls. By default it does not.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"collide_with_walls",
"type":"Boolean",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
{
"type":"FixedPoint",
},
],
"func_name":"entity_get_position",
"comment":"Returns the position of the entity identified by `id`.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
],
},
{
"return_types": [
{
"type":"Boolean",
},
],
"func_name":"entity_get_is_alive",
"comment":"Returns whether the entity identified by `id` is alive or not.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
],
},
{
"return_types": [
{
"type":"Boolean",
},
],
"func_name":"entity_get_is_started_to_be_destroyed",
"comment":"Returns whether the entity identified by `id` is in the process of being destroyed. Returns false if the entity does not exist.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
],
},
{
"return_types": [
],
"func_name":"entity_set_position",
"comment":"Sets the position of the entity identified by `id` to `x`,`y`",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"entity_set_radius",
"comment":"Sets the radius of the entity identified by `id`. To give you a sense of scale, motherships have a radius of 28fx.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"radius",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"entity_set_update_callback",
"comment":"Sets a callback that will be called at every tick as long as the entity identified by `id` is alive. Remove the callback by passing a nil `callback`. The callbacks gets called with the entity ID.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"callback",
"type":"Callback",
},
],
},
{
"return_types": [
],
"func_name":"entity_destroy",
"comment":"Makes the entity identified by `id` immediately disappear forever.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
],
},
{
"return_types": [
{
"type":"Boolean",
},
],
"func_name":"entity_react_to_weapon",
"comment":"Makes the entity identified by `id` react to the weapon described in `weapon_description`. Returns whether the entity reacted to the weapon. The returned value is typically used to decide whether the weapon should continue to exist or not. In the case of an explosion, `x` and `y` should store the origin of the explosion. In the case of a bullet, `x` and `y` should store the vector of the bullet.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"weapon",
"type":"Map",
"map_entries": [
{
"name":"type",
"type":"Int32",
"enum": "WeaponType",
},
{
"name":"x",
"type":"FixedPoint",
},
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"player_index",
"type":"Int32",
},
],
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_position_interpolation",
"comment":"Sets whether the position of the mesh wil be interpolated when rendering. In general, this should be set to true if the entity will be moving smoothly.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"enable",
"type":"Boolean",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_mesh",
"comment":"Sets the mesh of the customizable entity identified by `id` to the mesh described in the file `file_path` at the index `index`. `index` starts at 0. If `file_path` is an empty string, the mesh is removed.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"file_path",
"type":"String",
},
{
"name":"index",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_flipping_meshes",
"comment":"Similar to `customizable_entity_set_mesh`, but sets two meshes that will be used in alternation. By specifying 2 separate meshes, 60 fps animations can be achieved.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"file_path",
"type":"String",
},
{
"name":"index_0",
"type":"Int32",
},
{
"name":"index_1",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_mesh_color",
"comment":"Sets the color multiplier for the mesh of the customizable entity identified by `id`.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"color",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_string",
"comment":"Sets the string to be displayed as part of the mesh of the customizable entity identified by `id`.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"text",
"type":"String",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_mesh_z",
"comment":"Sets the height of the mesh of the customizable entity identified by `id`. A `z` greater to 0 makes the mesh be closer, while a `z` less than 0 makes the mesh be further away.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"z",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_mesh_scale",
"comment":"Sets the scale of the mesh of the customizable entity identified by `id`. A `scale` less than 1 makes the mesh appear smaller, while a `scale` greater than 1 makes the mesh appear larger.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"scale",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_mesh_xyz_scale",
"comment":"Sets the scale of the mesh of the customizable entity identified by `id` along the x,y,z axis. A `scale` less than 1 makes the mesh appear smaller, while a `scale` greater than 1 makes the mesh appear larger.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"x_scale",
"type":"FixedPoint",
},
{
"name":"y_scale",
"type":"FixedPoint",
},
{
"name":"z_scale",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_mesh_angle",
"comment":"Sets the rotation angle of the mesh of the customizable entity identified by `id`. The rotation is applied along the axis defined by `x_axis`,`y_axis`,`z_axis`.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"angle",
"type":"FixedPoint",
},
{
"name":"x_axis",
"type":"FixedPoint",
},
{
"name":"y_axis",
"type":"FixedPoint",
},
{
"name":"z_axis",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_configure_music_response",
"comment":"Configures the way the entity is going to respond to the music.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"config",
"type":"Map",
"map_entries": [
{
"name":"color_start",
"type":"Int32",
},
{
"name":"color_end",
"type":"Int32",
},
{
"name":"scale_x_start",
"type":"FixedPoint",
},
{
"name":"scale_x_end",
"type":"FixedPoint",
},
{
"name":"scale_y_start",
"type":"FixedPoint",
},
{
"name":"scale_y_end",
"type":"FixedPoint",
},
{
"name":"scale_z_start",
"type":"FixedPoint",
},
{
"name":"scale_z_end",
"type":"FixedPoint",
},
],
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_add_rotation_to_mesh",
"comment":"Adds a rotation to the mesh of the customizable entity identified by `id`. The rotation is applied along the axis defined by `x_axis`,`y_axis`,`z_axis`.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"angle",
"type":"FixedPoint",
},
{
"name":"x_axis",
"type":"FixedPoint",
},
{
"name":"y_axis",
"type":"FixedPoint",
},
{
"name":"z_axis",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_visibility_radius",
"comment":"Sets the radius defining the visibility of the entity. This allows the game to know when an entity is actually visible, which in turns allows to massively optimize the rendering. Use the smallest value possible. If not set, the rendering radius is an unspecified large number that effectively makes the entity always be rendered, even if not visible.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"radius",
"type":"FixedPoint",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_configure_wall_collision",
"comment":"`collide_with_walls` configures whether the entity should stop when colliding with walls. If `collision_callback` is not nil, it is called anytime a collision is detected. The callback gets called with the entity id of the entity withthe callback, and with the normal to the wall.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"collide_with_walls",
"type":"Boolean",
},
{
"name":"collision_callback",
"type":"Callback",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_player_collision_callback",
"comment":"Sets the callback for when the customizable entity identified by `id` collides with a player's ship. The callback gets called with the entity id of the entity with the callback, and the player_index and ship_id that were involved in the collision. Don't forget to set a radius on the customizable entity, otherwise no collisions will be detected.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"collision_callback",
"type":"Callback",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_set_weapon_collision_callback",
"comment":"Sets the callback for when the customizable entity identified by `id` collides with a player's weapon. The callback gets called with the entity_id of the entity on which the callback is set, the player_index of the player that triggered the weapon, and the type of the weapon. The callback *must* return a boolean saying whether the entity reacts to the weapon. In the case of a bullet, this boolean determines whether the bullet should be destroyed.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"weapon_collision_callback",
"type":"Callback",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_start_spawning",
"comment":"Makes the customizable entity identified by `id` spawn for a duration of `spawning_duration` game ticks.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"spawning_duration",
"type":"Int32",
},
],
},
{
"return_types": [
],
"func_name":"customizable_entity_start_exploding",
"comment":"Makes the customizable entity identified by `id` explode for a duration of `explosion_duration` game ticks. After the explosion, the entity is destroyed.",
"parameters": [
{
"name":"entity_id",
"type":"EntityId",
},
{
"name":"explosion_duration",
"type":"Int32",
},
],
},
],
},
{
"name":"fmath",
"enums": [
],
"functions": [
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"max_fixedpoint",
"comment":"Returns the maximum value a fixedpoint integer can take.",
"parameters": [
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"random_fixedpoint",
"comment":"Returns a random fixedpoint value in the range [`min`, `max`]. `max` must be greater or equal to `min`.",
"parameters": [
{
"name":"min",
"type":"FixedPoint",
},
{
"name":"max",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"Int64",
},
],
"func_name":"random_int",
"comment":"Returns an integer in the range [`min`, `max`]. `max` must be greater or equal to `min`.",
"parameters": [
{
"name":"min",
"type":"Int64",
},
{
"name":"max",
"type":"Int64",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"sqrt",
"comment":"Returns the square root of `x`. `x` must be greater or equal to 0.",
"parameters": [
{
"name":"x",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"from_fraction",
"comment":"Returns the fixedpoint value representing the fraction `numerator`/`denominator`. `denominator` must not be equal to zero.",
"parameters": [
{
"name":"numerator",
"type":"Int32",
},
{
"name":"denominator",
"type":"Int32",
},
],
},
{
"return_types": [
{
"type":"Int64",
},
],
"func_name":"to_int",
"comment":"Returns the integral part of the `value`.",
"parameters": [
{
"name":"value",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"abs_fixedpoint",
"comment":"Returns the absolute value.",
"parameters": [
{
"name":"value",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"to_fixedpoint",
"comment":"Returns a fixedpoint value with the integral part of `value`, and no fractional part.",
"parameters": [
{
"name":"value",
"type":"Int64",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
{
"type":"FixedPoint",
},
],
"func_name":"sincos",
"comment":"Returns the sinus and cosinus of `angle`. `angle` is in radian.",
"parameters": [
{
"name":"angle",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"atan2",
"comment":"Returns the principal value of the arc tangent of y/x. Returns a value in the range [0, 2π[.",
"parameters": [
{
"name":"y",
"type":"FixedPoint",
},
{
"name":"x",
"type":"FixedPoint",
},
],
},
{
"return_types": [
{
"type":"FixedPoint",
},
],
"func_name":"tau",
"comment":"Returns τ (aka 2π).",
"parameters": [
],
},
],
},
]
