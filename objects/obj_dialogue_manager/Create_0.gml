// Estado do sistema de diálogo
dialogue_active = false;
dialogue_pages = [];        // array de { spk, txt } (cada item = uma "página" da fala)
dialogue_page_index = 0;
dialogue_char_index = 0;
dialogue_text_speed = 2;    // quanto menor, mais rápido o texto aparece
dialogue_timer = 0;
dialogue_current_text = "";
dialogue_full_page = false; // true quando a página atual terminou de aparecer
dialogue_just_opened = false;

// Escolhas (aparecem depois da última página)
choice_options = [];
choice_index = 0;
choice_active = false;

// Texto solto no meio da tela, sem caixa
float_mode = false;

// Posição da caixa (a batalha muda isso enquanto está aberta)
box_x = 40;
box_y = 340;
box_w = 560;
box_h = 100;
box_draw_y = box_y;          // onde a caixa foi desenhada de verdade (ela sobe se a protagonista estiver embaixo)
