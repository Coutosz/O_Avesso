// Apagado: um Eco que esqueceu quem era. Fica no escuro e vem atrás de quem tem luz.
// Não é colocado na sala à mão: quem cria é scr_apagado_spawn (ver scr_luz), no scr_room_setup.
ap_id = "";        // nome único (flag "ap_<id>")
who = "";          // quem ele vira quando lembra
need = "";         // a coisa dele que faz ele lembrar
silhueta = -1;     // sprite do contorno (o que ele foi)
sil_rows = 0;      // só as linhas de cima do sprite (0 = todas)
home_x = x;
home_y = y;
spd_dark = 1.0;    // no escuro ele é rápido
spd_lit = 0.25;    // na luz, quase parado
lit = false;
burn = 0;          // carga do Arder, 0..1
lembrando = 0;     // animação de quando ele lembra
dying = 0;         // virando poeira dourada
touch_cd = 0;
wob = random(100);
blink = irandom(200);
mask_index = spr_mask_pe;
depth = -y;
scripted = false;  // true = quem mexe nele é a cutscene (não persegue, não encosta)
