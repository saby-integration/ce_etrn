
#Область ПрограммныйИнтерфейс

// Обновляет неверно заполненные коды в справочнике, дополняя лидирующие нули.
//
Процедура ПерекодироватьСправочник() Экспорт
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ
	|	Saby_ОпасныеГрузы.Ссылка КАК Ссылка,
	|	ДЛИНАСТРОКИ(Saby_ОпасныеГрузы.Код) КАК Длина,
	|	Saby_ОпасныеГрузы.Код КАК Код
	|ИЗ
	|	Справочник.Saby_ОпасныеГрузы КАК Saby_ОпасныеГрузы
	|ГДЕ
	|	(ДЛИНАСТРОКИ(Saby_ОпасныеГрузы.Код) <> 10
	|			ИЛИ Saby_ОпасныеГрузы.Код ПОДОБНО ""% %"")";
	
	ВыборкаДанных = ЗапросДанных.Выполнить().Выбрать();
	Пока ВыборкаДанных.Следующий() Цикл
		
		ОбъектСправочника = ВыборкаДанных.Ссылка.ПолучитьОбъект();
		НовыйКод = СокрЛП(ОбъектСправочника.Код);
		
		ДлинаКодаСправочника = 10;
		Пока СтрДлина(НовыйКод) <> ДлинаКодаСправочника Цикл
			НовыйКод = "0" + НовыйКод;
		КонецЦикла;
		
		ОбъектСправочника.Код = НовыйКод;
		ОбъектСправочника.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

// Загружает с онлайна справочник опасных грузов.
//
// Параметры:
//  МассивНаименований - Массив - массив строк наименований для загрузки, если не передан, то грузятся все.
//  Результат - Структура - если передана, то в переменную возвращается результат загрузки.
//
Процедура ЗагрузитьСОнлайна(МассивНаименований = Неопределено, Результат = Неопределено) Экспорт
	
	ДанныеОпасныхГрузов = ДанныеОпасныхГрузов(МассивНаименований);
	
	ДанныеОпасныхГрузовДляЗагрузки = ДанныеОпасныхГрузовДляЗагрузки(ДанныеОпасныхГрузов);
	
	Загружено = 0;
	ШаблонТекстаОшибки = "Не удалось загрузить ""%1""(%2) по причине: %3";
	МассивОшибок = Новый Массив;
	
	Для Каждого СтруктураДанных Из ДанныеОпасныхГрузовДляЗагрузки Цикл
		
		Если ЗначениеЗаполнено(СтруктураДанных.Ссылка) Тогда
			ОбъектСправочника = СтруктураДанных.Ссылка.ПолучитьОбъект();
		Иначе
			ОбъектСправочника = Справочники.Saby_ОпасныеГрузы.СоздатьЭлемент();
		КонецЕсли;
		
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "Наименование",            СтруктураДанных.Наименование);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "ПолноеНаименование",      СтруктураДанных.Наименование);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "ТехническоеНаименование", СтруктураДанных.ТехническоеНаименование);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "Идентификатор",           СтруктураДанных.Идентификатор);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "НомерООН",                СтруктураДанных.НомерООН);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "Класс",                   СтруктураДанных.Класс);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "КлассификационныйКод",    СтруктураДанных.КодОпасногоГруза);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "ЗнакОпасности",           СтруктураДанных.НомерОпасности);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "ГруппаУпаковки",          СтруктураДанных.ГруппаУпаковки);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "ГруппаУпаковкиЗначение",  СтруктураДанных.ГруппаУпаковкиСсылка);
		ПрисвоитьЕслиНеПусто(ОбъектСправочника, "ТранспортныйИндекс",      СтруктураДанных.ТранспортнаяКатегория);
		
		Попытка
			ОбъектСправочника.Записать();
			Загружено = Загружено + 1;
		Исключение
			ТекстОшибки = СтрШаблон(
				ШаблонТекстаОшибки,
				СтруктураДанных.Наименование,
				СтруктураДанных.Идентификатор,
				ОписаниеОшибки());

			МассивОшибок.Добавить(ТекстОшибки);
		КонецПопытки;
		
	КонецЦикла;
	
	Если ДанныеОпасныхГрузовДляЗагрузки.Количество() > 0 Тогда
		ТекстРезультата = СтрШаблон(
			"Загружено данных %1 из %2",
			Формат(Загружено, "ЧДЦ=0; ЧГ="),
			Формат(ДанныеОпасныхГрузовДляЗагрузки.Количество(), "ЧДЦ=0; ЧГ="));
	Иначе
		ТекстРезультата = "Данные справочника актуальны. Загрузка не требуется";
	КонецЕсли;
	
	ОписаниеОшибок = СтрСоединить(МассивОшибок, Символы.ПС);
	
	Если Результат = Неопределено Тогда
		Если Загружено <> ДанныеОпасныхГрузовДляЗагрузки.Количество() Тогда
			Saby_ТНОбщегоНазначенияСервер.ЗаписатьОшибкуВЖурналРегистрации(
				Справочники.Saby_ОпасныеГрузы.ПустаяСсылка(), ТекстРезультата, ОписаниеОшибок);
		КонецЕсли;
	Иначе
		Результат.Вставить("Текст",          ТекстРезультата);
		Результат.Вставить("ОписаниеОшибок", ОписаниеОшибок);
	КонецЕсли;
	
