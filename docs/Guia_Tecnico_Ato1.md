# Guia técnico: como o Prólogo e o Ato 1 funcionam

Guia curto pra quem vai mexer no jogo. A história está na `docs/O_Avesso_Biblia_v5.md`. Aqui fica só o *onde mexer*.

## Ordem das salas

```
rm_boot → rm_menu → (Novo Jogo) → rm_casa_quarto ⇄ rm_casa → rm_casa_deposito
→ rm_a1_queda → rm_a1_corredor → rm_a1_ponte → rm_a1_vasinho → rm_a1_vao → rm_a1_ani → rm_a1_varanda → FIM DO ATO 1
```

`Inicio` e `Room2` são as salas de teste antigas. Continuam no projeto, mas o Novo Jogo agora começa no quarto.

## Onde fica cada coisa

| Quero mudar... | Arquivo |
|---|---|
| **Falas do Prólogo/Ato 1** | `scripts/scr_text_ato1` |
| Textos gerais (menus, batalha, velinhas, abertura) | `scripts/scr_text_db` |
| **O que acontece** ao examinar/conversar/pisar em algo | `scripts/scr_ato1` → `scr_event_cmds` |
| O que acontece ao **entrar numa sala** | `scripts/scr_ato1` → `scr_room_setup` |
| Cores/escuro da sala e luzes | `scripts/scr_ato1` → `scr_room_style` / `scr_room_lights` |
| **Inimigos** (dados e ataques) | `scripts/scr_battle_data` |
| Comandos de cutscene disponíveis | comentário no topo de `scripts/scr_cutscene` |

## Escrevendo falas

```gml
t("chave", [
    "Linha do narrador (sem @).",
    "@nana Fala da Nana. {nome} vira o nome do jogador.",
    "@faisca ~ cantando com til ~"
]);
```
- Quem fala: `@nana`, `@faisca`, `@espinho`, `@fio`, `@mae`, `@pai`, `@vasinho`, `@ani`, `@relogio`. Personagem que ainda não se apresentou: `@nana_unk` / `@faisca_unk` (aparece "???").
- A fonte da caixa de diálogo tem travessão (—) e nota (♪). Os menus ainda usam a fonte antiga, que não tem.
- Expressão do retrato: `@mae.cansada`, `@pai.sem_graca`.
- Escolhas: uma chave com array de opções, ex. `t("x_opts", ["Sim.", "..."]);`

## Fazendo algo acontecer (cutscene)

Um evento devolve uma lista de comandos que rodam em ordem:

```gml
case "talk_espinho":
    return [
        ["say", "a1_espinho_1"],                         // fala
        ["ask", "pergunta", "pergunta_opts"],            // fala + escolha
        ["branch", [["say", "resposta_a"]], [["say", "resposta_b"]]],
        ["move", "espinho", 120, 200, 2],                 // anda até x,y
        ["party_add", "espinho"],                         // entra no grupo
        ["flag", "falou_espinho", true]
    ];
```
Lista completa no topo do `scr_cutscene`: `say`, `ask`, `branch`, `if`, `flag`, `wait`, `move`, `teleport`, `face`, `goto`, `darken`, `shake`, `flash`, `title`, `battle`, `party_add/remove`, `spawn`, `destroy`, `item`, `heal`, `save`...

## Montando uma sala nova

1. Coloque um **`obj_room_ctrl`** na sala. Ele chama o `scr_room_setup` e cuida da luz. Se a sala ainda não tiver a camada `Tiles_Chao`, ele desenha um chão provisório.
2. Use **`obj_wall`** esticado pras paredes.
3. Coisas pra examinar: **`obj_interact`** (ou **`obj_interact_solid`**, se não puder atravessar). No *Creation Code* da instância:
   ```gml
   sprite_index = spr_mala;
   event = "a1_mala";   // se não tiver case no scr_event_cmds, mostra o texto com essa chave
   ```
4. Personagens: **`obj_char`** com `who = "nana";` no Creation Code. O sprite e a conversa (`talk_nana`) vêm sozinhos.
5. Portas: **`obj_room_trigger`** com `target_room`, `target_x`, `target_y` (e, se quiser, `require_flag` + `blocked_event`).
6. Áreas que disparam cena: **`obj_event_trigger`** com `event = "nome"; once = true;`.
7. Save: **`obj_velinha`**.

## Regra de ouro (continua valendo)

