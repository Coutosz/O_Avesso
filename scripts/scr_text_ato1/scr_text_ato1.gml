// Textos do Prólogo e do Ato 1.
// Formato: cada chave tem um array de falas. "@quem " no começo diz quem fala; sem "@" é o narrador.
// "@mae.cansada " = fala da mãe com o retrato spr_retrato_mae_cansada (se não existir, usa o spr_retrato_mae).
// {nome} vira o nome do jogador. Pra cantar, use ♪ (a fonte da caixa de diálogo tem).
// Inglês: adicionar "en" em cada chave quando a história estiver fechada.
function scr_text_ato1() {
    var t = function(_key, _pt) { global.text_db[$ _key] = { pt: _pt }; };

    // ---------- Quem fala (plaquinha da caixa de diálogo) ----------
    t("spk_nana", "Nana");
    t("spk_nana_unk", "???");
    t("spk_faisca", "Faísca");
    t("spk_faisca_unk", "???");
    t("spk_espinho", "Espinho");
    t("spk_fio", "Fio");
    t("spk_mae", "Mãe");
    t("spk_pai", "Pai");
    t("spk_vasinho", "Vasinho");
    t("spk_ani", "Ani");
    t("spk_bexiga", "???");
    t("spk_relogio", "Seu Relógio");
    t("spk_sombrinha", "Sombrinha");

    // =====================================================================
    // PRÓLOGO — A CASA
    // =====================================================================
    t("p_quarto_inicio", [
        "Seu quarto. A janela tá aberta e entra um ventinho.",
        "Amanhã tem escola."
    ]);
    t("p_desenho", [
        "Um desenho da sua família. Você, mamãe, papai.",
        "O papai tá maior que a casa. Ficou assim mesmo."
    ]);
    t("p_cama_cedo", [
        "Ainda não. Você não tá com sono.",
        "Mentira, tá um pouco."
    ]);
    t("p_cama_ok", ["Você deita. A casa tá tão quieta que dá pra ouvir a geladeira."]);
    t("p_cama_noite", ["Não dá pra dormir com essa música."]);

    t("p_estante", [
        "Uma foto de vocês três na praia.",
        "Você tá com cara de choro. Tinha caído areia no seu sorvete."
    ]);
    t("p_calendario", [
        "Amanhã tá circulado de vermelho. Não tem nada escrito.",
        "Todo ano tem uma bolinha vermelha nesse dia, e todo ano ninguém fala nada."
    ]);
    t("p_geladeira", [
        "Um ímã de pizzaria e uma conta de luz.",
        "Dentro tem pudim. Não é seu. Ainda."
    ]);
    t("p_tv", ["Tá passando jogo. O papai nem tá olhando."]);
    t("p_sofa", ["O sofá tem o formato do papai."]);
    t("p_mesa", [
        "A mesa da cozinha. Tem uma bolsa em cima de uma das cadeiras.",
        "Tem farelo de pão também. Foi o papai."
    ]);
    t("p_pia", ["Louça. A mamãe lava sempre na mesma ordem: copo, prato, panela."]);
    t("p_fogao", [
        "Uma panela de feijão de molho pra amanhã.",
        "Você levanta a tampa. Continua sendo feijão."
    ]);
    t("p_planta", [
        "Uma espada-de-são-jorge.",
        "A mamãe diz que é contra olho gordo. O papai diz que é contra visita."
    ]);
    t("p_colecao", [
        "O pote da sua coleção: tampinha, figurinha repetida, uma pedra que parece um sapo.",
        "Olhando de lado, o sapo parece que tá rindo."
    ]);
    t("p_porta_dia", ["Trancada. É o depósito."]);
    t("p_porta_noite", [
        "A porta do depósito tá aberta.",
        "Ela nunca fica aberta."
    ]);

    t("p_mae_1", [
        "@mae ♪ Dorme, dorme, grãozinho de luz... ♪",
        "(Ela te vê e para no meio.)",
        "@mae Ué. Ainda acordada?",
        "@mae Escova os dentes e cama, mocinha."
    ]);
    t("p_mae_2", [
        "@mae Essa música? Sei lá. Grudou na cabeça hoje.",
        "(Ela não volta a cantar.)"
    ]);
    t("p_mae_3", [
        "@mae.cansada Amanhã a mamãe tá meio cansadinha, tá bom?",
        "@mae.cansada Mas passa. Sempre passa."
    ]);
    t("p_mae_rep", ["@mae Cama, mocinha. Já."]);

    t("p_pai_1", ["@pai Ô, filha. Sabe o que o tomate foi fazer no banco?"]);
    t("p_pai_1_opts", ["O quê?", "..."]);
    t("p_pai_1a", [
        "@pai Tirar extrato.",
        "(Ele ri sozinho. Depois fica olhando pra TV sem ver.)"
    ]);
    t("p_pai_1b", [
        "@pai ...Tirar extrato.",
        "@pai.sem_graca Nada? Nem um sorrisinho? Tá bom, tá bom.",
        "(Ele volta a olhar pra TV sem ver.)"
    ]);
    t("p_pai_2", ["@pai Amanhã o papai folga."]);
    t("p_pai_2_opts", ["De novo?", "..."]);
    t("p_pai_2a", [
        "@pai É. Todo ano, né.",
        "@pai.sem_graca ...Vai dormir, vai."
    ]);
    t("p_pai_2b", ["@pai Vai dormir, vai. Já passou da hora."]);
    t("p_pai_porta", [
        "Você pergunta o que tem no depósito.",
        "@pai.sem_graca Depósito, filha. Só bagunça. Um dia a gente arruma."
    ]);
    t("p_pai_rep", ["@pai Shh. Pênalti."]);

    t("p_noite_relogio", ["3:12"]);
    t("p_noite_acorda", [
        "Alguém tá cantarolando no corredor.",
        "É a música da mamãe.",
        "Só que a mamãe tá dormindo."
    ]);
    t("p_deposito_caixas", ["Caixas. Uma diz NATAL. As outras não dizem nada."]);
    t("p_lencol", [
        "Tem alguma coisa embaixo do lençol.",
        "Montada pela metade. Tem grade, tipo um portãozinho.",
        "A música tá vindo daqui."
    ]);
    t("p_lencol_opts", ["Encostar", "Deixar quieto"]);
    t("p_lencol_quieto", ["Você deixa quieto.", "A música não para."]);
    t("p_cai", ["O chão vira poeira."]);

    // =====================================================================
    // ATO 1 — SALA 0: A QUEDA
    // =====================================================================
    t("a1_queda_float", [
        "Tudo cheira a guardado.",
        "Tá escuro. Escuro de não ver a própria mão."
    ]);

    // A Faísca te acha
    t("a1_faisca_oi", [
        "@faisca_unk ...Ufa. Foi embora.",
        "@faisca_unk Eu tava te olhando desde lá de trás. Cê caiu tipo POF!",
        "@faisca_unk Eu ia falar oi antes, mas fiquei com vergonha.",
        "@faisca_unk Passou. Oi! Como cê chama?"
    ]);
    t("a1_faisca_oi_opts", ["{nome}.", "..."]);
    t("a1_faisca_oi_a", ["@faisca_unk {nome}. {nome}. {nome}! Gostei. Parece nome de bolo."]);
    t("a1_faisca_oi_b", [
        "(Você não fala nada. Ela chega bem perto e lê a etiqueta do seu pijama.)",
        "@faisca_unk {nome}! Tá escrito em você!"
    ]);
    t("a1_faisca_oi_2", [
        "@faisca Eu sou a Faísca. Eu nasci de vela de aniversário.",
        "@faisca Aqui é escuro, né? Fica pertinho que eu clareio.",
        "(A Faísca resolveu que agora anda com você.)"
    ]);
    t("a1_faisca_tut_carinho", ["(Aperte Z perto dela pra fazer carinho.)"]);
    t("a1_poeira", [
        "Um monte de poeira dourada. Foi aqui que você caiu.",
        "É fofo e brilha um pouco. Não parece coisa de comer."
    ]);

    // =====================================================================
    // SALA 1: O CORREDOR DOS PERTENCES
    // =====================================================================
    t("a1_mala", ["Uma mala cheia de meias sem par.", "Elas parecem esperançosas."]);
    t("a1_ventilador", ["Um ventilador sem hélice.", "Ele ainda tenta."]);
    t("a1_carrinho", ["Um carrinho de bebê virado."]);
    t("a1_patinete", ["Um patinete com uma roda só.", "A outra deve estar em algum lugar por aqui, esperando também."]);
    t("a1_cadeira", ["Uma cadeira de escola. Alguém escreveu LU + CAROL com corretivo."]);

    t("a1_escuro_1", [
        "@faisca Ó. Daqui pra frente é mais escuro ainda.",
        "@faisca Eu não tenho medo do escuro. O escuro que tem medo de mim.",
        "@faisca ...Mas fica pertinho, tá? Pra ele não criar coragem.",
        "(Segure X e a Faísca brilha mais forte. Ela cansa rápido.)"
    ]);

    t("a1_nana_conhece", [
        "@nana_unk Ai, meu Deus. Machucou? Deixa eu ver.",
        "@nana_unk Dedo, dedo, dedo... tá tudo aí. Graças.",
        "@nana_unk Criança. Aqui. Sozinha. De pijama.",
        "(Ela fala cada palavra como se fosse um crime separado.)",
        "@faisca Ela não tá sozinha. Ela tá comigo.",
        "@nana Eu sou a Nana. Cê tá com fome? Cê tem cara de fome."
    ]);
    t("a1_nana_conhece_opts", ["Tô.", "..."]);
    t("a1_nana_conhece_a", [
        "@nana Claro que tá. Criança sempre tá.",
        "@nana Senta aí que eu termino a comida."
    ]);
    t("a1_nana_conhece_b", [
        "@nana Hum. Quietinha. Tudo bem, eu falo pelas duas.",
        "@nana Senta aí que eu termino a comida."
    ]);

    // Falas da Nana quando ela está te seguindo

    // =====================================================================
    // SALA 2: A PONTE
    // =====================================================================
    t("a1_sino", ["Um sino de vento enferrujado."]);
    t("a1_sino_opts", ["Tocar", "Deixar"]);
    t("a1_sino_toca", ["Dlin.", "(Ele toca uma nota só, meio desafinada.)"]);
    t("a1_sino_depois", ["O sino balança devagar. Parece satisfeito."]);

    // =====================================================================
    // SALA 3: VASINHO (tutorial de batalha)
    // =====================================================================
    t("a1_vasinho_ve", [
        "(Lá na frente, no escuro, tem dois olhinhos de novo.)",
        "@faisca {nome}. Tem outro ali.",
        "@faisca É um Apagado. Quando um Eco esquece quem era, ele fica assim, pretinho.",
        "@faisca Na minha luz eles ficam devagar. E dá pra ver o formato.",
        "@faisca Encostar não pode. Gela tudo.",
        "(Aperte Z num Apagado iluminado. Se você tiver alguma coisa dele, talvez ele lembre.)"
    ]);
    t("pega_regador", ["Um regador. Ainda tem um pouquinho de água.", "(Você pegou o Regador.)"]);
    t("pega_cabo", ["Um cabo de guarda-chuva, de madeira. Sem o guarda-chuva.", "(Você pegou o Cabo de guarda-chuva.)"]);
    t("item_regador", "Regador");
    t("item_cabo_guarda", "Cabo de guarda-chuva");

    t("ap_escuro", ["Tá escuro demais pra ver o que é."]);
    t("ap_contorno_vasinho", ["Na luz dá pra ver o contorno: um vasinho de planta, com as folhas caídas.", "Parece com sede."]);
    t("ap_contorno_sombrinha", ["Na luz dá pra ver o contorno: um guarda-chuva fechado. Falta o cabo.", "Ele gira devagar, procurando alguma coisa no chão."]);
    t("ap_lembrou_vasinho", [
        "Você vira o regador em cima do contorno preto.",
        "(A água some lá dentro. Aparece uma folha. Verde.)",
        "@vasinho ...Ah.",
        "@vasinho Eu tô ótima! Sério!",
        "@vasinho Alguém ia me regar amanhã. Foram três semanas de amanhã.",
        "@vasinho Obrigada. Eu vou morar lá na Varanda. Tem sol lá?",
        "@vasinho ...Não tem. Eu vou lá fingir."
    ]);
    t("faisca_nomeia_vasinho", [
        "@faisca Vou te chamar de Dona Folhinha.",
        "@vasinho Meu nome é Vasinho.",
        "@faisca Dona Folhinha Vasinho."
    ]);
    t("ap_lembrou_sombrinha", [
        "Você encaixa o cabo no contorno preto.",
        "(Clec.)",
        "@sombrinha ...Eu sou um guarda-chuva!",
        "@sombrinha Eu fiquei no ônibus 312. Banco do fundo. Tava chovendo.",
        "@sombrinha Ela desceu correndo. Tava atrasada pra alguma coisa.",
        "@sombrinha Espero que tenha dado tempo."
    ]);
    t("faisca_nomeia_sombrinha", ["@faisca Seu nome agora é Pingo.", "@sombrinha Tá bom.", "(Ela abre e fecha uma vez. Parece que gostou.)"]);
    t("faisca_aviso_arder", ["@faisca {nome}...", "@faisca Tá doendo nele."]);
    t("faisca_ardeu", [
        "(Sobrou poeira dourada. Daqui a pouco nem ela.)",
        "@faisca ...",
        "@faisca Ele tava com medo também.",
        "(A Faísca fica um pouco mais longe de você.)"
    ]);
    t("voce_apagou", ["Você apagou.", "@faisca Não faz isso de novo. Eu não gosto quando cê some."]);
    t("a1_vasinho_r0", ["@vasinho Tô ótima. Sério.", "@vasinho Dessa vez é sério mesmo."]);
    t("a1_vasinho_r1", ["@vasinho Você podia me pôr um pouquinho mais pra lá. Ali parece que tem mais luz.", "(Não tem.)"]);
    t("a1_sombrinha_r0", ["@sombrinha Se chover aqui, eu abro pra você.", "@sombrinha Nunca choveu. Mas eu tô pronta."]);
    t("a1_sombrinha_r1", ["@sombrinha Ônibus 312. Banco do fundo.", "@sombrinha Eu sei de cor. É a única coisa que eu sei de cor."]);
    t("en_vasinho", "Vasinho");
    t("bt_vasinho_intro", [
        "Vasinho bloqueia o caminho. As folhas dela tão tremendo.",
        "@nana Não precisa correr pra briga, viu? Às vezes ficar quieta um instante já resolve."
    ]);
    t("bt_vasinho_flavor_0", "Vasinho finge que tá tudo bem.");
    t("bt_vasinho_flavor_1", "Vasinho tenta ficar em pé mais reta.");
    t("bt_vasinho_flavor_2", "Cheira a terra seca.");
    t("bt_vasinho_flavor_3", "Vasinho olha pra você de canto de folha.");
    t("bt_vasinho_turno_0", ["@nana Pega a água, meu bem! Essa aí faz bem! Foge das folhas secas!"]);
    t("bt_act_perguntar", "Perguntar como ela tá");
    t("bt_act_elogiar", "Dizer que ela tá ótima");
    t("bt_vasinho_perguntar", [
        "Você pergunta se ela tá bem.",
        "@vasinho Ótima. Só meio seca. Mas quem não tá, né."
    ]);
    t("bt_vasinho_perguntar_2", [
        "Você pergunta de novo.",
        "@vasinho Já falei que tô ótima.",
        "@vasinho ...Obrigada por perguntar duas vezes, mesmo assim."
    ]);
    t("bt_vasinho_elogiar", [
        "Você diz que ela tá ótima.",
        "@vasinho Você nem olhou direito pra mim."
    ]);
    t("bt_vasinho_hesitar", [
        "Você fica quietinha.",
        "@vasinho ...",
        "@vasinho ...Você não gritou.",
        "@vasinho Todo mundo grita primeiro."
    ]);
    t("bt_vasinho_hesitar_2", ["Você continua quietinha. Vasinho para de tremer um pouco."]);
    t("bt_vasinho_calma", ["(Vasinho parece mais calma. Dá pra se DESPEDIR dela.)"]);
    t("bt_vasinho_despedir", [
        "Você dá tchau pra Vasinho.",
        "@vasinho Obrigada.",
        "@vasinho Eu vou ali pegar um sol.",
        "@vasinho Tem sol aqui? ...Não tem. Eu vou ali fingir."
    ]);
    t("bt_vasinho_hit", ["Você bate na Vasinho. Uma folha cai."]);
    t("bt_vasinho_apagada", [
        "Vasinho se desfaz em poeira dourada.",
        "Não sobra nem o vaso."
    ]);
    t("a1_vasinho_paz", ["@nana Isso. Viu só? Nem precisou de nada."]);
    t("a1_vasinho_apagou", [
        "@nana ...",
        "@nana Tá. Cê tava com medo. Eu entendo."
    ]);

    // =====================================================================
    // SALA 4: O VÃO ESTREITO
    // =====================================================================
    t("a1_vao_fresta", ["Uma fresta na parede. Só criança passa."]);
    t("a1_sino2", ["Outro sino. Esse tá mais enferrujado ainda."]);
    t("a1_sino2_toca", ["Dlin.", "(Desafinou mais que o outro. Mas funcionou.)"]);

    // =====================================================================
    // SALA 5: ANI (opcional)
    // =====================================================================
    t("a1_ani_1", ["@bexiga ...oi. Desculpa. Pode passar. Eu tô só aqui."]);
    t("a1_ani_2", [
        "@bexiga Meu nome é Ani. Tá escrito em mim, ó.",
        "(Ela vira. Tá escrito FELIZ ANI-. O resto murchou.)"
    ]);
    t("a1_ani_2_opts", ["É Feliz Aniversário.", "Prazer, Ani."]);
    t("a1_ani_2a", ["@ani ...ah.", "@ani ...", "@ani Prefiro Ani."]);
    t("a1_ani_2b", ["(Ela sobe um pouquinho.)", "@ani Ninguém nunca falou meu nome antes."]);
    t("a1_ani_3", ["@ani Quer ver uma coisa? ...Não, deixa. Não é nada."]);
    t("a1_ani_3_opts", ["Quero ver.", "Tá bom."]);
    t("a1_ani_3a", [
        "@ani Tá. Olha.",
        "@ani ...",
        "@ani ......",
        "@ani Pronto. Eu subo um pouquinho quando fico feliz. Foi isso."
    ]);
    t("a1_ani_3b", ["@ani Tá bom."]);
    t("a1_ani_rep", ["@ani Pode ir. Eu fico bem por aqui.", "(Ela tá um pouquinho mais alta que antes.)"]);

    // =====================================================================
    // SALA 6: A VARANDA
    // =====================================================================
    t("a1_var_chegada", [
        "(Luzinha pendurada. Uma rede. Cheiro de comida.)",
        "@faisca Chegamo! Chegamo! É a Varanda!",
        "@nana_unk Faísca? Quem é essa aí do seu lado?"
    ]);
    t("a1_var_espinho", [
        "@espinho (lá da ponta) Eu avisei! Não avisei? Eu avisei.",
        "@fio Ele avisou umas seis vezes."
    ]);

    // Conversas livres na Varanda
    t("a1_espinho_1", [
        "@espinho Fica tranquila que aqui na Varanda nada passa sem eu ver.",
        "@espinho Nem vento. Nem mosquito. Nem o Seu Relógio, que passa porque é vizinho.",
        "@espinho Essa aqui é a Dona Precaução.",
        "(Ele mostra um graveto.)",
        "@espinho Ela é tímida. Que nem você."
    ]);
    t("a1_espinho_r0", [
        "@espinho Cê viu isso? Nem tremi. Isso aí é o vento.",
        "@espinho Não é, Dona Precaução?",
        "(Silêncio.)",
        "@espinho Ela concorda."
    ]);
    t("a1_espinho_r1", [
        "@espinho Eu guardava um milharal, sabia? Bonito. Grandão.",
        "@espinho A família foi pra cidade e nunca mais voltou. Eu fiquei.",
        "@espinho Alguém tinha que ficar, né?",
        "(Ele ri.)",
        "@espinho Ô, pergunta besta. Ninguém tinha que ficar."
    ]);
    t("a1_espinho_r2", ["@espinho Tô de olho.", "(O olho dele tá meio torto.)"]);

    t("a1_fio_r0", [
        "@fio Regra 34 do Avesso: Eco não mente.",
        "@fio Regra 34-B: menos o Verniz.",
        "@fio Você não conhece o Verniz. Ótimo. Continua assim."
    ]);
    t("a1_fio_r1", [
        "(Ela amarra e desamarra a fita do pulso.)",
        "@fio Eu não tô nervosa. Isso aqui é... exercício de dedo."
    ]);
    t("a1_fio_r2", [
        "@fio Eu sei bastante coisa, tá? Eu sei coisa pra caramba, na verdade.",
        "@fio Mas não de TUDO."
    ]);

    t("a1_faisca_pet", [
        "@faisca Hihi. De novo.",
        "@faisca ...Tá bom, agora eu tô quente demais.",
        "(Dois segundos depois.)",
        "@faisca De novo."
    ]);
    t("a1_faisca_sorvete", [
        "@faisca {nome}. Lá em cima tem sorvete?",
        "@faisca Sorvete é frio? Frio dói?",
        "@faisca ...Eu ia gostar de ver um. De longe."
    ]);
    t("a1_faisca_r0", ["@faisca {nome}! {nome}. {nome}?", "@faisca Nada. Só queria ver se cê respondia."]);
    t("a1_faisca_r1", ["@faisca Tem quarenta e sete botões nessa varanda. Eu contei duas vezes.", "@faisca Deu quarenta e oito na segunda."]);
    t("a1_faisca_r2", [
        "@faisca Eu não tenho medo do escuro. O escuro que tem medo de mim.",
        "@faisca ...Mas se ficar escuro, fica pertinho, tá? Pra ele não criar coragem."
    ]);
    t("a1_faisca_tomate", ["@faisca Ei. Ei. {nome}. O que o tomate foi fazer no banco?"]);
    t("a1_faisca_tomate_opts", ["Tirar extrato.", "..."]);
    t("a1_faisca_tomate_a", [
        "@faisca COMO CÊ SABIA?!",
        "@faisca Ninguém sabe essa. Eu que inventei."
    ]);
    t("a1_faisca_tomate_b", [
        "@faisca TIRAR EXTRATO! HAHAHA.",
        "(Ela ri tanto que solta faísca.)"
    ]);
    t("a1_faisca_r3", ["@faisca Eu tenho cara de chocolate? Não responde. Tenho."]);
    t("a1_velinha_faisca", ["@faisca Quentinho.", "(Ela deita do lado do fogo e cochila na hora. Ronca uma chaminha bem pequena.)"]);

    t("a1_nana_panela", [
        "@nana Vai lá conhecer o povo. A comida tá quase.",
        "(Ela mexe a panela. Não tem nada na panela. Ela mexe mesmo assim.)"
    ]);
    t("a1_nana_jantar", [
        "@nana Pronto. Agora come.",
        "(Ela te dá um prato de alguma coisa morna. Tem gosto de domingo.)",
        "@nana Tá tarde, coração. Amanhã a gente vê como te levar pra casa.",
        "@nana Hoje cê dorme aqui. Na rede. Eu fico do lado."
    ]);

    t("a1_relogio_1", [
        "@relogio Tic. Tac. Boa noite, mocinha.",
        "@relogio Um avô me dava corda todo domingo, sabia? Falava pro neto: esse relógio vai ser seu um dia.",
        "@relogio Domingo é amanhã? Aqui é difícil saber."
    ]);
    t("a1_relogio_rep", ["@relogio Cuco.", "@relogio Desculpa. Escapou."]);
    t("a1_relogio_triste", ["@relogio Tic...", "@relogio Por que eu tô aqui, mesmo?"]);
    t("a1_nana_tchau", ["@nana Vai, coração. E volta, viu?", "(Ela mexe a panela vazia, sem olhar pra você. Mas tá sorrindo.)"]);

    t("a1_rede", ["Uma rede. Balança sozinha, devagarinho."]);
    t("a1_cadeira_praia", ["Uma cadeira de praia. Tem areia de verdade nela."]);
    t("a1_luzinha", ["Luzinha de Natal. Metade pisca, metade não.", "A metade que não pisca parece não se importar."]);
    t("a1_mesa_var", ["Uma mesa com toalha de crochê.", "Tem um furinho no lugar onde alguém apoiava o cotovelo."]);
    t("a1_saida_cedo", ["@nana Pra onde cê vai, criatura? Tá escuro lá. Fica aqui hoje."]);

    // A primeira noite
    t("a1_noite_1", [
        "(Você deita na rede. Ela balança.)",
        "@nana ♪ Dorme, dorme, grãozinho de luz,",
        "@nana que a noite já vem te ninar.",
        "@nana Tudo que é teu fica guardado...",
        "@nana ...",
        "@nana ...e o resto eu esqueci.",
        "(Ela ri baixinho, sem graça.)",
        "@nana Música é que nem gente. Vai ficando curtinha com a idade."
    ]);
    t("a1_noite_2", [
        "@faisca (bocejando) Eu não tô com sono.",
        "@faisca (bocejando mais) Nem um pouco.",
        "(Ela sobe no seu colo, dá três voltinhas e deita.)",
        "(Fica quentinho. Ela ronca uma chaminha bem pequena.)"
    ]);
    t("a1_manha", ["De manhã."]);

    // A manhã seguinte
    t("a1_manha_plano", [
        "@fio {nome}, escuta. Cê quer voltar pra casa, né?",
        "@fio Toda fresta tem dois lados. A sua, a que você caiu...",
        "@fio Eu procurei a noite inteira. Ela não tá aqui perto.",
        "@fio Ela tá lá no fundo. No centro do Avesso.",
        "@fio Ninguém vai lá. Lá é... bom. Lá é longe.",
        "@espinho Eu ia junto. Mas alguém tem que guardar a Varanda.",
        "@espinho ...E a Dona Precaução tem medo de altura.",
        "@faisca EU VOU! EU VOU! Eu nem sei pra onde, mas EU VOU!"
    ]);
    t("a1_manha_nana", [
        "@nana Eu não posso ir, coração.",
        "@nana Se eu fico longe daqui, eu esqueço mais umas notas. E eu já tô com pouca.",
        "(Ela sorri sem graça.)",
        "@nana Mas eu fiz uma coisa pra você.",
        "(Você ganhou a Marmita da Nana.)",
        "@nana Come quando bater a fome. Ou o medo. Funciona pros dois.",
        "@nana E promete que volta. Promete pra mim."
    ]);
    t("a1_manha_nana_magoada", [
        "@nana Eu não posso ir.",
        "@nana Se eu fico longe daqui, eu esqueço mais umas notas.",
        "(Ela olha pra você um tempo.)",
        "@nana Vai com cuidado.",
        "(Ela vira de costas e volta pra panela.)"
    ]);
    t("a1_manha_nana_opts", ["Prometo.", "..."]);
    t("a1_manha_nana_a", [
        "@nana Então tá prometido.",
        "@nana E você, Faísca. Cuida dela.",
        "@faisca Eu cuido! Eu sou ótima de cuidar!"
    ]);
    t("a1_manha_nana_b", [
        "(Você abraça a Nana. Ela é macia que nem cobertor de vó.)",
        "@nana ...Tá. Isso vale como promessa. Vale até mais."
    ]);
    t("a1_saida", [
        "@espinho Boa viagem! Eu fico de olho daqui.",
        "(O olho dele cai. Ele pega do chão.)",
        "@faisca Vamo? Vamo! Vamo."
    ]);
    t("a1_queda_sozinha", [
        "Você chama a mamãe. Baixinho.",
        "Não vem ninguém."
    ]);
    t("a1_olhos_1", [
        "(Lá atrás, no fundo do corredor, abriram dois olhinhos.)"
    ]);
    t("a1_olhos_2", [
        "(Eles não piscam. E tão mais perto.)"
    ]);
    t("a1_faisca_espanta", [
        "@faisca_unk SAI! Sai, sai, sai! Vai pro seu canto!",
        "(A luzinha cresce. A coisa recua um passo. Depois outro.)"
    ]);
    t("a1_espinho_vulto", [
        "(Tem alguém parado perto do sino. Alto. Magro. Não se mexe.)",
        "@faisca {nome}... fica atrás de mim.",
        "@faisca Eu sou pequena, mas eu queimo."
    ]);
    t("a1_espinho_alto_la", [
        "@espinho ALTO LÁ! Quem vem lá? Identifique-se!",
        "@faisca AAAAH!",
        "(Ele chega a cara bem perto da sua.)",
        "@espinho ...Ah. É uma criança. E a Faísca.",
        "@espinho Tá liberada. Mas fica esperta que eu tô de olho.",
        "(O olho dele cai. Ele pega do chão.)",
        "@espinho Tô de olho.",
        "@faisca Esse é o Espinho. Ele guarda a ponte. Ninguém pediu.",
        "@espinho Alguém tem que guardar.",
        "@espinho Toca o sino aí, menina. Pra Beira saber que tem gente chegando."
    ]);
    t("a1_espinho_vai", [
        "@espinho Isso. Agora a Nana já sabe.",
        "@espinho Vou na frente avisar que vai precisar de mais um prato.",
        "@espinho Não demora, que esfria."
    ]);
    t("a1_fio_conhece", [
        "(Uma menina azul tá amarrando uma fita no barbante da bexiga.)",
        "@fio Pronto. Agora se você voar, pelo menos a gente sabe pra onde.",
        "@ani ...obrigada.",
        "(A menina vê você e dá um pulo.)",
        "@fio Oi! Oi. Desculpa. Você é nova.",
        "@fio Eu sou a Fio. Eu amarro fita nas coisas, pra elas não se perderem de novo.",
        "@faisca Ela amarrou uma em mim uma vez.",
        "@fio Pegou fogo.",
        "@faisca Pegou fogo!",
        "@fio Você caiu, né? Acontece. Quer dizer, não acontece muito. Quase nunca.",
        "@fio Aqui é a Beira. Tudo que acabou de ser esquecido cai aqui primeiro.",
        "@fio Quanto mais pro meio, mais esquecida a coisa. E mais escuro.",
        "@fio A Varanda é logo ali. Tem luzinha e tem a Nana. Vem.",
        "@fio Ah, só uma regra: não come a poeira dourada. Eu sei que ela brilha."
    ]);
    t("a1_fio_var", [
        "@fio Viu? Falei que tinha luzinha.",
        "@fio Fui eu que pendurei. A metade que pisca fui eu. A outra metade já veio assim."
    ]);
    t("a1_panela", [
        "A panela da Nana, no fogãozinho de tijolo.",
        "Tá vazia. Cheira a feijão mesmo assim."
    ]);
}
