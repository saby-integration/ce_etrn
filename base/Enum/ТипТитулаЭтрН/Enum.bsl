
#Область ПрограммныйИнтерфейс

// Единая точка входа для всего функционала описанного в данном модуле
//
// Параметры:
//  ИмяФункции - Строка - имя функции описанной в данном модуле
//  Параметр1 - Произвольный - первый параметр вызываемой функции
//  Параметр2 - Произвольный - второй параметр вызываемой функции
//  Параметр3 - Произвольный - третий параметр вызываемой функции
//
// Возвращаемое значение:
//   Произвольный - зависит от конкретной вызванной функции
//
Функция РезультатФункцииТитуловЭТрН(ИмяФункции, Параметр1 = Неопределено,
		Параметр2 = Неопределено, Параметр3 = Неопределено) Экспорт
	
	Если ИмяФункции = "ТитулОтказа" Тогда
		Возврат ТитулОтказаЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ЗначениеПоКоду" Тогда
		Возврат ЗначениеПоКодуЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ЗначениеПоИмениПодстановки" Тогда
		Возврат ЗначениеПоИмениПодстановкиЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ЗначениеПоПредставлению" Тогда
		Возврат ЗначениеПоПредставлениюЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ЗначениеПоЭтапу" Тогда
		Возврат ЗначениеПоЭтапуЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ПредставленияТитула" Тогда
		Возврат ПредставленияТитулаЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ЭтоДинамическийТитул" Тогда
		Возврат ЭтоДинамическийТитулЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ЭтоПервыйТитул" Тогда
		Возврат ЭтоПервыйТитулЭТрН(Параметр1);
	ИначеЕсли ИмяФункции = "ПервыйТитул" Тогда
		Возврат ПервыйТитулЭТрН();
	ИначеЕсли ИмяФункции = "СформироватьТаблицуДополнения" Тогда
		СформироватьТаблицуДополненияЭТрН(Параметр1, Параметр2, Параметр3);
		Возврат Неопределено;
	ИначеЕсли ИмяФункции = "ПустаяСсылка" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПустаяСсылка");
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

