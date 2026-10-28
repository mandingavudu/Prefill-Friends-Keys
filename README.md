# Prefill Friends Keys

License / Licença: [MIT](LICENSE).

## English

WoW Retail / Midnight addon showing shared keystones beside Premade Groups.

### Use

The interface follows your client language: English, German, European and Latin American Spanish, French, Italian, Korean, Brazilian Portuguese, Russian, and Simplified and Traditional Chinese. Game terms use Blizzard’s native localization; unrecognized locales fall back to English.

1. Open **Premade Groups → Dungeons**. The key list appears on the right.
2. Open **Start a Group** and click a key. This selects its dungeon, **Mythic+**, and your default playstyle (**Competitive** initially).
3. Verify the title. The selected `+level` is highlighted in the side panel with a `Ctrl+C > Ctrl+V` hint: press **Ctrl+C**, click Blizzard's Title field, and paste if needed and permitted by your account.
4. Review the listing and click **List Group** yourself.

Change the default under **Options → AddOns → Prefill Friends Keys → Playstyle**. All four Blizzard playstyles are available using the client's localized labels. The preference is saved account-wide across reloads and sessions, and applies the next time you select a key. You can still change the listing's playstyle manually afterward.

When Raider.IO's visible profile panel overlaps the key list, the list moves past its right edge with an 8-pixel gap. If there is insufficient room, it uses the left of Premade Groups, or below the profile if neither side fits. Position checks account for UI scale and follow profile movement, resizing, and late loading. Hiding or moving the profile away restores the usual position. Raider.IO is optional and its frames are left unchanged.

**Title limitation:** Blizzard's Title edit box has `securityDisableSetText="true"`. Addons cannot directly insert an arbitrary friend's key level. Selecting a Mythic+ activity invokes Blizzard's own title generation, whose level can differ from the selected shared key. This addon does not override protected text methods or Blizzard APIs. Accounts with restricted custom text may also block pasting; those accounts must use Blizzard's generated title.

### Available keys

- Your key first, with a default yellow title.
- Party/raid members next, with party-chat blue titles.
- Online guild members next, with guild-chat green titles.
- Online Battle.net friends next, with Battle.net-chat blue titles.
- Other online character friends last, with white titles.

Players appear once, in their highest-priority category. Within each category, keys sort by descending level, then character name. Chat colors follow your game's chat color settings. The list has a fixed five-row viewport with a scrollbar and mouse-wheel scrolling; additional keys never increase the panel height.

Party and guild members must run this addon or share through `LibKeystone` (for example, BigWigs). Battle.net friends must be playing Retail in your region and run this addon; character friends must also run it.

No external addon is required. Party, guild, and friend requests run when the panel opens, on **Refresh**, and every 30 seconds while visible; requests are throttled to once per 10 seconds and friend requests are spaced apart. Each installation replies with its current key. Bag changes update your own displayed key. Keys expire after 10 minutes, disappear when their owner is no longer an online friend, guild member, or group member, and are not saved across reloads. Sharing and selection pause during combat. Friends without compatible sharing cannot be inspected for their key remotely; offline characters are not listed.

Dungeon matching uses the challenge map's instance map ID and available Mythic+ activities, with an exact localized dungeon-group name fallback when map IDs are unavailable. Unavailable dungeons show an explanation instead of selecting a different activity. Existing listings cannot be changed through the key list.

## Português

Addon para WoW Retail / Midnight que exibe pedras-chave compartilhadas ao lado dos Grupos prontos.

### Uso

A interface acompanha o idioma do cliente: inglês, alemão, espanhol europeu e latino-americano, francês, italiano, coreano, português brasileiro, russo e chinês simplificado e tradicional. Termos do jogo usam a localização nativa da Blizzard; idiomas não reconhecidos usam inglês.

1. Abra **Premade Groups → Dungeons**. A lista de chaves aparece à direita.
2. Abra **Start a Group** e clique em uma chave. Isso seleciona a masmorra, **Mítica+** e o estilo de jogo padrão (**Competitivo** inicialmente).
3. Confira o título. O `+nível` selecionado fica destacado no painel lateral com a indicação `Ctrl+C > Ctrl+V`: pressione **Ctrl+C**, clique no campo de título da Blizzard e cole, se necessário e permitido pela sua conta.
4. Revise o anúncio e clique em **List Group**.

