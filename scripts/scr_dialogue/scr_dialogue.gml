function scr_dialogue_start(_pages) {
    with (obj_dialogue_manager) {
        dialogue_pages = _pages;
        dialogue_page_index = 0;
        dialogue_char_index = 0;
        dialogue_current_text = "";
        dialogue_full_page = false;
        dialogue_active = true;
		dialogue_just_opened = true;
    }
}