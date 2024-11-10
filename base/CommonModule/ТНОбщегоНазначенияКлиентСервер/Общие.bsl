
//DynamicDirective

// Возвращает найденные строки в коллекции. Функция аналогична НайтиСтроки для таблицы значений,
// но можно передать массив структур.
//
// Параметры:
//  КоллекцияСтрок - МассивСтруктур,ТаблицаЗначений,ДанныеФормыКоллекция - коллекция для поиска
//  Отбор - Структура - отбор для поиска
//
// Возвращаемое значение:
//   Массив - массив найденных элементов коллекции
//
Функция НайтиСтрокиУниверсально(КоллекцияСтрок, Отбор) Экспорт
	
	Если КоллекцияСтрок = Неопределено Тогда
		РезультатФункции = Новый Массив;
	ИначеЕсли ТипЗнч(КоллекцияСтрок) = Тип("Массив") Тогда
		РезультатФункции = НайтиСтрокиВМассивеСтруктур(КоллекцияСтрок, Отбор);
	Иначе
		РезультатФункции = КоллекцияСтрок.НайтиСтроки(Отбор);
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

Функция НайтиСтрокиВМассивеСтруктур(КоллекцияСтрок, Отбор)
	
	РезультатФункции = Новый Массив;
	
	Для Каждого СтруктураСтроки Из КоллекцияСтрок Цикл
		
		УдовлетворяетОтбору = Истина;
		Для Каждого СоставОтбора Из Отбор Цикл
			УдовлетворяетОтбору = УдовлетворяетОтбору И СтруктураСтроки[СоставОтбора.Ключ] = СоставОтбора.Значение;
		КонецЦикла;
		
		Если УдовлетворяетОтбору Тогда
			РезультатФункции.Добавить(СтруктураСтроки);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

// Проверяет наличие реквизита или свойства у произвольного объекта без обращения к метаданным.
//
// Параметры:
//  Объект - Произвольный - объект, у которого нужно проверить наличие реквизита или свойства;
//  Имя - Строка - имя реквизита или свойства.
//
// Возвращаемое значение:
//  Булево - Истина, если есть.
//
Функция ЕстьРеквизитИлиСвойство(Объект, Имя) Экспорт
	
	УИД = Новый УникальныйИдентификатор();
	ВременнаяСтруктура = Новый Структура(Имя, УИД);
	ЗаполнитьЗначенияСвойств(ВременнаяСтруктура, Объект);
	
	Возврат ВременнаяСтруктура[Имя] <> УИД;
	
КонецФункции

//DynamicDirective

// Формирует массив из одиночного значения
// Параметры:
//  Значение - ПроизвольныйТип - значение любого типа
// Возвращаемое значение:
//  Массив
//
Функция ЗначениеВМассив(Значение) Экспорт
	
	Если ТипЗнч(Значение) = Тип("Массив") Тогда
		Возврат Значение;
	Иначе
		НовыйМассив = Новый Массив;
		НовыйМассив.Добавить(Значение);
		Возврат НовыйМассив;
	КонецЕсли;
	
КонецФункции

//DynamicDirective

// Создает объект ОписаниеТипов, содержащий тип Строка.
//
// Параметры:
//  ДлинаСтроки - Число - длина строки.
//
// Возвращаемое значение:
//  ОписаниеТипов - описание типа Строка.
//
Функция ОписаниеТипаСтрока(ДлинаСтроки) Экспорт
	
	Возврат Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(ДлинаСтроки));
	
КонецФункции

//DynamicDirective

// Создает объект ОписаниеТипов, содержащий тип Дата.
//
// Параметры:
//  ЧастиДаты - ЧастиДаты - набор вариантов использования значений типа Дата.
//
// Возвращаемое значение:
//  ОписаниеТипов - описание типа Дата.
//
Функция ОписаниеТипаДата(ЧастиДаты) Экспорт
	
	Возврат Новый ОписаниеТипов("Дата", , , Новый КвалификаторыДаты(ЧастиДаты));
	
КонецФункции

//DynamicDirective

Функция ПараметрыПоискаРекурсивно(ИмяПоля, Представление)
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("ЗначениеПоиска",        Представление);
	РезультатФункции.Вставить("ИскатьПоПредставлению", Истина);
	
	Если ЗначениеЗаполнено(ИмяПоля) Тогда
		РезультатФункции.ЗначениеПоиска        = Новый ПолеКомпоновкиДанных(ИмяПоля);
		РезультатФункции.ИскатьПоПредставлению = Ложь;
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

Процедура НайтиРекурсивно(КоллекцияЭлементов, МассивЭлементов, ИскатьПоПредставлению, ЗначениеПоиска)
	
	Для Каждого ЭлементОтбора Из КоллекцияЭлементов Цикл
		
		Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных") Тогда
			
			ЭлементНайден = (Не ИскатьПоПредставлению И ЭлементОтбора.ЛевоеЗначение = ЗначениеПоиска)
				Или (ИскатьПоПредставлению И ЭлементОтбора.Представление = ЗначениеПоиска);
			
			Если ЭлементНайден Тогда
				МассивЭлементов.Добавить(ЭлементОтбора);
			КонецЕсли;
		Иначе
			
			НайтиРекурсивно(ЭлементОтбора.Элементы, МассивЭлементов, ИскатьПоПредставлению, ЗначениеПоиска);
			
			Если ИскатьПоПредставлению И ЭлементОтбора.Представление = ЗначениеПоиска Тогда
				МассивЭлементов.Добавить(ЭлементОтбора);
			КонецЕсли;
			
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

//DynamicDirective

// Создает структуру параметров реквизита формы
//
// Параметры:
//  ИмяРеквизита - Строка - имя реквизита формы
//  ИмяЭлемента - Строка - имя элемента на форме
//  ИдентификаторСтроки - Строка - идентификатор строки
//
// Возвращаемое значение:
//  Структура
//
Функция ПараметрыРеквизитаФормы(ИмяРеквизита, ИмяЭлемента, ИдентификаторСтроки = Неопределено) Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("ЭтоСтрокаТаблицы",    ИдентификаторСтроки <> Неопределено);
	РезультатФункции.Вставить("ИмяРеквизита",        ИмяРеквизита);
	РезультатФункции.Вставить("ИмяЭлемента",         ИмяЭлемента);
	РезультатФункции.Вставить("ИдентификаторСтроки", ИдентификаторСтроки);
	
	РезультатФункции.Вставить("ИмяИсходнойТаблицы",          "");
	РезультатФункции.Вставить("ИдентификаторИсходнойСтроки", 0);
	
	РезультатФункции.Вставить("ДополнительныеПоля",  "");
	
	РезультатФункции.Вставить("ТолькоПросмотр", Ложь);
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

Функция КлючСсылка(Ссылка, Идентификатор = Неопределено) Экспорт
	
	Если ТипЗнч(Ссылка) = Тип("Структура")
		Или ЗначениеЗаполнено(Ссылка) Тогда
		КлючСоответствия = Ссылка;
	Иначе
		КлючСоответствия = Идентификатор;
	КонецЕсли;
	
	Возврат КлючСоответствия;

КонецФункции

