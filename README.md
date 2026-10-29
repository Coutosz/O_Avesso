# O Avesso

> *tudo que a gente não diz vai parar em algum lugar*

RPG narrativo 2D em pixel art, feito em **GameMaker (GML)**. Projeto solo. Uma menina cai no Avesso, um mundo feito das coisas que as pessoas não dizem, e atravessa esse mundo ao lado da Faísca.

🚧 **Em desenvolvimento:** Prólogo e Ato 1 jogáveis.

## ⚙️ O que tem no código

- **Sistema de diálogo** com retratos, expressões, escolhas e nome do jogador nas falas
- **Motor de cutscenes** por lista de comandos (falar, perguntar, ramificar, mover personagens)
- **Batalha própria**, com inimigos e ataques definidos em dados (`scr_battle_data`)
- **Save/load** de progresso e configurações, com flags de história
- **Iluminação e cenário** desenhados por código (`scr_luz`, `scr_visual`), com salas escuras e fontes de luz
- Inventário, menu de pausa, NPCs, gatilhos de sala e transições com fade

## 🗂️ Estrutura

| Pasta | O que tem |
|---|---|
| `scripts/` | Lógica do jogo: diálogo, cutscene, batalha, save, textos |
| `objects/` | Jogador, NPCs, controladores (sistema, diálogo, batalha, sala) |
| `rooms/` | Salas do Prólogo e do Ato 1 |
| `sprites/`, `sounds/`, `fonts/` | Arte, áudio e fontes |
| `docs/` | Guia técnico e documento de design do jogo |

O passo a passo de onde mexer em cada coisa está em [`docs/Guia_Tecnico_Ato1.md`](docs/Guia_Tecnico_Ato1.md).

## ▶️ Como rodar

1. Instale o [GameMaker](https://gamemaker.io/).
2. Clone o repositório e abra o `joguin.yyp`.
3. Rode com **F5**.

## 👤 Autor

Projeto solo de [Pedro Couto](https://github.com/Coutosz): história, design e arquitetura. Código desenvolvido com apoio do [Claude Code](https://claude.com/claude-code).