КонецПроцедуры

// Дозаполняет реквизиты справочника после получения данных при чтении документа.
//
Процедура ДозаполнитьНовыеЭлементыДаннымиСОнлайна() Экспорт
	
	ТекстЗапроса =
	"ВЫБРАТЬ
	|	Saby_ОпасныеГрузы.ПолноеНаименование КАК Наименование,
	|	Saby_ОпасныеГрузы.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.Saby_ОпасныеГрузы КАК Saby_ОпасныеГрузы
	|ГДЕ
	|	Saby_ОпасныеГрузы.Идентификатор = &Идентификатор
	|	И НЕ Saby_ОпасныеГрузы.ПометкаУдаления";
	
	Saby_ТНОбщегоНазначенияСервер.ДозаполнитьНовыеЭлементыДаннымиСОнлайна(ТекстЗапроса, Справочники.Saby_ОпасныеГрузы);
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает признак необходимости дозаполнения справочника данными с онлайна.
//
// Возвращаемое значение:
//   Строка - строковое значение признака.
//
Функция ИдентификаторДозаполнения() Экспорт
	
	Возврат "Дозаполнить опасные грузы с онлайна";
	
КонецФункции

Функция ПреобразоватьНаименование(Наименование) Экспорт
	
	Возврат ВРег(СокрЛП(Наименование));
	
КонецФункции

#КонецОбласти // СлужебныйПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#Область ЗагрузкаСОнлайна

Функция ДанныеОпасныхГрузов(МассивНаименований = Неопределено)
	
	ДанныеСправочника = Saby_ТНОбщегоНазначенияСервер.СправочникСОнлайна("Справочник опасных грузов");
	
	ТаблицаДанныхДляЗагрузки = ТаблицаДанныхДляЗагрузки();
	
	НомерСтроки = 1;
	
	Для Каждого МассивДанных Из ДанныеСправочника Цикл
		
		НаименованиеСОнлайна = ПреобразоватьНаименование(МассивДанных[2]);
		
		Если МассивНаименований <> Неопределено И МассивНаименований.Найти(НаименованиеСОнлайна) = Неопределено Тогда
			Продолжить;
		КонецЕсли;
		
		СтрокаДанных = ТаблицаДанныхДляЗагрузки.Добавить();
		СтрокаДанных.НомерСтроки = НомерСтроки;
		
		ДопДанные = ДополнительныеДанныеСОнлайна(МассивДанных[4]);
		
		ГруппаУпаковкиСсылка = Перечисления.Saby_ГруппыУпаковки.ЗначениеПоКоду(СокрЛП(ДопДанные.ГруппаУпаковки));
		КлассСсылка          = Перечисления.Saby_КлассыОпасностиГрузов.ЗначениеПоКоду(СокрЛП(МассивДанных[5]));
		
		СтрокаДанных.Идентификатор           = МассивДанных[1];
		СтрокаДанных.Наименование            = НаименованиеСОнлайна;
		СтрокаДанных.ТехническоеНаименование = МассивДанных[3];
		СтрокаДанных.НомерООН                = МассивДанных[6];
		СтрокаДанных.Класс                   = МассивДанных[5];
		СтрокаДанных.КлассСсылка             = КлассСсылка;
		СтрокаДанных.КодОпасногоГруза        = ДопДанные.КодОпасногоГруза;
		СтрокаДанных.НомерОпасности          = ДопДанные.НомерОпасности;
		СтрокаДанных.ГруппаУпаковки          = ДопДанные.ГруппаУпаковки;
		СтрокаДанных.ГруппаУпаковкиСсылка    = ГруппаУпаковкиСсылка;
		СтрокаДанных.ТранспортнаяКатегория   = ДопДанные.ТранспКатегория;
		
		НомерСтроки = НомерСтроки + 1;
		
	КонецЦикла;
	
	Возврат ТаблицаДанныхДляЗагрузки;
	
