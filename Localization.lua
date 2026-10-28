local _, PFK = ...

local locales = {
    enUS = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Applied when you select a keystone. You can still change it in the group listing.",
        SELECT_OUTSIDE_COMBAT = "Select a key outside combat.",
        OPEN_GROUP_CREATION = "Open %s under %s first.",
        KEY_EXPIRED = "This key expired. Click %s.",
        ACTIVITY_UNAVAILABLE = "No available %s activity matches this key.",
        KEY_SELECTED = "%s selected. Check %s; copy the level if needed.",
        PREPARE_LISTING = "Click to prepare a group listing.",
        AVAILABLE_KEYS = "Available keys",
        REFRESH_OUTSIDE_COMBAT = "Refresh outside combat.",
        REQUESTING_KEYS = "Requesting keys. Refresh is limited to once per 10 seconds.",
        NO_SHARED_KEYS = "No shared keys yet.\nFriends need this addon; party and guild keys can also come from LibKeystone addons.",
        TITLE_LEVEL = "%s: Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "Open %s, then select a key.\nBlizzard controls automatic title text.",
        KEY_RECEIVED = "%s - received %ds ago",
    },
    deDE = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Wird beim Auswählen eines Schlüsselsteins angewendet. Du kannst dies im Gruppeneintrag noch ändern.",
        SELECT_OUTSIDE_COMBAT = "Wähle einen Schlüsselstein außerhalb des Kampfes.",
        OPEN_GROUP_CREATION = "Öffne zuerst „%s“ unter „%s“.",
        KEY_EXPIRED = "Dieser Schlüsselstein ist veraltet. Klicke auf „%s“.",
        ACTIVITY_UNAVAILABLE = "Für diesen Schlüsselstein ist keine passende Aktivität (%s) verfügbar.",
        KEY_SELECTED = "%s ausgewählt. Prüfe „%s“ und kopiere bei Bedarf die Stufe.",
        PREPARE_LISTING = "Klicken, um einen Gruppeneintrag vorzubereiten.",
        AVAILABLE_KEYS = "Schlüsselsteine",
        REFRESH_OUTSIDE_COMBAT = "Aktualisiere außerhalb des Kampfes.",
        REQUESTING_KEYS = "Schlüsselsteine werden angefordert. Aktualisierung alle 10 Sekunden möglich.",
        NO_SHARED_KEYS = "Noch keine geteilten Schlüsselsteine.\nFreunde benötigen dieses Addon; Gruppe und Gilde können auch Addons mit LibKeystone nutzen.",
        TITLE_LEVEL = "%s: Strg+C > Strg+V",
        SELECT_KEY_HINT = "Öffne „%s“ und wähle einen Schlüsselstein.\nBlizzard erstellt den automatischen Titel.",
        KEY_RECEIVED = "%s - vor %d Sek. empfangen",
    },
    esES = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Se aplica al seleccionar una piedra angular. Puedes cambiarlo en el anuncio del grupo.",
        SELECT_OUTSIDE_COMBAT = "Selecciona una piedra fuera de combate.",
        OPEN_GROUP_CREATION = "Abre primero %s en %s.",
        KEY_EXPIRED = "Esta piedra ha caducado. Pulsa %s.",
        ACTIVITY_UNAVAILABLE = "No hay ninguna actividad de %s disponible para esta piedra.",
        KEY_SELECTED = "%s seleccionado. Comprueba %s y copia el nivel si hace falta.",
        PREPARE_LISTING = "Haz clic para preparar un anuncio de grupo.",
        AVAILABLE_KEYS = "Piedras disponibles",
        REFRESH_OUTSIDE_COMBAT = "Actualiza fuera de combate.",
        REQUESTING_KEYS = "Solicitando piedras. Puedes actualizar cada 10 segundos.",
        NO_SHARED_KEYS = "Aún no hay piedras compartidas.\nLos amigos necesitan este addon; el grupo y la hermandad también pueden usar addons con LibKeystone.",
        TITLE_LEVEL = "%s: Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "Abre %s y selecciona una piedra.\nBlizzard genera el título automático.",
        KEY_RECEIVED = "%s - recibido hace %d s",
    },
    esMX = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Se aplica al seleccionar una piedra angular. Puedes cambiarlo en el anuncio del grupo.",
        SELECT_OUTSIDE_COMBAT = "Selecciona una piedra fuera de combate.",
        OPEN_GROUP_CREATION = "Abre primero %s en %s.",
        KEY_EXPIRED = "Esta piedra caducó. Haz clic en %s.",
        ACTIVITY_UNAVAILABLE = "No hay ninguna actividad de %s disponible para esta piedra.",
        KEY_SELECTED = "%s seleccionado. Revisa %s y copia el nivel si es necesario.",
        PREPARE_LISTING = "Haz clic para preparar un anuncio de grupo.",
        AVAILABLE_KEYS = "Piedras disponibles",
        REFRESH_OUTSIDE_COMBAT = "Actualiza fuera de combate.",
        REQUESTING_KEYS = "Solicitando piedras. Puedes actualizar cada 10 segundos.",
        NO_SHARED_KEYS = "Aún no hay piedras compartidas.\nLos amigos necesitan este addon; el grupo y la hermandad también pueden usar addons con LibKeystone.",
        TITLE_LEVEL = "%s: Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "Abre %s y selecciona una piedra.\nBlizzard genera el título automático.",
        KEY_RECEIVED = "%s - recibido hace %d s",
    },
    frFR = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Appliqué lorsque vous sélectionnez une clé. Vous pouvez encore le modifier dans l’annonce du groupe.",
        SELECT_OUTSIDE_COMBAT = "Sélectionnez une clé hors combat.",
        OPEN_GROUP_CREATION = "Ouvrez d’abord « %s » dans « %s ».",
        KEY_EXPIRED = "Cette clé a expiré. Cliquez sur « %s ».",
        ACTIVITY_UNAVAILABLE = "Aucune activité %s disponible ne correspond à cette clé.",
        KEY_SELECTED = "%s sélectionné. Vérifiez « %s » et copiez le niveau si nécessaire.",
        PREPARE_LISTING = "Cliquez pour préparer une annonce de groupe.",
        AVAILABLE_KEYS = "Clés disponibles",
        REFRESH_OUTSIDE_COMBAT = "Actualisez hors combat.",
        REQUESTING_KEYS = "Demande de clés en cours. Actualisation possible toutes les 10 secondes.",
        NO_SHARED_KEYS = "Aucune clé partagée pour le moment.\nVos amis doivent utiliser cet addon ; le groupe et la guilde peuvent aussi utiliser des addons avec LibKeystone.",
        TITLE_LEVEL = "%s : Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "Ouvrez « %s », puis sélectionnez une clé.\nBlizzard génère le titre automatique.",
        KEY_RECEIVED = "%s - reçu il y a %d s",
    },
    itIT = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Applicato quando selezioni una Chiave del Potere. Puoi ancora modificarlo nell’annuncio del gruppo.",
        SELECT_OUTSIDE_COMBAT = "Seleziona una chiave fuori dal combattimento.",
        OPEN_GROUP_CREATION = "Apri prima %s in %s.",
        KEY_EXPIRED = "Questa chiave è scaduta. Premi %s.",
        ACTIVITY_UNAVAILABLE = "Nessuna attività %s disponibile corrisponde a questa chiave.",
        KEY_SELECTED = "%s selezionato. Controlla %s e copia il livello se necessario.",
        PREPARE_LISTING = "Clicca per preparare un annuncio di gruppo.",
        AVAILABLE_KEYS = "Chiavi disponibili",
        REFRESH_OUTSIDE_COMBAT = "Aggiorna fuori dal combattimento.",
        REQUESTING_KEYS = "Richiesta delle chiavi in corso. Puoi aggiornare ogni 10 secondi.",
        NO_SHARED_KEYS = "Nessuna chiave condivisa.\nGli amici devono usare questo addon; gruppo e gilda possono anche usare addon con LibKeystone.",
        TITLE_LEVEL = "%s: Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "Apri %s, poi seleziona una chiave.\nBlizzard genera il titolo automatico.",
        KEY_RECEIVED = "%s - ricevuto %d s fa",
    },
    koKR = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "쐐기돌을 선택할 때 적용됩니다. 파티 모집 글에서 변경할 수 있습니다.",
        SELECT_OUTSIDE_COMBAT = "전투 중이 아닐 때 쐐기돌을 선택하세요.",
        OPEN_GROUP_CREATION = "먼저 %s 창을 여세요. 위치: %s",
        KEY_EXPIRED = "이 쐐기돌 정보는 만료되었습니다. %s 버튼을 누르세요.",
        ACTIVITY_UNAVAILABLE = "이 쐐기돌에 맞는 %s 활동이 없습니다.",
        KEY_SELECTED = "%s 선택 완료. %s 항목을 확인하고 필요하면 단수를 복사하세요.",
        PREPARE_LISTING = "클릭하여 파티 모집 글을 준비합니다.",
        AVAILABLE_KEYS = "사용 가능한 쐐기돌",
        REFRESH_OUTSIDE_COMBAT = "전투 중이 아닐 때 새로고침하세요.",
        REQUESTING_KEYS = "쐐기돌 정보를 요청 중입니다. 10초마다 새로고침할 수 있습니다.",
        NO_SHARED_KEYS = "아직 공유된 쐐기돌이 없습니다.\n친구는 이 애드온이 필요합니다. 파티원과 길드원은 LibKeystone 기반 애드온도 사용할 수 있습니다.",
        TITLE_LEVEL = "%s: Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "%s 창을 열고 쐐기돌을 선택하세요.\n자동 제목은 블리자드가 생성합니다.",
        KEY_RECEIVED = "%s - %d초 전에 받음",
    },
    ptBR = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Aplicado ao selecionar uma chave. Você ainda pode alterá-lo no anúncio do grupo.",
        SELECT_OUTSIDE_COMBAT = "Selecione uma chave fora de combate.",
        OPEN_GROUP_CREATION = "Abra primeiro %s em %s.",
        KEY_EXPIRED = "Esta chave expirou. Clique em %s.",
        ACTIVITY_UNAVAILABLE = "Nenhuma atividade de %s disponível corresponde a esta chave.",
        KEY_SELECTED = "%s selecionado. Confira %s e copie o nível, se necessário.",
        PREPARE_LISTING = "Clique para preparar um anúncio de grupo.",
        AVAILABLE_KEYS = "Chaves disponíveis",
        REFRESH_OUTSIDE_COMBAT = "Atualize fora de combate.",
        REQUESTING_KEYS = "Solicitando chaves. Você pode atualizar a cada 10 segundos.",
        NO_SHARED_KEYS = "Nenhuma chave compartilhada.\nAmigos precisam deste addon. Grupo e guilda também podem usar addons com LibKeystone.",
        TITLE_LEVEL = "%s: Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "Abra %s e selecione uma chave.\nA Blizzard gera o título automático.",
        KEY_RECEIVED = "%s - recebido há %d s",
    },
    ruRU = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "Применяется при выборе ключа. Можно изменить в объявлении группы.",
        SELECT_OUTSIDE_COMBAT = "Выберите ключ вне боя.",
        OPEN_GROUP_CREATION = "Сначала откройте «%s» в разделе «%s».",
        KEY_EXPIRED = "Данные ключа устарели. Нажмите «%s».",
        ACTIVITY_UNAVAILABLE = "Для этого ключа нет доступного занятия «%s».",
        KEY_SELECTED = "Выбрано: %s. Проверьте поле «%s» и при необходимости скопируйте уровень.",
        PREPARE_LISTING = "Нажмите, чтобы подготовить объявление группы.",
        AVAILABLE_KEYS = "Доступные ключи",
        REFRESH_OUTSIDE_COMBAT = "Обновляйте вне боя.",
        REQUESTING_KEYS = "Запрос ключей. Обновление доступно раз в 10 секунд.",
        NO_SHARED_KEYS = "Общих ключей пока нет.\nДрузьям нужен этот аддон; участники группы и гильдии также могут использовать аддоны с LibKeystone.",
        TITLE_LEVEL = "%s: Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "Откройте «%s» и выберите ключ.\nАвтоматический заголовок создаётся Blizzard.",
        KEY_RECEIVED = "%s — получено %d сек. назад",
    },
    zhCN = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "选择钥石时应用。你仍可在队伍招募信息中更改。",
        SELECT_OUTSIDE_COMBAT = "请在脱离战斗后选择钥石。",
        OPEN_GROUP_CREATION = "请先打开“%s”（位于“%s”）。",
        KEY_EXPIRED = "此钥石信息已过期。请点击“%s”。",
        ACTIVITY_UNAVAILABLE = "没有适用于此钥石的可用%s活动。",
        KEY_SELECTED = "已选择%s。请检查“%s”，必要时复制层数。",
        PREPARE_LISTING = "点击准备队伍招募信息。",
        AVAILABLE_KEYS = "可用钥石",
        REFRESH_OUTSIDE_COMBAT = "请在脱离战斗后刷新。",
        REQUESTING_KEYS = "正在请求钥石信息。每10秒可刷新一次。",
        NO_SHARED_KEYS = "暂无共享钥石。\n好友需要安装此插件；队友和公会成员也可使用支持LibKeystone的插件。",
        TITLE_LEVEL = "%s：Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "打开“%s”，然后选择钥石。\n自动标题由暴雪生成。",
        KEY_RECEIVED = "%s - %d秒前收到",
    },
    zhTW = {
        OPTIONS_PLAYSTYLE_TOOLTIP = "選擇鑰石時套用。你仍可在隊伍招募資訊中變更。",
        SELECT_OUTSIDE_COMBAT = "請在脫離戰鬥後選擇鑰石。",
        OPEN_GROUP_CREATION = "請先開啟「%s」（位於「%s」）。",
        KEY_EXPIRED = "此鑰石資訊已過期。請點選「%s」。",
        ACTIVITY_UNAVAILABLE = "沒有適用於此鑰石的可用%s活動。",
        KEY_SELECTED = "已選擇%s。請檢查「%s」，必要時複製層數。",
        PREPARE_LISTING = "點選以準備隊伍招募資訊。",
        AVAILABLE_KEYS = "可用鑰石",
        REFRESH_OUTSIDE_COMBAT = "請在脫離戰鬥後重新整理。",
        REQUESTING_KEYS = "正在請求鑰石資訊。每10秒可重新整理一次。",
        NO_SHARED_KEYS = "尚無共享鑰石。\n好友需要安裝此插件；隊友和公會成員也可使用支援LibKeystone的插件。",
        TITLE_LEVEL = "%s：Ctrl+C > Ctrl+V",
        SELECT_KEY_HINT = "開啟「%s」，然後選擇鑰石。\n自動標題由暴雪產生。",
        KEY_RECEIVED = "%s - %d秒前收到",
    },
}