Altere o estilo padrão em **Opções → AddOns → Prefill Friends Keys**. Os quatro estilos da Blizzard estão disponíveis com os nomes no idioma do jogo. A preferência é compartilhada entre os personagens da conta, permanece após recarregar a interface ou reiniciar o jogo e passa a valer ao selecionar a próxima chave. Você ainda pode alterar manualmente o estilo no anúncio.

Quando o painel de perfil visível do Raider.IO se sobrepõe à lista, ela se move para a direita dele, deixando 8 pixels de espaço. Se não houver espaço, fica à esquerda dos grupos prontos ou abaixo do perfil quando nenhum dos lados comporta a lista. O posicionamento considera a escala da interface e acompanha movimentações, redimensionamentos e carregamento posterior do Raider.IO. Ocultar ou afastar o perfil restaura a posição habitual. O Raider.IO é opcional e seus painéis não são alterados.

**Limitação do título:** o campo de título da Blizzard usa `securityDisableSetText="true"`. Addons não podem inserir diretamente o nível da chave de um amigo. Selecionar uma atividade Mítica+ aciona a geração de título da Blizzard, cujo nível pode diferir da chave escolhida. Este addon não substitui métodos de texto protegidos nem APIs da Blizzard. Contas com restrições de texto personalizado também podem bloquear a colagem; nesses casos, é necessário usar o título gerado pela Blizzard.

### Chaves Disponíveis

- Sua chave primeiro, com título no amarelo padrão.
- Membros do grupo/raide em seguida, com títulos no azul do chat de grupo.
- Membros da guilda conectados em seguida, com títulos no verde do chat de guilda.
- Amigos da Battle.net conectados em seguida, com títulos no azul do chat da Battle.net.
- Outros amigos de personagem conectados por último, com títulos brancos.

Cada personagem aparece uma única vez, na categoria de maior prioridade. Dentro de cada categoria, as chaves são ordenadas por nível decrescente e depois pelo nome do personagem. As cores seguem as configurações de chat do jogo. A lista tem uma área fixa de cinco linhas, com barra de rolagem e suporte à roda do mouse; chaves adicionais não aumentam a altura do painel.

Membros do grupo e da guilda precisam usar este addon ou compartilhar chaves pelo `LibKeystone` (por exemplo, pelo BigWigs). Amigos da Battle.net precisam jogar Retail na sua região e usar este addon; amigos de personagem também precisam usá-lo.

Nenhum addon externo é obrigatório. As solicitações ao grupo, à guilda e aos amigos ocorrem ao abrir o painel, clicar em **Refresh** e a cada 30 segundos enquanto ele estiver visível. Há um intervalo mínimo de 10 segundos entre atualizações, e as solicitações aos amigos são espaçadas. Cada instalação responde com sua chave atual. Alterações nas bolsas atualizam sua própria chave exibida. As chaves expiram após 10 minutos, desaparecem quando o dono deixa de ser um amigo conectado, membro da guilda conectado ou membro do grupo e não são salvas entre recarregamentos da interface. O compartilhamento e a seleção ficam pausados durante o combate. Não é possível consultar remotamente a chave de amigos sem compartilhamento compatível; personagens desconectados não são listados.

A identificação da masmorra usa o ID do mapa da instância e as atividades Míticas+ disponíveis. Quando os IDs não estão disponíveis, usa a correspondência exata do nome localizado do grupo de masmorras. Masmorras indisponíveis exibem uma explicação em vez de selecionar outra atividade. Anúncios existentes não podem ser alterados pela lista de chaves.

API references: [Blizzard Group Finder Lua](https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_GroupFinder/Mainline/LFGList.lua), [protected Title field](https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_GroupFinder/Mainline/LFGList.xml), [Battle.net API definitions](https://github.com/Gethe/wow-ui-source/blob/live/Interface/AddOns/Blizzard_APIDocumentationGenerated/BattleNetDocumentation.lua), [LibKeystone protocol](https://github.com/BigWigsMods/LibKeystone/blob/master/LibKeystone/LibKeystone.lua).