Controladores persistentes ficam **só na `rm_menu`**. Os dois novos já estão lá: **`obj_cutscene`** e **`obj_party`**.

## Teste automático

O `obj_dev_autotest` joga o Prólogo e o Ato 1 inteiros sozinho, conferindo salas, flags e grupo. Ele só liga quando o jogo é aberto com a variável de ambiente `OAVESSO_AUTOTEST`:
- `1` = caminho pacífico
- `2` = apagando a Vasinho

O resultado aparece no console (`[AUTOTEST] FIM. falhas: 0`). Ele também salva prints na pasta de save do jogo.

⚠️ **O teste sobrescreve o `save1.sav`.**

## Luz da Faísca e Apagados (bíblia v6)

- **Só a Faísca segue a protagonista.** `scr_party_add("nana")` e os outros só ligam a flag `conhece_nana`; ninguém mais vira seguidor.
- **Sala escura:** em `scr_room_style`, `dark` de 0.8 pra cima deixa a sala no breu, e a luz passa a ser a Faísca. As luzes fixas da sala (velinha, poeira, Ani) ficam em `scr_room_lights`.
- **Brilhar:** segurar X. A Faísca (`obj_follower` com `who == "faisca"`) tem `light_r`, `energia`, `cansada`, `distante` e `medo`, tudo no `Step_2`.
- **Carinho:** Z perto dela roda `talk_faisca`. Ela pula e solta faísca, e a cada 3 carinhos fala alguma coisa.
- **Apagado:** crie no `scr_room_setup` com
  `scr_apagado_spawn(id, quem_vira, x, y, item, sprite, linhas)`.
  - O `sprite` é o contorno. `linhas` serve pra cortar um pedaço; a Sombrinha, por exemplo, aparece sem o cabo.
  - Quando ele lembra, vira o `obj_char` de `quem_vira`.
  - Textos que cada Apagado precisa: `ap_contorno_<quem>`, `ap_lembrou_<quem>`, `faisca_nomeia_<quem>` e `talk_<quem>` (depois que ele lembrou).
  - Flag `ap_<id>`: 0 = nada, 1 = lembrou, 2 = ardeu. `apagados` conta quantos arderam.
- **Coisa no chão pra pegar:** `scr_item_spawn(x, y, sprite, evento)`. Ela brilha de leve no escuro, e o evento dá o item (`["item", "regador"]`) e some com ela (`["destroy", _inst]`).
- **Calor zerado** (encostou demais): `scr_apagou` volta ela pro ponto onde entrou na sala.
- **Tudo isso está em `scripts/scr_luz`.**
- **Teste automático:** o modo 1 faz os Apagados lembrarem e o modo 2 arde os Apagados. Os passos novos são `use`, `near_ap`, `lembrar`, `arder` e `expect_val`.

## Arte

> **Reforma visual de 03/10/2026:** o cenário atual é desenhado em `scripts/scr_visual`, com arte nova nos sprites e na interface. Os tiles anteriores estão preservados, mas ocultos em execução. A protagonista agora usa quadros de 24x36 px, mantendo a máscara de colisão dos pés. Consulte `docs/Reforma_Visual_2026-10-03.md` e `docs/visual/` para a direção de arte atual. As instruções sobre o tileset abaixo descrevem a montagem anterior da casa.

**Já no estilo final (a casa):** protagonista (andando nas 4 direções), mãe, pai, móveis do quarto/sala/cozinha/depósito, tileset 16x16 e retratos.
**Ainda provisório:** tudo do Avesso (Nana, Faísca, Espinho, Fio, salas do Ato 1).

