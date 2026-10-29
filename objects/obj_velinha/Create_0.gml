// Velinha da Vela = ponto de save. Acende sozinha quando a protagonista chega perto e aperta Z.
event_inherited();
event = "velinha";
image_speed = 0;
image_index = scr_flag_get("velinha_" + room_get_name(room)) ? 1 : 0;
