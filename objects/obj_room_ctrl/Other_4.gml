// As paredes ficam invisíveis: quem desenha elas é o Draw Begin daqui, com a cor da sala
with (obj_wall) if (object_index == obj_wall) visible = false;
with (obj_room_trigger) visible = false;

scr_room_setup(room_name);

scr_visual_decor(room_name);