Regras do estilo (siga isso pra arte nova combinar):
- Câmera 320x240. Criança ~20x37 px, adulto ~24x44 px. Contorno escuro de 1px por fora (#18101C), 3 tons por cor (sombra, base, luz).
- Origem dos sprites de personagem/móvel: **nos pés** (embaixo, no meio). A colisão da protagonista é só nos pés (`spr_mask_pe`).
- Protagonista: `spr_player_down/up/left/right`, 4 quadros cada (parada = quadro 0).

**Cenário = tiles numa grade de 16x16.** O tileset da casa é o `ts_casa` (imagem `spr_ts_casa`). Cada sala da casa tem 4 camadas de tile, que dá pra pintar direto no editor de sala:
| Camada | O que vai nela |
|---|---|
| `Tiles_Decor` | coisas penduradas na parede (pôster, quadro, relógio, janela da cozinha) |
| `Tiles_Tapete` | tapetes (9 pedaços: cantos, bordas e meio) |
| `Tiles_Parede` | parede de 4 tiles de altura: topo, meio, meio, rodapé |
| `Tiles_Chao` | chão e as beiradas pretas das paredes laterais |

- A parede de cima vai da linha 1 à 4 (y 16 a 80) e o chão começa em y = 80. As colisões continuam sendo `obj_wall`, invisível e sempre alinhado na grade.
- **Personagens podem sair da grade; cenário e móveis não.** Os móveis têm tamanho múltiplo de 16 (cama 32x48, geladeira 32x64, sofá 64x32...). A origem fica no meio da borda de baixo, então o `x, y` da instância é exatamente a linha da grade onde o móvel encosta no chão.
- Se mexer na imagem do tileset fora da IDE, o GameMaker precisa do `tilesets/ts_casa/output_tileset.png` atualizado. A IDE refaz esse arquivo sozinha quando você salva o tileset nela.

**Retratos (caixa de diálogo):** `spr_retrato_<quem>` (48x48, branco/cinza, fundo transparente; aparece em 2x). Expressões: `spr_retrato_mae_cansada` e na fala `"@mae.cansada Texto"`. Quem não tem retrato aparece com o nome no canto da caixa.

**Voz:** `snd_voz_<quem>` toca a cada letra (sem ele, usa `snd_voz`).

**Fonte:** `spr_fonte` (cada quadro é uma letra, na ordem da string em `obj_system_controller` → Create). Tem acento, travessão e ♪. Hoje ela é usada na caixa de diálogo; o resto dos menus ainda usa `fnt_main`.

**Luz:** `scr_room_lights` (no `scr_ato1`) diz onde tem luz em cada sala. De noite (flag `noite`) a sala escurece e as luzes "furam" o escuro.

**Teste de vitrine:** `OAVESSO_AUTOTEST=3` passa pela casa parando nos diálogos e salva prints (não mexe no save).

## Ato 1 revisado (outubro/2026)

**Ordem nova:** queda (sozinha) → corredor (uma coisa vem atrás dela; a Faísca chega e espanta) → ponte (o Espinho guardando o sino) → vasinho → vão → sala da Ani (a Fio amarrando fita na bexiga) → Varanda (a Nana). Cada um aparece no caminho; o Espinho e a Fio vão na frente e já estão na Varanda quando ela chega.

**Caminhada:** os sprites que andam têm 5 frames: 0 = parado (o desenho original), 1-4 = passo, meio, outro passo, meio. O frame muda pela distância andada (`scr_player_anim`, `obj_char` Step), não pelo tempo, por isso o pé não escorrega. O passo toca `snd_passo` baixinho. Quem gera os frames: `walk.py` (scratchpad/art2).

**Poses de cutscene:** `["pose", "player", spr_player_levanta, frame]` prende a protagonista num desenho; `["pose", "player", -1]` solta. `spr_player_levanta`: 0 deitada, 1 sentada, 2 agachada, 3 em pé, 4 e 5 batendo a poeira. `scr_fx_poeira(x, y)` solta a poeirinha dourada.

**Som (`scr_som`):** `snd_amb_avesso` em loop nas salas `rm_a1_*` (menos a Varanda) e, de vez em quando, uma coisa estranha baixinha (rangido, sussurro, passos, gota, sino, respiração, batida). Sozinha é mais alto e mais frequente; com a Faísca fica mais quieto. Na cutscene: `["sound", som, volume]` e `["silence", frames]` (o fundo para antes do susto).

**Apagado de cutscene:** `scripted = true` faz ele não perseguir nem encostar; a cutscene mexe nele pelo `ap_id` (`["move", "sombra_corredor", ...]`).

**Varanda:** sala 480x288. O cenário é a imagem `spr_bg_a1_varanda` (qualquer sala com `spr_bg_<nome sem rm_>` usa a imagem no lugar do desenho por código). As luzinhas são desenhadas por código (`scr_varanda_fios`, `scr_varanda_lampadas`) e cada lâmpada fura o escuro. As paredes da sala batem com o desenho (`varanda_room.py`). Tem porta de volta pra sala da Ani, pra quem ainda não achou o cabo da Sombrinha.

**Cuidado:** evento sem comando mostra o texto de mesma chave. Por isso as falas antigas da Nana na caminhada foram apagadas, não só desligadas.
