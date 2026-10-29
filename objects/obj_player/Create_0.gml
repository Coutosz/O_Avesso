
move_spd = 2;

h_spd = 0;
v_spd = 0;

face_dir = "down";

sprite_index = spr_player_down;
image_speed = 0;
mask_index = spr_mask_pe;   // colisão só nos pés (dá pra passar na frente das coisas)

interact_cooldown = 0;

invuln = 0;        // frames piscando depois de levar dano
cs_moving = false; // true enquanto uma cutscene está andando com ela
trail = [];        // rastro de posições, pros seguidores pisarem atrás
last_x = x;
last_y = y;

// Caminhada: o pé troca pela distância andada (scr_player_anim)
anim_x = x;
anim_y = y;
anim_dist = 0;
// Pose de cutscene (ex.: spr_player_levanta). -1 = anda normal.
pose_spr = -1;
pose_img = 0;
