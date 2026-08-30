esc_hold_timer = 0;
scr_settings_load();

if (global.fullscreen_enabled) {
    window_set_fullscreen(true);
} else {
    window_center();
}

display_set_gui_size(640, 480);

global.text_db = {
    npc_teste_intro: { pt: "Oi, viajante! Nunca te vi por aqui.", en: "Oh, hi traveler! I've never seen you around here." },
    npc_teste_repeat: { pt: "Boa sorte na sua jornada.", en: "Good luck on your journey." },
    
    cutscene_1: { pt: "Diz-se que, muito antes de as casas terem paredes ou os relógios terem ponteiros, o mundo já esquecia coisas.", en: "It's said that, long before houses had walls or clocks had hands, the world already forgot things." },
    cutscene_2: { pt: "Um brinquedo deixado para trás numa mudança. Uma canção de ninar que a avó parou de cantarolar. Uma promessa dita debaixo de um cobertor, com a certeza de que duraria para sempre.", en: "A toy left behind in a move. A lullaby a grandmother stopped humming. A promise made under a blanket, certain it would last forever." },
    cutscene_3: { pt: "Essas coisas não desaparecem. Elas só... vão para outro lugar.", en: "These things don't disappear. They just... go somewhere else." },
    cutscene_4: { pt: "Esse lugar tem um nome, sussurrado só por quem já esteve lá e voltou para contar: O Avesso.", en: "That place has a name, whispered only by those who've been there and returned to tell: The Reverse." },
    cutscene_5: { pt: "Diz a lenda que, no começo, havia Alguém que cuidava de tudo o que ali chegava... Chamavam-na de Vela.", en: "Legend says that, in the beginning, there was Someone who cared for everything that arrived there... They called her Vela." },
    cutscene_6: { pt: "Ninguém sabe ao certo quando a canção parou.", en: "No one knows for certain when the song stopped." },
    cutscene_7: { pt: "E, de vez em quando, alguém pequeno o bastante, sozinho o bastante, capaz de acreditar o bastante... escorrega por ela.", en: "And, every once in a while, someone small enough, alone enough, able to believe enough... slips through it." },
    
    instructions_title: { pt: "COMO JOGAR", en: "HOW TO PLAY" },
    instructions_z: { pt: "Z - Confirmar / Interagir", en: "Z - Confirm / Interact" },
    instructions_x: { pt: "X - Cancelar", en: "X - Cancel" },
    instructions_c: { pt: "C - Menu", en: "C - Menu" },
    instructions_f4: { pt: "F4 - Tela Cheia", en: "F4 - Fullscreen" },
    instructions_esc: { pt: "Segure ESC - Sair do jogo", en: "Hold ESC - Quit game" },
    instructions_continue: { pt: "Z para continuar", en: "Z to continue" },
    
    label_items: { pt: "Itens", en: "Items" },
    label_stats: { pt: "Stats", en: "Stats" },
    label_name: { pt: "Nome", en: "Name" },
    label_lvl: { pt: "LVL", en: "LVL" },
    label_hp: { pt: "HP", en: "HP" },
    label_gold: { pt: "Gold", en: "Gold" },
    label_gratitude: { pt: "Gratidão", en: "Gratitude" },
    label_empty_slot: { pt: "-- vazio --", en: "-- empty --" }
};