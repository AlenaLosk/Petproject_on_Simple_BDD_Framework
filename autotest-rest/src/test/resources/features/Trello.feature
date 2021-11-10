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
    * создать запрос
      | method | path    |
      | POST   | /boards |
    * добавить query параметры
      | name | KanbanTool |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | nameBoard | $.name |
      | idBoard   | $.id   |

    # 1.2. Проверка наличия доски "KanbanTool" в рабочей области
    * создать запрос
      | method | path               |
      | GET    | /boards/${idBoard} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respNameBoard | $.name |
      | respIdBoard   | $.id   |
    * сравнить значения
      | ${nameBoard} | == | ${respNameBoard} |
      | ${idBoard}   | == | ${respIdBoard}   |

  Сценарий: cоздание колонки "Backlog" на доске "KanbanTool" в тестовой учетной записи
     # 2.1. Создание колонки "Backlog"
    * создать запрос
      | method | path                     |
      | POST   | /boards/${idBoard}/lists |
    * добавить query параметры
      | name | Backlog |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | nameList | $.name |
      | idList   | $.id   |

    # 2.2. Проверка наличия колонки "Backlog" на доске "KanbanTool"
    * создать запрос
      | method | path             |
      | GET    | /lists/${idList} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
    * сравнить значения
      | ${nameList} | == | ${respNameList} |
      | ${idList}   | == | ${respIdList}   |
      | ${idBoard}  | == | ${respIdBoard}  |

  Сценарий: cоздание карточки "Карточка для изучения API" в колонке "Backlog" в тестовой учетной записи
     # 3.1. Создание карточки с названием "Карточка для изучения API" в колонке "Backlog"
    * создать запрос
      | method | path   |
      | POST   | /cards |
    * добавить query параметры
      | idList | ${idList}                 |
      | name   | Карточка для изучения API |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | nameCard | $.name |
      | idCard   | $.id   |

    # 3.2. Проверка наличия карточки с названием "Карточка для изучения API" в колонке "Backlog"
    * создать запрос
      | method | path             |
      | GET    | /cards/${idCard} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respNameCard | $.name   |
      | respIdCard   | $.id     |
      | respIdList   | $.idList |
    * сравнить значения
      | ${nameCard} | == | ${respNameCard} |
      | ${idCard}   | == | ${respIdCard}   |
      | ${idList}   | == | ${respIdList}   |

  Сценарий: добавление вложения в виде любой фотографии в карточке с названием "Карточка для изучения API"
     # 4. Добавление фотографии
    * создать запрос
      | method | path                         |
      | POST   | /cards/${idCard}/attachments |
    * добавить query параметры
      | name | foto1                                                                                                                   |
      | url  | https://cdnn21.img.ria.ru/images/156091/43/1560914352_0:62:2820:1648_1920x0_80_0_0_4901cf3e931ee2a56afde67b4def397e.jpg |
    * отправить запрос
    * статус код 200

  Сценарий: добавление срока выполнения и описания в карточке с названием "Карточка для изучения API"
     # 5.1 Добавление срока выполнения на следующий день в формате ММ/ДД/ГГГГ и описания "Тут будет отмечаться прогресс обучения"
    * создать запрос
      | method | path             |
      | PUT    | /cards/${idCard} |
    * добавить query параметры
      | due  | 11/11/2021                             |
      | desc | Тут будет отмечаться прогресс обучения |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | cardDue  | $.due  |
      | cardDesc | $.desc |

      # 5.2. Проверка срока выполнения и описания в карточке с названием "Карточка для изучения API" в колонке "Backlog"
    * создать запрос
      | method | path             |
      | GET    | /cards/${idCard} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respCardDue  | $.due    |
      | respCardDesc | $.desc   |
      | respIdCard   | $.id     |
      | respIdList   | $.idList |
    * сравнить значения
      | ${cardDue}  | == | ${respCardDue}  |
      | ${cardDesc} | == | ${respCardDesc} |
      | ${idCard}   | == | ${respIdCard}   |
      | ${idList}   | == | ${respIdList}   |

  Сценарий: добавление чек-листа в карточку с названием "Карточка для изучения API"
     # 6.1 Добавление чек-листа в карточку с названием "Карточка для изучения API"
    * создать запрос
      | method | path                        |
      | POST   | /cards/${idCard}/checklists |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | idChecklist   | $.id   |
      | nameChecklist | $.name |

      # 6.2. Проверка появления чек-листа в карточке с названием "Карточка для изучения API"
    * создать запрос
      | method | path                       |
      | GET    | /checklists/${idChecklist} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respIdChecklist   | $.id     |
      | respNameChecklist | $.name   |
      | respIdCard        | $.idCard |
    * сравнить значения
      | ${idChecklist}   | == | ${respIdChecklist}   |
      | ${nameChecklist} | == | ${respNameChecklist} |
      | ${idCard}        | == | ${respIdCard}        |

  Сценарий: добавление в чек-лист пунктов "Понять протокол HTTP" и "Выучить методы запросов"
     # 7.1 Добавление в созданный ранее чек-лист пункта "Понять протокол HTTP"
    * создать запрос
      | method | path                                  |
      | POST   | /checklists/${idChecklist}/checkItems |
    * добавить query параметры
      | name | Понять протокол HTTP |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | idCheckItem1     | $.id          |
      | nameCheckItem1   | $.name        |
      | stateCheckItem1  | $.state       |
      | resp1IdChecklist | $.idChecklist |
    * сравнить значения
      | ${idChecklist} | == | ${resp1IdChecklist} |

      # 7.2 Добавление в созданный ранее чек-лист пункта "Выучить методы запросов"
    * создать запрос
      | method | path                                  |
      | POST   | /checklists/${idChecklist}/checkItems |
    * добавить query параметры
      | name | Выучить методы запросов |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | idCheckItem2     | $.id          |
      | nameCheckItem2   | $.name        |
      | stateCheckItem2  | $.state       |
      | resp2IdChecklist | $.idChecklist |
    * сравнить значения
      | ${idChecklist} | == | ${resp2IdChecklist} |

  Сценарий: пункт "Понять протокол HTTP" отметить как выполненный
     # 8. Добавление галки в чек-бокс (статуса "Выполнен") у пункта "Понять протокол HTTP"
    * создать запрос
      | method | path                                       |
      | PUT    | /cards/${idCard}/checkItem/${idCheckItem1} |
    * добавить query параметры
      | state | complete |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respIdCheckItem1    | $.id    |
      | respNameCheckItem1  | $.name  |
      | respStateCheckItem1 | $.state |
    * сравнить значения
      | ${idCheckItem1}    | == | ${respIdCheckItem1}    |
      | ${nameCheckItem1}  | == | ${respNameCheckItem1}  |
      | ${stateCheckItem1} | != | ${respStateCheckItem1} |

  Сценарий: cоздание колонки "Done" на доске "KanbanTool" в тестовой учетной записи
     # 9.1. Создание колонки "Done"
    * создать запрос
      | method | path                     |
      | POST   | /boards/${idBoard}/lists |
    * добавить query параметры
      | name | Done |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | nameList2 | $.name |
      | idList2   | $.id   |

    # 9.2. Проверка наличия колонки "Done" на доске "KanbanTool"
    * создать запрос
      | method | path              |
      | GET    | /lists/${idList2} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
    * сравнить значения
      | ${nameList2} | == | ${respNameList} |
      | ${idList2}   | == | ${respIdList}   |
      | ${idBoard}   | == | ${respIdBoard}  |

  Сценарий: перемещение карточки "Карточка для изучения API" в колонку "Done" на доске "KanbanTool" в тестовой учетной записи
     # 10.1. Перемещение карточки "Карточка для изучения API" в колонку "Done"
    * создать запрос
      | method | path             |
      | PUT    | /cards/${idCard} |
    * добавить query параметры
      | idList | ${idList2} |
    * отправить запрос
    * статус код 200

  # 10.2. Проверка того, что карточка с названием "Карточка для изучения API", теперь в колонке "Done" на доске "KanbanTool"
    * создать запрос
      | method | path                  |
      | GET    | /cards/${idCard}/list |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
    * сравнить значения
      | ${nameList2} | == | ${respNameList} |
      | ${idList2}   | == | ${respIdList}   |
      | ${idBoard}   | == | ${respIdBoard}  |

  Сценарий: архивирование колонки "Backlog" на доске "KanbanTool" в тестовой учетной записи
     # 11.1. Архивирование колонки "Backlog"
    * создать запрос
      | method | path             |
      | PUT    | /lists/${idList} |
    * добавить query параметры
      | closed | true |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | nameList | $.name   |
      | idList   | $.id     |
      | idClosed | $.closed |

    # 11.2. Проверка того, что колонка "Backlog" на доске "KanbanTool" заархивирована
    * создать запрос
      | method | path             |
      | GET    | /lists/${idList} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respNameList | $.name    |
      | respIdList   | $.id      |
      | respIdBoard  | $.idBoard |
      | respIdClosed | $.closed  |
    * сравнить значения
      | ${nameList} | == | ${respNameList} |
      | ${idList}   | == | ${respIdList}   |
      | ${idBoard}  | == | ${respIdBoard}  |
      | ${idClosed} | == | ${respIdClosed} |

  Сценарий: пункт "Выучить методы запросов" отметить как выполненный
     # 12. Добавление галки в чек-бокс (статуса "Выполнен") у пункта "Выучить методы запросов"
    * создать запрос
      | method | path                                       |
      | PUT    | /cards/${idCard}/checkItem/${idCheckItem2} |
    * добавить query параметры
      | state | complete |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respIdCheckItem2    | $.id    |
      | respNameCheckItem2  | $.name  |
      | respStateCheckItem2 | $.state |
    * сравнить значения
      | ${idCheckItem2}    | == | ${respIdCheckItem2}    |
      | ${nameCheckItem2}  | == | ${respNameCheckItem2}  |
      | ${stateCheckItem2} | != | ${respStateCheckItem2} |

  Сценарий: добавление стикера в карточке "Карточка для изучения API" в колонку "Done" на доске "KanbanTool" в тестовой учетной записи
     # 13.1 Добавление стикера в карточке "Карточка для изучения API"
    * сгенерировать переменные
      | top  | DD |
      | left | DD |
    * создать запрос
      | method | path                      |
      | POST   | /cards/${idCard}/stickers |
    * добавить query параметры
      | image  | thumbsup |
      | top    | ${top}   |
      | left   | ${left}  |
      | zIndex | 10       |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | nameSticker | $.image |
      | idSticker   | $.id    |

     # 13.2 Проверка наличия стикера в карточке "Карточка для изучения API"
    * создать запрос
      | method | path                                   |
      | GET    | /cards/${idCard}/stickers/${idSticker} |
    * отправить запрос
    * статус код 200
    * извлечь данные
      | respNameSticker | $.image |
      | respIdSticker   | $.id    |
    * сравнить значения
      | ${nameSticker} | == | ${respNameSticker} |
      | ${idSticker}   | == | ${respIdSticker}   |