// Banco de textos do jogo. Português primeiro; o inglês vem depois.
// Se uma chave não tiver "en", o jogo usa o "pt".
// Textos da história ficam separados por ato (scr_text_ato1, ...).
function scr_text_db_init() {
    global.text_db = {
        npc_teste_intro: { pt: "Oi, viajante! Nunca te vi por aqui.", en: "Oh, hi traveler! I've never seen you around here." },
        npc_teste_repeat: { pt: "Boa sorte na sua jornada.", en: "Good luck on your journey." },

        // ---------- Cutscene de abertura ----------
        cutscene_1: { pt: "Tudo que o mundo esquece vai parar em algum lugar.", en: "Everything the world forgets ends up somewhere." },
        cutscene_2: { pt: "O pé de meia que sumiu na máquina de lavar. O guarda-chuva que ficou no ônibus. A música que a vó cantava, e que ninguém mais lembra como termina.", en: "The sock that vanished in the washing machine. The umbrella left on the bus. The song grandma used to sing, that nobody remembers how it ends." },
        cutscene_3: { pt: "As coisas que nunca foram ditas também vão. Essas pesam mais.", en: "The things that were never said go there too. Those weigh more." },
        cutscene_4: { pt: "Esse lugar fica do outro lado das coisas. No forro do casaco. Atrás do armário. Do lado de dentro de uma promessa.", en: "That place is on the other side of things. In the lining of a coat. Behind the wardrobe. On the inside of a promise." },
        cutscene_5: { pt: "Quem já esteve lá chama de O Avesso.", en: "Those who have been there call it The Reverse." },
        cutscene_6: { pt: "No Avesso morava Vela. Vela não consertava nada. Ela sentava do lado de cada coisa esquecida e cantava baixinho, até ela conseguir dormir.", en: "In the Reverse lived Vela. Vela didn't fix anything. She sat beside each forgotten thing and sang softly, until it could fall asleep." },
        cutscene_7: { pt: "Um dia, a canção parou no meio.", en: "One day, the song stopped halfway." },
        cutscene_8: { pt: "Desde então, nada lá dorme direito.", en: "Since then, nothing there sleeps well." },
        cutscene_9: { pt: "E às vezes, quando uma casa fica quieta demais...", en: "And sometimes, when a house gets too quiet..." },
        cutscene_10: { pt: "...o chão dela abre uma frestinha.", en: "...its floor opens a tiny crack." },

        // ---------- Instruções ----------
        instructions_title: { pt: "COMO JOGAR", en: "HOW TO PLAY" },
        instructions_z: { pt: "Z - Confirmar / Interagir", en: "Z - Confirm / Interact" },
        instructions_x: { pt: "X - Cancelar", en: "X - Cancel" },
        instructions_c: { pt: "C - Menu", en: "C - Menu" },
        instructions_f4: { pt: "F4 - Tela Cheia", en: "F4 - Fullscreen" },
        instructions_esc: { pt: "Segure ESC - Sair do jogo", en: "Hold ESC - Quit game" },
        instructions_continue: { pt: "Z para continuar", en: "Z to continue" },

        // ---------- Menus ----------
        label_items: { pt: "Itens", en: "Items" },
        label_stats: { pt: "Stats", en: "Stats" },
        label_name: { pt: "Nome", en: "Name" },
        label_lvl: { pt: "LVL", en: "LVL" },
        label_hp: { pt: "HP", en: "HP" },
        label_gold: { pt: "Gold", en: "Gold" },
        label_gratitude: { pt: "Gratidão", en: "Gratitude" },
        label_empty_slot: { pt: "-- vazio --", en: "-- empty --" },

        // ---------- Opções genéricas ----------
        opt_sim_nao: { pt: ["Sim", "Não"], en: ["Yes", "No"] },

        // ---------- Batalha (geral) ----------
        bt_cmd_atacar: { pt: "ATACAR", en: "ATTACK" },
        bt_cmd_conversar: { pt: "CONVERSAR", en: "TALK" },
        bt_cmd_lembrar: { pt: "LEMBRAR", en: "REMEMBER" },
        bt_cmd_item: { pt: "ITEM", en: "ITEM" },
        bt_cmd_hesitar: { pt: "HESITAR", en: "HESITATE" },
        bt_cmd_despedir: { pt: "DESPEDIR", en: "FAREWELL" },
        bt_calma: { pt: "(calma)", en: "(calm)" },
        bt_lembrar_vazio: { pt: "Você não sabe nada sobre ela... ainda.", en: "You don't know anything about her... yet." },
        bt_item_vazio: { pt: ["Sua mochila tá vazia.", "Você tá de pijama, afinal."], en: ["Your backpack is empty.", "You're in pajamas, after all."] },
        bt_errou: { pt: "Você erra. Talvez de propósito.", en: "You miss. Maybe on purpose." },
        bt_gameover: { pt: "Você apagou.", en: "You faded." },
        bt_gameover_sub: { pt: "Z pra tentar de novo", en: "Z to try again" },
        bt_cura: { pt: "Você recuperou HP.", en: "You recovered HP." },

        // ---------- Itens ----------
        item_marmita: { pt: "Marmita da Nana", en: "Nana's Lunchbox" },
        item_marmita_usar: { pt: ["Você come a marmita da Nana.", "Tem gosto de domingo. Você recupera todo o HP."], en: ["You eat Nana's lunchbox.", "It tastes like Sunday. You recover all HP."] },

        // ---------- Velinhas (save) ----------
        velinha_primeira: { pt: ["Uma velinha apagada.", "Quando você chega perto, ela acende sozinha.", "O calorzinho dela te deixa um pouco mais corajosa. (HP restaurado.)"], en: ["An unlit little candle.", "When you get close, it lights up by itself.", "Its warmth makes you a little braver. (HP restored.)"] },
        velinha_acesa: { pt: ["A velinha continua acesa. Quentinha. (HP restaurado.)"], en: ["The candle is still lit. Warm. (HP restored.)"] },
        velinha_pergunta: { pt: "Salvar o jogo?", en: "Save the game?" },
        velinha_opcoes: { pt: ["Salvar", "Agora não"], en: ["Save", "Not now"] },
        velinha_salvo: { pt: "Pronto. A chama guardou você.", en: "Done. The flame kept you." },

        // ---------- Fim de ato ----------
        fim_ato1: { pt: "FIM DO ATO 1", en: "END OF ACT 1" },
        continua: { pt: "Continua...", en: "To be continued..." }
    };

    scr_text_ato1();
}