КонецФункции

Функция ТаблицаДанныхДляЗагрузки()
	
	РезультатФункции = Новый ТаблицаЗначений;
	
	КвалификаторЧисла5 = Новый КвалификаторыЧисла(5, 0, ДопустимыйЗнак.Неотрицательный);
	
	ОписаниеТипаСсылки       = Новый ОписаниеТипов("СправочникСсылка.Saby_ОпасныеГрузы");
	ОписаниеТипаНомераСтроки = Новый ОписаниеТипов("Число", КвалификаторЧисла5);
	
	ОписаниеТипаКласса         = Новый ОписаниеТипов("ПеречислениеСсылка.Saby_КлассыОпасностиГрузов");
	ОписаниеТипаГруппыУпаковки = Новый ОписаниеТипов("ПеречислениеСсылка.Saby_ГруппыУпаковки");
	
	РезультатФункции.Колонки.Добавить("Ссылка",                  ОписаниеТипаСсылки);
	РезультатФункции.Колонки.Добавить("НомерСтроки",             ОписаниеТипаНомераСтроки);
	РезультатФункции.Колонки.Добавить("Идентификатор",           Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(36));
	РезультатФункции.Колонки.Добавить("Наименование",            Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(256));
	РезультатФункции.Колонки.Добавить("ТехническоеНаименование", Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(255));
	РезультатФункции.Колонки.Добавить("НомерООН",                Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(50));
	РезультатФункции.Колонки.Добавить("Класс",                   Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(16));
	РезультатФункции.Колонки.Добавить("КлассСсылка",             ОписаниеТипаКласса);
	РезультатФункции.Колонки.Добавить("КодОпасногоГруза",        Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(50));
	РезультатФункции.Колонки.Добавить("НомерОпасности",          Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(50));
	РезультатФункции.Колонки.Добавить("ГруппаУпаковки",          Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(100));
	РезультатФункции.Колонки.Добавить("ГруппаУпаковкиСсылка",    ОписаниеТипаГруппыУпаковки);
	РезультатФункции.Колонки.Добавить("ТранспортнаяКатегория",   Saby_ТНОбщегоНазначенияКлиентСервер.ОписаниеТипаСтрока(50));
	
	Возврат РезультатФункции;
	
КонецФункции

Функция ДополнительныеДанныеСОнлайна(СтрокаJSON)
	
	ЧтениеJSON = Новый ЧтениеJSON();
	ЧтениеJSON.УстановитьСтроку(СтрокаJSON);
	
	Возврат ПрочитатьJSON(ЧтениеJSON);
	
КонецФункции

