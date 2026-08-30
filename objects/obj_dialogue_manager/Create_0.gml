// Estado do sistema de diálogo
dialogue_active = false;
dialogue_pages = [];        // array de textos (cada item = uma "página" da fala)
dialogue_page_index = 0;
dialogue_char_index = 0;
dialogue_text_speed = 2;    // quanto menor, mais rápido o texto aparece
dialogue_timer = 0;
dialogue_current_text = "";
dialogue_full_page = false; // true quando a página atual terminou de aparecer
dialogue_just_opened = false;