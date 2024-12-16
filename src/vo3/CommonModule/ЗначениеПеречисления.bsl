
// Возвращает соответствие из всех значений перечисления.
// Параметры:
// 	ИмяМетаданных - Строка - имя метаданных перечисления
//  ПоЗначению - Булево - ключ для поиска имен (как в конфигураторе), дает зеркальный результат
//
// Возвращаемое значение:
//   Соответствие - коллекция всех значений указанных в перечислении.
//     * КлючСтруктуры - Строка - имя перечисления как оно задано в конфигураторе
//     * ЗначениеСтруктуры - ПеречислениеСсылка - ссылка на соответствующее значение.
//
Функция ВсеЗначенияПеречисления(ИмяМетаданных, ПоЗначению = Ложь) Экспорт
	
	Результат = Новый Соответствие;	
		
	Если ИмяМетаданных = "ТипыКонтактнойИнформации" Тогда
		ДанныеПеречислений = Значения_ТипыКонтактнойИнформации();
	ИначеЕсли ИмяМетаданных = "Saby_ЮрФизЛицо" Тогда
		ДанныеПеречислений = Значения_ЮрФизЛицо();
	ИначеЕсли ИмяМетаданных = "Saby_РолиКонтрагентов" Тогда
	    ДанныеПеречислений = Значения_РолиКонтрагентов();
	ИначеЕсли ИмяМетаданных = "Saby_ТипТитулаЭтрН" Тогда
		ДанныеПеречислений = Значения_ТипТитулаЭтрН();
	Иначе
		ДанныеПеречислений = Новый Структура;		
	КонецЕсли;
	
	Для Каждого ЭлементПеречисления Из ДанныеПеречислений Цикл
		
	 Если ПоЗначению Тогда
			Результат.Вставить(ЭлементПеречисления.Значение, ЭлементПеречисления.Ключ);
		Иначе
			Результат.Вставить(ЭлементПеречисления.Ключ, ЭлементПеречисления.Значение);
		КонецЕсли;
		
	КонецЦикла;
			
	Возврат Результат;
	
КонецФункции

// Возвращает соответствие из всех титулов перечисления.
// Параметры:
// 	ИмяМетаданных - Строка - имя метаданных перечисления
//
// Возвращаемое значение:
//   Соответствие - соответствие всех значений в перечислении.
//     * Ключ - Строка - синоним 
//     * Значение - Строка - имя перечисления как оно задано в конфигураторе.
//
Функция ВсеЗначенияПеречисленияПоСинониму(ИмяМетаданных) Экспорт
	
	Возврат ВсеЗначенияПеречисления(ИмяМетаданных, Истина);
	
КонецФункции

Функция Значения_ТипыКонтактнойИнформации()

	Типы = Новый Структура;
	Типы.Вставить("АдресЭлектроннойПочты", "Адрес электронной почты");
	Типы.Вставить("Телефон",               "Телефон"); 
	
	Возврат Типы;
	
КонецФункции

Функция Значения_ЮрФизЛицо()

	Типы = Новый Структура;
	Типы.Вставить("ЮрЛицоНеРезидент",              "Юр. лицо (нерезидент)");
	Типы.Вставить("ИндивидуальныйПредприниматель", "Индивидуальный предприниматель"); 
	Типы.Вставить("ФизЛицо",                       "Физическое лицо");
	Типы.Вставить("ЮрЛицо",                        "Юридическое лицо");
	
	Возврат Типы;
	
КонецФункции

Функция Значения_РолиКонтрагентов()
	
	Типы = Новый Структура;
	Типы.Вставить("УполномоченноеЛицоПеревозчика", "Уполномоченное лицо перевозчика");
	Типы.Вставить("УполномоченноеЛицо",            "Уполномоченное лицо"); 
	Типы.Вставить("Получатель",                    "Получатель");
	Типы.Вставить("Оформитель",                    "Оформитель");	
	Типы.Вставить("СторонаДокумента",              "Сторона документа");
	Типы.Вставить("ОтветственныйНаОсновании",      "Ответственный на основании");
	Типы.Вставить("Отправитель",                   "Отправитель");
	Типы.Вставить("МедосмотрЗаезд",                "МедосмотрЗаезд");
	Типы.Вставить("Перевозчик",                    "Перевозчик");
	Типы.Вставить("Отгрузчик",                     "Отгрузчик");
	Типы.Вставить("МедосмотрВыезд",                "МедосмотрВыезд");
	Типы.Вставить("Заказчик",                      "Заказчик");
	Типы.Вставить("ВладелецОбъекта",               "Владелец объекта");
	Типы.Вставить("ИнойПолучатель",                "Иной получатель");
	
	Возврат Типы;
	
КонецФункции

Функция Значения_ТипТитулаЭтрН()
	
	РезультатФункции = Новый Структура;
	
	РезультатФункции.Вставить("Погрузка",                 "Погрузка");
	РезультатФункции.Вставить("ПолучениеГруза",           "ПолучениеГруза");
	РезультатФункции.Вставить("ПриемкаГруза",             "ПриемкаГруза");
	РезультатФункции.Вставить("ВыдачаГруза",              "ВыдачаГруза");
	РезультатФункции.Вставить("Переадресовка",            "Переадресовка");
	РезультатФункции.Вставить("ЗаменаВодителяТС",         "ЗаменаВодителяТС");
	РезультатФункции.Вставить("ИзменениеСтоимости",       "ИзменениеСтоимости");
	РезультатФункции.Вставить("СогласованиеСтоимости",    "СогласованиеСтоимости");
	РезультатФункции.Вставить("ПереадресовкаУведомление", "ПереадресовкаУведомление");
	РезультатФункции.Вставить("УведомлениеОУточнении",    "УведомлениеОУточнении");
	
	Возврат РезультатФункции;
	
КонецФункции

