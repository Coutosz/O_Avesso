// Personagem que anda atrás da protagonista, pisando onde ela pisou.
who = "";
slot = 0;          // posição na fila (0 = logo atrás)
face_dir = "down";
cs_moving = false;
bob = random(100);
spacing = 14;      // quantos passos de distância entre cada um
image_speed = 0.15;

// ---- Só usado pela Faísca (a chama dela é a luz do jogo, ver scr_luz) ----
light_r = 46;        // raio da luz agora
energia = 100;       // quanto ela aguenta brilhar forte
brilhando = false;   // segurando X
cansada = 0;         // frames pequenininha depois de gastar tudo
distante = 0;        // frames andando mais longe (depois de Arder)
medo = 0;            // frames encolhida (um Apagado encostou em você)
pet_t = 0;           // animação do carinho
pet_n = 0;           // quantos carinhos
avisou_arder = false;
