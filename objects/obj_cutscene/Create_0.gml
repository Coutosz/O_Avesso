// Controlador das cutscenes (ver scr_cutscene). Fica na rm_menu, persistente.
depth = 100; // desenha os efeitos de tela por baixo da caixa de diálogo

global.cutscene_active = false;
global.choice = 0;

queue = [];
waiting = "";
wait_timer = 0;

move_target = noone;
move_x = 0;
move_y = 0;
move_spd = 1.5;

// Efeitos de tela
shake = 0;
flash_alpha = 0;
flash_col = c_white;
tint_alpha = 0;
tint_target = 0;
tint_col = c_black;

title_text = "";
title_sub = "";
title_alpha = 0;
title_state = "";
title_hold = 120;
title_timer = 0;