locales.enGB = locales.enUS

local selectedLocale = locales[GetLocale()] or locales.enUS
if selectedLocale ~= locales.enUS then
    setmetatable(selectedLocale, { __index = locales.enUS })
end

-- Client-owned labels and terms come directly from Blizzard localization.
selectedLocale.OPTIONS_PLAYSTYLE = GROUP_FINDER_FILTER_PLAYSTYLE
selectedLocale.REFRESH = LFG_LIST_REFRESH
selectedLocale.UNKNOWN_DUNGEON = UNKNOWN
selectedLocale.SOURCE_SELF = YOU
selectedLocale.SOURCE_PARTY = PARTY
selectedLocale.SOURCE_GUILD = GUILD
selectedLocale.SOURCE_FRIEND = FRIEND
selectedLocale.SOURCE_BATTLENET = "Battle.net"

selectedLocale.OPEN_GROUP_CREATION = string.format(selectedLocale.OPEN_GROUP_CREATION, START_A_GROUP, DUNGEONS)
selectedLocale.KEY_EXPIRED = string.format(selectedLocale.KEY_EXPIRED, LFG_LIST_REFRESH)
selectedLocale.ACTIVITY_UNAVAILABLE = string.format(selectedLocale.ACTIVITY_UNAVAILABLE, PLAYER_DIFFICULTY_MYTHIC_PLUS)
selectedLocale.KEY_SELECTED = string.format(selectedLocale.KEY_SELECTED, PLAYER_DIFFICULTY_MYTHIC_PLUS, LFG_LIST_TITLE)
selectedLocale.TITLE_LEVEL = string.format(selectedLocale.TITLE_LEVEL, LFG_LIST_TITLE)
selectedLocale.SELECT_KEY_HINT = string.format(selectedLocale.SELECT_KEY_HINT, START_A_GROUP)

PFK.L = selectedLocale
