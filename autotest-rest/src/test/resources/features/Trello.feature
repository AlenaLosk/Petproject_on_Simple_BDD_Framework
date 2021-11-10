#language:ru
@test

Функционал: Тестирование сервиса Trello
  -	Создать доску "KanbanTool"
  -	Создать колонку "Backlog"
  -	Добавить карточку в колонку Backlog с названием "Карточка для изучения API"
  -	Добавить вложение в виде любой фотографии
  -	Поставить срок выполнения на следующий день
  -	Добавить описание "Тут будет отмечаться прогресс обучения"
  -	Создать чек-лист с пунктами:
  - Понять протокол HTTP
  - Выучить методы запросов
  -	Отметить пункт в карточке "Понять протокол HTTP"
  -	Создать колонку "Done"
  -	Переместить карточку в эту колонку
  -	Архивировать колонку "Backlog"
  -	Отметить пункт в карточке "Выучить методы запросов"
  -	Поставить в карточке эмоджи Палец вверх

  Сценарий: cоздание доски "KanbanTool" в тестовой учетной записи
     # 1.1. Создание доски "KanbanTool"
    Пусть создаем запрос
      | method | path    |
      | POST   | /boards |
    И добавляем query параметры
      | name | KanbanTool |
    Когда отправляем запрос
    То получаем статус код 200
    Также извлекаем данные
      | nameBoard | $.name |
      | idBoard   | $.id   |

    # 1.2. Проверка наличия доски "KanbanTool" в рабочей области
    Пусть создаем запрос
      | method | path               |
      | GET    | /boards/${idBoard} |
    Когда отправляем запрос
    То получаем статус код 200
    Также извлекаем данные
      | respNameBoard | $.name |
      | respIdBoard   | $.id   |
    К тому же сравниваем значения
      | ${nameBoard} | == | ${respNameBoard} |
      | ${idBoard}   | == | ${respIdBoard}   |

  Сценарий: cоздание колонки "Backlog" на доске "KanbanTool" в тестовой учетной записи
     # 2.1. Создание колонки "Backlog"
    Пусть создаем запрос
      | method | path                     |
      | POST   | /boards/${idBoard}/lists |
    И добавляем query параметры
      | name | Backlog |
    Когда отправляем запрос
    То получаем статус код 200
    Также извлекаем данные
      | nameList | $.name |
      | idList   | $.id   |

    # 2.2. Проверка наличия колонки "Backlog" на доске "KanbanTool"
    Пусть создаем запрос
      | method | path             |
      | GET    | /lists/${idList} |
    Когда отправляем запрос
    То получаем статус код 200
    Также извлекаем данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
    К тому же сравниваем значения
      | ${nameList} | == | ${respNameList} |
      | ${idList}   | == | ${respIdList}   |
      | ${idBoard}  | == | ${respIdBoard}  |

  Сценарий: cоздание карточки "Карточка для изучения API" в колонке "Backlog" в тестовой учетной записи
     # 3.1. Создание карточки с названием "Карточка для изучения API" в колонке "Backlog"
    Пусть создаем запрос
      | method | path   |
      | POST   | /cards |
    И добавляем query параметры
      | idList | ${idList}                 |
      | name   | Карточка для изучения API |
    Когда отправляем запрос
    То получаем статус код 200
    Также извлекаем данные
      | nameCard | $.name |
      | idCard   | $.id   |

    # 3.2. Проверка наличия карточки с названием "Карточка для изучения API" в колонке "Backlog"
    Пусть создаем запрос
      | method | path             |
      | GET    | /cards/${idCard} |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respNameCard | $.name   |
      | respIdCard   | $.id     |
      | respIdList   | $.idList |
    К тому же сравниваем значения
      | ${nameCard} | == | ${respNameCard} |
      | ${idCard}   | == | ${respIdCard}   |
      | ${idList}   | == | ${respIdList}   |

  Сценарий: добавление вложения в виде любой фотографии в карточке с названием "Карточка для изучения API"
     # 4. Добавление фотографии
    Пусть создаем запрос
      | method | path                         |
      | POST   | /cards/${idCard}/attachments |
    И добавляем query параметры
      | name | foto1                                                                                                                   |
      | url  | https://cdnn21.img.ria.ru/images/156091/43/1560914352_0:62:2820:1648_1920x0_80_0_0_4901cf3e931ee2a56afde67b4def397e.jpg |
    Когда отправляем запрос
    Тогда получаем статус код 200

  Сценарий: добавление срока выполнения и описания в карточке с названием "Карточка для изучения API"
     # 5.1 Добавление срока выполнения на следующий день в формате ММ/ДД/ГГГГ и описания "Тут будет отмечаться прогресс обучения"
    Пусть создаем запрос
      | method | path             |
      | PUT    | /cards/${idCard} |
    И добавляем query параметры
      | due  | 11/11/2021                             |
      | desc | Тут будет отмечаться прогресс обучения |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | cardDue  | $.due  |
      | cardDesc | $.desc |

      # 5.2. Проверка срока выполнения и описания в карточке с названием "Карточка для изучения API" в колонке "Backlog"
    Пусть создаем запрос
      | method | path             |
      | GET    | /cards/${idCard} |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respCardDue  | $.due    |
      | respCardDesc | $.desc   |
      | respIdCard   | $.id     |
      | respIdList   | $.idList |
    К тому же сравниваем значения
      | ${cardDue}  | == | ${respCardDue}  |
      | ${cardDesc} | == | ${respCardDesc} |
      | ${idCard}   | == | ${respIdCard}   |
      | ${idList}   | == | ${respIdList}   |

  Сценарий: добавление чек-листа в карточку с названием "Карточка для изучения API"
     # 6.1 Добавление чек-листа в карточку с названием "Карточка для изучения API"
    Пусть создаем запрос
      | method | path                        |
      | POST   | /cards/${idCard}/checklists |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | idChecklist   | $.id   |
      | nameChecklist | $.name |

      # 6.2. Проверка появления чек-листа в карточке с названием "Карточка для изучения API"
    Пусть создаем запрос
      | method | path                       |
      | GET    | /checklists/${idChecklist} |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respIdChecklist   | $.id     |
      | respNameChecklist | $.name   |
      | respIdCard        | $.idCard |
    К тому же сравниваем значения
      | ${idChecklist}   | == | ${respIdChecklist}   |
      | ${nameChecklist} | == | ${respNameChecklist} |
      | ${idCard}        | == | ${respIdCard}        |

  Сценарий: добавление в чек-лист пунктов "Понять протокол HTTP" и "Выучить методы запросов"
     # 7.1 Добавление в созданный ранее чек-лист пункта "Понять протокол HTTP"
    Пусть создаем запрос
      | method | path                                  |
      | POST   | /checklists/${idChecklist}/checkItems |
    И добавляем query параметры
      | name | Понять протокол HTTP |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | idCheckItem1     | $.id          |
      | nameCheckItem1   | $.name        |
      | stateCheckItem1  | $.state       |
      | resp1IdChecklist | $.idChecklist |
    К тому же сравниваем значения
      | ${idChecklist} | == | ${resp1IdChecklist} |

      # 7.2 Добавление в созданный ранее чек-лист пункта "Выучить методы запросов"
    Пусть создаем запрос
      | method | path                                  |
      | POST   | /checklists/${idChecklist}/checkItems |
    И добавляем query параметры
      | name | Выучить методы запросов |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | idCheckItem2     | $.id          |
      | nameCheckItem2   | $.name        |
      | stateCheckItem2  | $.state       |
      | resp2IdChecklist | $.idChecklist |
    К тому же сравниваем значения
      | ${idChecklist} | == | ${resp2IdChecklist} |

  Сценарий: пункт "Понять протокол HTTP" отметить как выполненный
     # 8. Добавление галки в чек-бокс (статуса "Выполнен") у пункта "Понять протокол HTTP"
    Пусть создаем запрос
      | method | path                                       |
      | PUT    | /cards/${idCard}/checkItem/${idCheckItem1} |
    И добавляем query параметры
      | state | complete |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respIdCheckItem1    | $.id    |
      | respNameCheckItem1  | $.name  |
      | respStateCheckItem1 | $.state |
    К тому же сравниваем значения
      | ${idCheckItem1}    | == | ${respIdCheckItem1}    |
      | ${nameCheckItem1}  | == | ${respNameCheckItem1}  |
      | ${stateCheckItem1} | != | ${respStateCheckItem1} |

  Сценарий: cоздание колонки "Done" на доске "KanbanTool" в тестовой учетной записи
     # 9.1. Создание колонки "Done"
    Пусть создаем запрос
      | method | path                     |
      | POST   | /boards/${idBoard}/lists |
    И добавляем query параметры
      | name | Done |
    Когда отправляем запрос
    Также получаем статус код 200
    К тому же извлекаем данные
      | nameList2 | $.name |
      | idList2   | $.id   |

    # 9.2. Проверка наличия колонки "Done" на доске "KanbanTool"
    Пусть создаем запрос
      | method | path              |
      | GET    | /lists/${idList2} |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
    К тому же сравниваем значения
      | ${nameList2} | == | ${respNameList} |
      | ${idList2}   | == | ${respIdList}   |
      | ${idBoard}   | == | ${respIdBoard}  |

  Сценарий: перемещение карточки "Карточка для изучения API" в колонку "Done" на доске "KanbanTool" в тестовой учетной записи
     # 10.1. Перемещение карточки "Карточка для изучения API" в колонку "Done"
    Пусть создаем запрос
      | method | path             |
      | PUT    | /cards/${idCard} |
    И добавляем query параметры
      | idList | ${idList2} |
    Когда отправляем запрос
    Тогда получаем статус код 200

  # 10.2. Проверка того, что карточка с названием "Карточка для изучения API", теперь в колонке "Done" на доске "KanbanTool"
    Пусть создаем запрос
      | method | path                  |
      | GET    | /cards/${idCard}/list |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
    К тому же сравниваем значения
      | ${nameList2} | == | ${respNameList} |
      | ${idList2}   | == | ${respIdList}   |
      | ${idBoard}   | == | ${respIdBoard}  |

  Сценарий: архивирование колонки "Backlog" на доске "KanbanTool" в тестовой учетной записи
     # 11.1. Архивирование колонки "Backlog"
    Пусть создаем запрос
      | method | path             |
      | PUT    | /lists/${idList} |
    И добавляем query параметры
      | closed | true |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | nameList | $.name   |
      | idList   | $.id     |
      | idClosed | $.closed |

    # 11.2. Проверка того, что колонка "Backlog" на доске "KanbanTool" заархивирована
    Пусть создаем запрос
      | method | path             |
      | GET    | /lists/${idList} |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
      | respIdClosed | $.closed  |
    К тому же сравниваем значения
      | ${nameList} | == | ${respNameList} |
      | ${idList}   | == | ${respIdList}   |
      | ${idBoard}  | == | ${respIdBoard}  |
      | ${idClosed} | == | ${respIdClosed} |

  Сценарий: пункт "Выучить методы запросов" отметить как выполненный
     # 12. Добавление галки в чек-бокс (статуса "Выполнен") у пункта "Выучить методы запросов"
    Пусть создаем запрос
      | method | path                                       |
      | PUT    | /cards/${idCard}/checkItem/${idCheckItem2} |
    И добавляем query параметры
      | state | complete |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respIdCheckItem2    | $.id    |
      | respNameCheckItem2  | $.name  |
      | respStateCheckItem2 | $.state |
    К тому же сравниваем значения
      | ${idCheckItem2}    | == | ${respIdCheckItem2}    |
      | ${nameCheckItem2}  | == | ${respNameCheckItem2}  |
      | ${stateCheckItem2} | != | ${respStateCheckItem2} |

  Сценарий: добавление стикера в карточке "Карточка для изучения API" в колонку "Done" на доске "KanbanTool" в тестовой учетной записи
     # 13.1 Добавление стикера в карточке "Карточка для изучения API"
    * сгенерируем переменные
      | top  | DD |
      | left | DD |
    Пусть создаем запрос
      | method | path                      |
      | POST   | /cards/${idCard}/stickers |
    И добавляем query параметры
      | image  | thumbsup |
      | top    | ${top}   |
      | left   | ${left}  |
      | zIndex | 10       |
    Когда отправляем запрос
    Тогда получаем статус код 200
    К тому же извлекаем данные
      | nameSticker | $.image |
      | idSticker   | $.id    |

     # 13.2 Проверка наличия стикера в карточке "Карточка для изучения API"
    Пусть создаем запрос
      | method | path                                   |
      | GET    | /cards/${idCard}/stickers/${idSticker} |
    Когда отправляем запрос
    Тогда получаем статус код 200
    Также извлекаем данные
      | respNameSticker | $.image |
      | respIdSticker   | $.id    |
    К тому же сравниваем значения
      | ${nameSticker} | == | ${respNameSticker} |
      | ${idSticker}   | == | ${respIdSticker}   |