// Возвращает для указанного титула данные титула отказа.
// В качестве параметра данной функции чаще всего используется последний успешный титул по документу,
// который был перед титулом отказа (УведомлениеОУточнении).
//
// Параметры:
//  ТипТитула - ПеречислениеСсылка.Saby_ТипТитулаЭтрН - титул, для которого необходимо получить титул отказа.
//
// Возвращаемое значение:
//   Структура - данные титула отказа:
//     * Тип - ПеречислениеСсылка.Saby_ТипТитулаЭтрН - титул, который был отменен.
//     * Представление - Строка - строковое представление титула отказа, для вывода пользователю.
//
Функция ТитулОтказаЭТрН(ТипТитула) Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("Тип",           ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПустаяСсылка"));
	РезультатФункции.Вставить("Представление", "");
	
	Если ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Погрузка") Тогда
		РезультатФункции.Тип           = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПолучениеГруза");
		РезультатФункции.Представление = "Получение" + Символы.ПС + "Не принят";
		Возврат РезультатФункции;
	ИначеЕсли ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ИзменениеСтоимости") Тогда
		РезультатФункции.Тип           = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.СогласованиеСтоимости");
		РезультатФункции.Представление = "Согласовать стоимость" + Символы.ПС + "Отклонено";
		Возврат РезультатФункции;
	Иначе
		Возврат РезультатФункции;
	КонецЕсли;
	
КонецФункции

// Возвращает соответствующее значение перечисления переданному коду.
//
// Параметры:
//  КодТитула - Строка - строковый код значения. Данный код чаще всего передает онлайн.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ТипТитулаЭтрН - ссылка на перечисление.
//     Если по коду ссылка не найдена, то возвращается пустая ссылка.
//
Функция ЗначениеПоКодуЭТрН(Знач КодТитула) Экспорт
	
	// Основные титулы
	Если КодТитула = "1110339" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Погрузка");
	ИначеЕсли КодТитула = "1110340" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПолучениеГруза");
	ИначеЕсли КодТитула = "1110341" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПриемкаГруза");
	ИначеЕсли КодТитула = "1110342" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ВыдачаГруза");
		
	// Динамические титулы
	ИначеЕсли КодТитула = "1110343" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Переадресовка");
	ИначеЕсли КодТитула = "1167009" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПереадресовкаУведомление");
	ИначеЕсли КодТитула = "1110344" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ЗаменаВодителяТС");
	ИначеЕсли КодТитула = "1110345" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ИзменениеСтоимости");
	ИначеЕсли КодТитула = "1110346" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.СогласованиеСтоимости");
		
	// Отрицательное завершение ДО
	ИначеЕсли КодТитула = "1115113" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.УведомлениеОУточнении");
	Иначе
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПустаяСсылка");
	КонецЕсли;
	
КонецФункции

// Возвращает соответствующее значение перечисления переданному имени подстановки.
//
// Параметры:
//  ИмяПодстановки - Строка - строковый код значения. Данный код чаще всего передает онлайн.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ТипТитулаЭтрН - ссылка на перечисление.
//     Если по коду ссылка не найдена, то возвращается пустая ссылка.
//
Функция ЗначениеПоИмениПодстановкиЭТрН(Знач ИмяПодстановки) Экспорт
	
	ИмяПодстановки = СтрЗаменить(ИмяПодстановки, "ЭТрН_",     "");
	ИмяПодстановки = СтрЗаменить(ИмяПодстановки, "УведУточ_", "");
	
	Возврат ЗначениеПоКодуЭТрН(ИмяПодстановки);
	
КонецФункции

// Возвращает соответствующее значение перечисления переданному представлению.
//
// Параметры:
//  Представление - Строка - строковое представление титула в человекочитаемом формате.
//    Обычно совпадает с синонимом перечисления. Данное представление чаще всего передает онлайн.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ТипТитулаЭтрН - ссылка на перечисление.
//     Если по представлению ссылка не найдена, то возвращается пустая ссылка.
//
Функция ЗначениеПоПредставлениюЭТрН(Представление) Экспорт
	
	// Основные титулы
	Если Представление = "Погрузка" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Погрузка");
	ИначеЕсли Представление = "Получение груза" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПолучениеГруза");
	ИначеЕсли Представление = "Приемка груза" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПриемкаГруза");
	ИначеЕсли Представление = "Выдача груза" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ВыдачаГруза");
		
	// Динамические титулы
	ИначеЕсли Представление = "Переадресовка" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Переадресовка");
	ИначеЕсли Представление = "Замена водителей/ТС" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ЗаменаВодителяТС");
	ИначеЕсли Представление = "Изменение стоимости" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ИзменениеСтоимости");
	ИначеЕсли Представление = "Согласование стоимости" Или Представление = "Согласовать стоимость" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.СогласованиеСтоимости");
	ИначеЕсли Представление = "Уведомление о переадресовке" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПереадресовкаУведомление");
		
	// Отрицательное завершение ДО
	ИначеЕсли Представление = "Уведомление о требовании уточнений" Тогда
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.УведомлениеОУточнении");
		
	Иначе
		Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПустаяСсылка");
	КонецЕсли;
	
КонецФункции

// Возвращает соответствующее значение перечисления переданному этапу.
//
// Параметры:
//  НаименованиеЭтапа - Строка - строковое представление этапа в человекочитаемом формате.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ТипТитулаЭтрН - ссылка на перечисление.
//     Если по представлению ссылка не найдена, то возвращается пустая ссылка.
//
Функция ЗначениеПоЭтапуЭТрН(НаименованиеЭтапа) Экспорт
	
	Возврат ЗначениеПоПредставлениюЭТрН(НаименованиеЭтапа);
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныйПрограммныйИнтерфейс

// Возвращает структуру различных представлений указанной ссылки на тип титула.
// Используется для исключения лишних запросов к базе.
//
// Параметры:
//  СсылкаНаТитул - ПеречислениеСсылка.Saby_ТипТитулаЭтрН - ссылка на титул,
//    для которого необходимо получить представления.
//
// Возвращаемое значение:
//   Структура - структура различных представлений типа титула.
//     Перечень доступных значений см. в функции СтруктураПредставленияТитула
//
Функция ПредставленияТитулаЭТрН(СсылкаНаТитул) Экспорт
	
	// Основные титулы
	Если ЭтоПервыйТитулЭТрН(СсылкаНаТитул) Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("Погрузка", "1110339");
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПолучениеГруза") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("ПолучениеГруза", "1110340");
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПриемкаГруза") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("ПриемкаГруза", "1110341");
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ВыдачаГруза") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("ВыдачаГруза", "1110342");
		
	// Динамические титулы
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Переадресовка") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("Переадресовка", "1110343");
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПереадресовкаУведомление") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("ПереадресовкаУведомление", "1167009");
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ЗаменаВодителяТС") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("ЗаменаВодителяТС", "1110344");
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ИзменениеСтоимости") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("ИзменениеСтоимости", "1110345");
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.СогласованиеСтоимости") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("СогласованиеСтоимости", "1110346");
		
	// Отрицательное завершение ДО
	ИначеЕсли СсылкаНаТитул = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.УведомлениеОУточнении") Тогда
		Возврат СтруктураПредставленияТитулаЭТрН("УведомлениеОУточнении", "1115113", "УведУточ_");
	Иначе
		Возврат СтруктураПредставленияТитулаЭТрН("ПустаяСсылка", "", "");
	КонецЕсли;
	
КонецФункции

// Проверяет является ли титул динамическим.
//
// Параметры:
//  ТипТитула - ПеречислениеСсылка.Saby_ТипТитулаЭтрН - титул для проверки
//
// Возвращаемое значение:
//   Булево - Истина, если динамический.
//
Функция ЭтоДинамическийТитулЭТрН(ТипТитула) Экспорт
	
	РезультатФункции = Ложь;
	
	Если ЗначениеЗаполнено(ТипТитула) Тогда 
		РезультатФункции = ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Переадресовка")
			Или ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ЗаменаВодителяТС")
			Или ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ИзменениеСтоимости")
			Или ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.СогласованиеСтоимости")
			Или ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПереадресовкаУведомление")
			Или ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.УведомлениеОУточнении");
	КонецЕсли;
	
    Возврат РезультатФункции;
	
КонецФункции

// Проверяет является ли титул первым в документообороте
//
// Параметры:
//  ТипТитула - ПеречислениеСсылка.Saby_ТипТитулаЭтрН - титул для проверки
//
// Возвращаемое значение:
//   Булево - Истина, если титул погрузки.
//
Функция ЭтоПервыйТитулЭТрН(ТипТитула) Экспорт
	
	Возврат Не ЗначениеЗаполнено(ТипТитула) Или ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Погрузка");
	
КонецФункции

// Возвращает первый титул в документообороте
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ТипТитулаЭтрН - первый титул
//
Функция ПервыйТитулЭТрН() Экспорт
	
	Возврат ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Погрузка");
	
КонецФункции

// Формирует временную таблицу основных титулов для вывода в ленту
//
// Параметры:
//  МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - менеджер для сохранения таблицы дополнений.
//  ТекущиеЭтапыДокумента - Массив - массив ссылок текущих этапов документа
//  СсылкаНаДокумент - ДокументСсылка.Saby_ПутевойЛист - ссылка на конкретный документ
//
Процедура СформироватьТаблицуДополненияЭТрН(МенеджерВременныхТаблиц, ТекущиеЭтапыДокумента, СсылкаНаДокумент) Экспорт
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 1) КАК Период,
	|	&Погрузка КАК ТипТитула,
	|	"""" КАК ИдентификаторТитула,
	|	ИСТИНА КАК Основной,
	|	"""" КАК Данные,
	|	&ПустаяСсылка КАК ТипТитулаОтказа,
	|	1 КАК ТипТитулаПорядок,
	|	&Погрузка В (&ТекущиеЭтапыДокумента) КАК ЭтоТекущийЭтап
	|ПОМЕСТИТЬ ТаблицаДополнения
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 2),
	|	&ПолучениеГруза,
	|	"""",
	|	ИСТИНА,
	|	"""",
	|	&ПустаяСсылка,
	|	2,
	|	&ПолучениеГруза В (&ТекущиеЭтапыДокумента)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 3),
	|	&ПриемкаГруза,
	|	"""",
	|	ИСТИНА,
	|	"""",
	|	&ПустаяСсылка,
	|	3,
	|	&ПриемкаГруза В (&ТекущиеЭтапыДокумента)
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 4),
	|	&ВыдачаГруза,
	|	"""",
	|	ИСТИНА,
	|	"""",
	|	&ПустаяСсылка,
	|	4,
	|	&ВыдачаГруза В (&ТекущиеЭтапыДокумента)";
	
	ДополнитьТекстЗапросаТекущимиЭтапамиЭТрН(ЗапросДанных, ТекущиеЭтапыДокумента);
	
	ЗапросДанных.УстановитьПараметр("ТекущаяДата",           ТекущаяДатаСеанса());
	ЗапросДанных.УстановитьПараметр("ТекущиеЭтапыДокумента", ТекущиеЭтапыДокумента);
	
	ЗапросДанных.УстановитьПараметр("Погрузка",       ЗначениеМетаданных("Saby_ТипТитулаЭтрН.Погрузка"));
	ЗапросДанных.УстановитьПараметр("ПолучениеГруза", ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПолучениеГруза"));
	ЗапросДанных.УстановитьПараметр("ПриемкаГруза",   ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПриемкаГруза"));
	ЗапросДанных.УстановитьПараметр("ВыдачаГруза",    ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ВыдачаГруза"));
	ЗапросДанных.УстановитьПараметр("ПустаяСсылка",   ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПустаяСсылка"));
	
	ЗапросДанных.Выполнить();
	
КонецПроцедуры

#КонецОбласти // СлужебныйПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

Функция СтруктураПредставленияТитулаЭТрН(ИмяТитула, КодТитула, ПрефиксПодстановки = "ЭТрН_")
	
	ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН." + ИмяТитула);
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("КодТитула",      КодТитула);
	РезультатФункции.Вставить("ИмяПодстановки", ПрефиксПодстановки + КодТитула);	
	
	РезультатФункции.Вставить("Имя",           ИмяТитула);
	РезультатФункции.Вставить("Представление", "");
	Если ИмяТитула = "Погрузка" Тогда
		РезультатФункции.Представление = "Погрузка";
	ИначеЕсли ИмяТитула = "ПолучениеГруза" Тогда
		РезультатФункции.Представление = "Получение груза";
	ИначеЕсли ИмяТитула = "ПриемкаГруза" Тогда
		РезультатФункции.Представление = "Приемка груза";
	ИначеЕсли ИмяТитула = "ВыдачаГруза" Тогда
		РезультатФункции.Представление = "Выдача груза";
	ИначеЕсли ИмяТитула = "Переадресовка" Тогда
		РезультатФункции.Представление = "Переадресовка";
	ИначеЕсли ИмяТитула = "ЗаменаВодителяТС" Тогда
		РезультатФункции.Представление = "Замена водителей/ТС";
	ИначеЕсли ИмяТитула = "ИзменениеСтоимости" Тогда
		РезультатФункции.Представление = "Изменение стоимости";
	ИначеЕсли ИмяТитула = "СогласованиеСтоимости" Тогда
		РезультатФункции.Представление = "Согласование стоимости";
	ИначеЕсли ИмяТитула = "ПереадресовкаУведомление" Тогда
		РезультатФункции.Представление = "Уведомление о переадресовке";
	ИначеЕсли ИмяТитула = "УведомлениеОУточнении" Тогда
		РезультатФункции.Представление = "Уведомление о уточнении";
	Иначе
		РезультатФункции.Имя           = "";
		РезультатФункции.Представление = "";
	КонецЕсли;
	
	РезультатФункции.Вставить("НазваниеСобытияОтрицательногоПерехода", НазваниеСобытияОтрицательногоПереходаЭТрН(ТипТитула));
	
	Возврат РезультатФункции;
	
КонецФункции

Функция НазваниеСобытияОтрицательногоПереходаЭТрН(ТипТитула)
	
	Если ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПриемкаГруза") Тогда
		РезультатФункции = "Приемка груза.Не принят";
	ИначеЕсли ТипТитула = ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ВыдачаГруза") Тогда
		РезультатФункции = "Выдача груза.Не выдан";
	Иначе
		РезультатФункции = "";
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

Процедура ДополнитьТекстЗапросаТекущимиЭтапамиЭТрН(ЗапросДанных, ТекущиеЭтапыДокумента)
	
	МассивЗапросов = Новый Массив;
	
	Для Индекс = 0 По ТекущиеЭтапыДокумента.ВГраница() Цикл
		ТекущийЭтап = ТекущиеЭтапыДокумента[Индекс];
		Если Не ЭтоДинамическийТитулЭТрН(ТекущийЭтап) Тогда
			Продолжить;
		КонецЕсли;
		
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 1) КАК Период,
		|	&ТипТитула КАК ТипТитула,
		|	"""" КАК ИдентификаторТитула,
		|	ЛОЖЬ КАК Основной,
		|	"""" КАК Данные,
		|	&ПустаяСсылка КАК ТипТитулаОтказа,
		|	1 КАК ТипТитулаПорядок,
		|	ИСТИНА КАК ЭтоТекущийЭтап";
		
		ИмяПараметраТипТитула = "ТипТитула" + Формат(Индекс, "ЧДЦ=0; ЧН=0; ЧГ=");
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТипТитула", "&" + ИмяПараметраТипТитула);
		ЗапросДанных.УстановитьПараметр(ИмяПараметраТипТитула, ТекущийЭтап);
		
		МассивЗапросов.Добавить(ТекстЗапроса);
		
	КонецЦикла;
	
	ЗапросДанных.УстановитьПараметр("ПустаяСсылка", ЗначениеМетаданных("Saby_ТипТитулаЭтрН.ПустаяСсылка"));
	
	Если МассивЗапросов.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	РазделительЗапросов = "
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|";
	
	МассивЗапросов.Вставить(0, ЗапросДанных.Текст);
	
	ЗапросДанных.Текст = СтрСоединить(МассивЗапросов, РазделительЗапросов);
	
КонецПроцедуры

#КонецОбласти // СлужебныеПроцедурыИФункции

#Область include_etrn_base_CommonModule_ЗначениеМетаданных
#КонецОбласти // include_etrn_base_CommonModule_ЗначениеМетаданных
