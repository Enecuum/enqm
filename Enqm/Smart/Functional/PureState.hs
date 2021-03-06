module Enqm.Smart.Functional.PureState where

{-


Есть гиперграф транзакций

есть гиперстрелки
свидетельстрования (транзакция транзакции или микроблок ТТМ свидетельствуют другие транзакции или микроблок тем самам создавая элемент для дальнейшего консенсуса)
необходимости  (ТТМ нуждаются в ресурсе или подтверждении условий в будущем для своей валидности)
использования  (как один из вариантов ТТМ используют для чегото например часть данных из других ТТМ поэтому без них не могут быть получены хэши)
представления  (например результат работы ФСМИ представляет из себя результат работы функции от ГЛФ, или по резултатам работы паттерна в ФСМИ результат закрытия ряда транзакций представляется заверщенным аукционом)
есть морфизмы  (пользователь создал начальные данные для транзакции например, без морфизма это просто данные, их нужно преобразовать с помощью (свид,подписи,необх,использ) в тот вид который будет квалифицирован как элемент консенсуса)


функциональный смарт индикатор ФСМИ
был в какойто момент добавлен в глобальный гиперграф ГЛФ

так как ФСМИ присутствует в ГЛФ то

любой пользователь может использовать ФСМИ как pure функцию от ГЛФ к виртуальному гиперграфу ВГФ
так как эта функция pure и все имеют непротиворечивый ФСМИ за счёт консенсуса то ВГФ у всех пользователей тоже непротиворечив

если ни один пользователь не добавил в ГЛФ какое либо
свидетельствование, необходимость, использование, представление
по отнощению к ВГФ то
другим пользователям абсолютно нет нужды запускать ФСМИ

если это было сделано, в первую очередь свидетельствование ВГФ
то всем пользователям нужно будет запускать ФСМИ только для того чтобы проверить это свидетельствование, и по этой причине не надо вычислять весь ВГФ
так как весь ВГФ не нужен то консенсус принимает только те ФСМИ которые могут вычислить только выбранное подмножество ВГФ для целей верификации свидетельствования
также консенсус не даст выставить свидетельствование на ВГФ если ряд проверок и верификаций ФСМИ не удовлетворили параметрам безопастности скорости объёма памяти итд

ФСМИ не является контрактом по той причине что это всего лиш индикатор и право совершать сделки не имеет, только даёт информацию для свидетельствования которое создаёт пользователь

функциональный смарт контракт ФСМК
требует дополнительно качества верификации и требований
так как ему доверяется автосвидетельствование
гиперстрелка свидетельствования была выставлена на ВГФ а именно на ту часть которая создана ФСМК
так как гипергрань содержит несколько пунктов как для входа так и для выхода то новые свидетельствования могут стать новыми пунктами гиперстрелки автоматически
но под строгим контролем требований
что равноценно автоматическому комиту сделки
так как это гиперстрелка то есть история всех следствий связанных с ФСМК


-}

