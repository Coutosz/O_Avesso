// Personagem parado na sala (dá pra conversar e a cutscene pode mexer nele).
// Creation Code da instância: who = "nana"; (o sprite e o evento "talk_nana" vêm sozinhos)
event_inherited();
who = "";
face_dir = "down";
cs_moving = false;
bob = random(100);
setup_done = false;
image_speed = 0.15;
// Andando na cutscene: troca o pé pela distância (sprites com 5 frames: 0 parado, 1-4 passos)
anim_x = x;
anim_y = y;
anim_dist = 0;
anim_idle = 0;