Функция ДанныеОпасныхГрузовДляЗагрузки(ДанныеОпасныхГрузов)
	
	РезультатФункции = Новый Массив;
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ
	|	ДанныеОпасныхГрузов.НомерСтроки КАК НомерСтроки,
	|	ДанныеОпасныхГрузов.Идентификатор КАК Идентификатор,
	|	ДанныеОпасныхГрузов.Наименование КАК Наименование,
	|	ДанныеОпасныхГрузов.ТехническоеНаименование КАК ТехническоеНаименование,
	|	ДанныеОпасныхГрузов.НомерООН КАК НомерООН,
	|	ДанныеОпасныхГрузов.Класс КАК Класс,
	|	ДанныеОпасныхГрузов.КлассСсылка КАК КлассСсылка,
	|	ДанныеОпасныхГрузов.КодОпасногоГруза КАК КодОпасногоГруза,
	|	ДанныеОпасныхГрузов.НомерОпасности КАК НомерОпасности,
	|	ДанныеОпасныхГрузов.ГруппаУпаковки КАК ГруппаУпаковки,
	|	ДанныеОпасныхГрузов.ТранспортнаяКатегория КАК ТранспортнаяКатегория,
	|	ДанныеОпасныхГрузов.ГруппаУпаковкиСсылка КАК ГруппаУпаковкиСсылка
	|ПОМЕСТИТЬ ТаблицаОпасныхГрузов
	|ИЗ
	|	&ДанныеОпасныхГрузов КАК ДанныеОпасныхГрузов
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ВложенныйЗапрос.НомерСтроки КАК НомерСтроки,
	|	МАКСИМУМ(ВложенныйЗапрос.СсылкаПоИдентификатору) КАК СсылкаПоИдентификатору,
	|	МАКСИМУМ(ВложенныйЗапрос.СсылкаПоПолномуНаименованию) КАК СсылкаПоПолномуНаименованию,
	|	МАКСИМУМ(ВложенныйЗапрос.СсылкаПоНаименованию) КАК СсылкаПоНаименованию
	|ПОМЕСТИТЬ СуществующиеСправочники
	|ИЗ
	|	(ВЫБРАТЬ
	|		ТаблицаОпасныхГрузов.НомерСтроки КАК НомерСтроки,
	|		Saby_ОпасныеГрузы.Ссылка КАК СсылкаПоИдентификатору,
	|		ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка) КАК СсылкаПоПолномуНаименованию,
	|		ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка) КАК СсылкаПоНаименованию
	|	ИЗ
	|		ТаблицаОпасныхГрузов КАК ТаблицаОпасныхГрузов
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Saby_ОпасныеГрузы КАК Saby_ОпасныеГрузы
	|			ПО ТаблицаОпасныхГрузов.Идентификатор = Saby_ОпасныеГрузы.Идентификатор
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ТаблицаОпасныхГрузов.НомерСтроки,
	|		ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка),
	|		Saby_ОпасныеГрузы.Ссылка,
	|		ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)
	|	ИЗ
	|		ТаблицаОпасныхГрузов КАК ТаблицаОпасныхГрузов
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Saby_ОпасныеГрузы КАК Saby_ОпасныеГрузы
	|			ПО ТаблицаОпасныхГрузов.Наименование = Saby_ОпасныеГрузы.ПолноеНаименование
	|	
	|	ОБЪЕДИНИТЬ ВСЕ
	|	
	|	ВЫБРАТЬ
	|		ТаблицаОпасныхГрузов.НомерСтроки,
	|		ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка),
	|		ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка),
	|		Saby_ОпасныеГрузы.Ссылка
	|	ИЗ
	|		ТаблицаОпасныхГрузов КАК ТаблицаОпасныхГрузов
	|			ВНУТРЕННЕЕ СОЕДИНЕНИЕ Справочник.Saby_ОпасныеГрузы КАК Saby_ОпасныеГрузы
	|			ПО ТаблицаОпасныхГрузов.Наименование = Saby_ОпасныеГрузы.Наименование) КАК ВложенныйЗапрос
	|
	|СГРУППИРОВАТЬ ПО
	|	ВложенныйЗапрос.НомерСтроки
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	ТаблицаОпасныхГрузов.НомерСтроки КАК НомерСтроки,
	|	ВЫБОР
	|		КОГДА ЕСТЬNULL(СуществующиеСправочники.СсылкаПоИдентификатору, ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)) <> ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)
	|			ТОГДА СуществующиеСправочники.СсылкаПоИдентификатору
	|		КОГДА ЕСТЬNULL(СуществующиеСправочники.СсылкаПоПолномуНаименованию, ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)) <> ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)
	|			ТОГДА СуществующиеСправочники.СсылкаПоПолномуНаименованию
	|		КОГДА ЕСТЬNULL(СуществующиеСправочники.СсылкаПоНаименованию, ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)) <> ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)
	|			ТОГДА СуществующиеСправочники.СсылкаПоНаименованию
	|		ИНАЧЕ ЗНАЧЕНИЕ(Справочник.Saby_ОпасныеГрузы.ПустаяСсылка)
	|	КОНЕЦ КАК Ссылка
	|ИЗ
	|	ТаблицаОпасныхГрузов КАК ТаблицаОпасныхГрузов
	|		ЛЕВОЕ СОЕДИНЕНИЕ Справочник.Saby_ОпасныеГрузы КАК Saby_ОпасныеГрузы
	|		ПО ТаблицаОпасныхГрузов.Идентификатор = Saby_ОпасныеГрузы.Идентификатор
	|			И ТаблицаОпасныхГрузов.Наименование = Saby_ОпасныеГрузы.ПолноеНаименование
	|			И ТаблицаОпасныхГрузов.ТехническоеНаименование = Saby_ОпасныеГрузы.ТехническоеНаименование
	|			И ТаблицаОпасныхГрузов.НомерООН = Saby_ОпасныеГрузы.НомерООН
	|			И ТаблицаОпасныхГрузов.КлассСсылка = Saby_ОпасныеГрузы.Класс
	|			И ТаблицаОпасныхГрузов.КодОпасногоГруза = Saby_ОпасныеГрузы.КлассификационныйКод
	|			И ТаблицаОпасныхГрузов.НомерОпасности = Saby_ОпасныеГрузы.ЗнакОпасности
	|			И ТаблицаОпасныхГрузов.ГруппаУпаковки = Saby_ОпасныеГрузы.ГруппаУпаковки
	|			И ТаблицаОпасныхГрузов.ГруппаУпаковкиСсылка = Saby_ОпасныеГрузы.ГруппаУпаковкиЗначение
	|			И ТаблицаОпасныхГрузов.ТранспортнаяКатегория = Saby_ОпасныеГрузы.ТранспортныйИндекс
	|		ЛЕВОЕ СОЕДИНЕНИЕ СуществующиеСправочники КАК СуществующиеСправочники
	|		ПО ТаблицаОпасныхГрузов.НомерСтроки = СуществующиеСправочники.НомерСтроки
	|ГДЕ
	|	Saby_ОпасныеГрузы.Ссылка ЕСТЬ NULL";
	
	ЗапросДанных.УстановитьПараметр("ДанныеОпасныхГрузов", ДанныеОпасныхГрузов);
	
	ВыборкаДанных = ЗапросДанных.Выполнить().Выбрать();
	Пока ВыборкаДанных.Следующий() Цикл
		
		СтрокаДанныхОпасныхГрузов = ДанныеОпасныхГрузов[ВыборкаДанных.НомерСтроки - 1];
		СтрокаДанныхОпасныхГрузов.Ссылка = ВыборкаДанных.Ссылка;
		
		РезультатФункции.Добавить(СтрокаДанныхОпасныхГрузов);
		
	КонецЦикла;
	
	Возврат РезультатФункции;
	
КонецФункции

Процедура ПрисвоитьЕслиНеПусто(ОбъектСправочника, ИмяРеквизита, Значение)
	
	Если Не ЗначениеЗаполнено(Значение) Тогда
		Возврат;
	КонецЕсли;
	
	ОбъектСправочника[ИмяРеквизита] = Значение;
	
КонецПроцедуры

#КонецОбласти // ЗагрузкаСОнлайна

#КонецОбласти // СлужебныеПроцедурыИФункции
