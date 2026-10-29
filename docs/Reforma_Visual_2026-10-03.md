# O Avesso — reforma visual

Aplicada em `C:\Users\pedro\GameMakerProjects\O_Avesso\joguin.yyp`, em 3 de outubro de 2026.

## Resultado

49 sprites existentes receberam arte original nova e foi acrescentado um sprite próprio para a batalha de Vasinho: 50 sprites e 66 quadros no total. A protagonista tem caminhada nas quatro direções. Pais, Nana, Faísca, Fio, Espinho, Ani, Relógio, Vasinho e Anima receberam desenhos novos; os retratos dos pais também foram substituídos.

A casa usa madeira clara, paredes em creme, tecidos em verde e terracota, móveis mais detalhados e iluminação para a noite. O quarto ganhou uma estante e uma área de desenho. O depósito mantém o berço como ponto focal. As sete salas do Avesso usam variações de violeta, azul e verde, com arquitetura própria, pisos de pedra, pontes e uma Varanda de madeira. Menus, diálogos, pausa, confirmação de item e batalha compartilham a paleta de carvão, marfim e âmbar.

A inspiração nas referências de Undertale aparece na perspectiva, na leitura das formas e na interface de pixel art. Personagens e objetos são originais, seguindo o contexto narrativo do O Avesso.

## Onde editar no projeto

- `sprites/`: quadros PNG nativos e camadas de edição dos sprites. Cada camada foi verificada contra o quadro correspondente.
- `scripts/scr_visual/scr_visual.gml`: pisos, paredes, tapetes, decoração, painéis e título. O cenário é desenhado em coordenadas inteiras.
- `objects/obj_room_ctrl`: aplica a arte da sala e mantém os sistemas de iluminação e eventos.
- `objects/obj_interact`, `obj_player`, `obj_char` e `obj_follower`: desenho dos objetos e sombras.
- Eventos Draw GUI dos controladores: interface reformulada.
- `scripts/scr_battle_data`: usa `spr_vasinho_batalha` na batalha; o sprite pequeno do mapa continua separado.
- `docs/visual/`: quatro atlas originais transparentes e o mapa de importação.

Os antigos tiles da casa estão preservados no projeto e ocultos em execução. O novo cenário vem do `scr_visual`; pintar aquelas camadas antigas não modifica o cenário atual. A história, os comandos das cenas, os atributos, as escolhas e os percursos de progressão foram mantidos. `Inicio` e `Room2` continuam como salas antigas de teste.

## Verificação

Compilação e execução no GameMaker para Windows:

| Execução | Resultado |
|---|---|
| Vitrine da casa, modo 3 | 0 falhas |
| Tour de cenários e interface, modo 4 | 0 falhas |
| Prólogo e Ato 1, caminho pacífico, modo 1 | 0 falhas |
| Prólogo e Ato 1, apagando Vasinho, modo 2 | 0 falhas |

O driver verificou salas, flags, integrantes do grupo e salvar/carregar. As capturas foram inspecionadas visualmente. Os PNGs foram verificados quanto a dimensões e transparência, com filtragem desligada no jogo.

O `save1.sav` e o `settings.sav` originais foram restaurados após os testes e comparados por SHA-256. O save continua na sala `rm_a1_ponte`. O projeto não depende das pastas de importação ou desta galeria para executar.

## Arquivos desta entrega

- [Galeria antes/depois](galeria.html): 18 capturas reais da execução, incluindo as dez salas da história, menus e batalha.
- [Backup do projeto original](O_Avesso-backup-original.zip): estado fornecido antes da reforma, incluindo alterações locais que já existiam. Exclui cache, Git e configurações de conectores.
- [Prompts usados para criar a arte](Prompts-da-arte.md): quatro chamadas da ferramenta image_gen integrada.
- [Registro da validação](validacao.json): resultados e hashes dos arquivos restaurados.

Para ver a casa desde o começo, reabra o projeto no GameMaker, execute e escolha **Novo jogo**. **Continuar** mantém a sua progressão anterior.
