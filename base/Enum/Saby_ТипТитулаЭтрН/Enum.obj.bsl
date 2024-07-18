
#Область ПрограммныйИнтерфейс

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
Функция ТитулОтказа(ТипТитула) Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("Тип",           ПустаяСсылка());
	РезультатФункции.Вставить("Представление", "");
	
	Если ТипТитула = Погрузка Тогда
		РезультатФункции.Тип           = ПолучениеГруза;
		РезультатФункции.Представление = "Получение" + Символы.ПС + "Не принят";
		Возврат РезультатФункции;
	ИначеЕсли ТипТитула = ИзменениеСтоимости Тогда
		РезультатФункции.Тип           = СогласованиеСтоимости;
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
Функция ЗначениеПоКоду(Знач КодТитула) Экспорт
	
	// Основные титулы
	Если КодТитула = "1110339" Тогда
		Возврат Погрузка;
	ИначеЕсли КодТитула = "1110340" Тогда
		Возврат ПолучениеГруза;
	ИначеЕсли КодТитула = "1110341" Тогда
		Возврат ПриемкаГруза;
	ИначеЕсли КодТитула = "1110342" Тогда
		Возврат ВыдачаГруза;
		
	// Динамические титулы
	ИначеЕсли КодТитула = "1110343" Тогда
		Возврат Переадресовка;
	ИначеЕсли КодТитула = "1167009" Тогда
		Возврат ПереадресовкаУведомление;
	ИначеЕсли КодТитула = "1110344" Тогда
		Возврат ЗаменаВодителяТС;
	ИначеЕсли КодТитула = "1110345" Тогда
		Возврат ИзменениеСтоимости;
	ИначеЕсли КодТитула = "1110346" Тогда
		Возврат СогласованиеСтоимости;
		
	// Отрицательное завершение ДО
	ИначеЕсли КодТитула = "1115113" Тогда
		Возврат УведомлениеОУточнении;
	Иначе
		Возврат ПустаяСсылка();
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
Функция ЗначениеПоИмениПодстановки(Знач ИмяПодстановки) Экспорт
	
	ИмяПодстановки = СтрЗаменить(ИмяПодстановки, "ЭТрН_",     "");
	ИмяПодстановки = СтрЗаменить(ИмяПодстановки, "УведУточ_", "");
	
	Возврат ЗначениеПоКоду(ИмяПодстановки);
	
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
Функция ЗначениеПоПредставлению(Представление) Экспорт
	
	// Основные титулы
	Если Представление = "Погрузка" Тогда
		Возврат Погрузка;
	ИначеЕсли Представление = "Получение груза" Тогда
		Возврат ПолучениеГруза;
	ИначеЕсли Представление = "Приемка груза" Тогда
		Возврат ПриемкаГруза;
	ИначеЕсли Представление = "Выдача груза" Тогда
		Возврат ВыдачаГруза;
		
	// Динамические титулы
	ИначеЕсли Представление = "Переадресовка" Тогда
		Возврат Переадресовка;
	ИначеЕсли Представление = "Замена водителей/ТС" Тогда
		Возврат ЗаменаВодителяТС;
	ИначеЕсли Представление = "Изменение стоимости" Тогда
		Возврат ИзменениеСтоимости;
	ИначеЕсли Представление = "Согласование стоимости" Или Представление = "Согласовать стоимость" Тогда
		Возврат СогласованиеСтоимости;
	ИначеЕсли Представление = "Уведомление о переадресовке" Тогда
		Возврат ПереадресовкаУведомление;
		
	// Отрицательное завершение ДО
	ИначеЕсли Представление = "Уведомление о требовании уточнений" Тогда
		Возврат УведомлениеОУточнении;
		
	Иначе
		Возврат ПустаяСсылка();
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
Функция ЗначениеПоЭтапу(НаименованиеЭтапа) Экспорт
	
	Возврат ЗначениеПоПредставлению(НаименованиеЭтапа);
	
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
Функция ПредставленияТитула(СсылкаНаТитул) Экспорт
	
	// Основные титулы
	Если Не ЗначениеЗаполнено(СсылкаНаТитул) Или СсылкаНаТитул = Погрузка Тогда
		Возврат СтруктураПредставленияТитула(Погрузка, "1110339");
	ИначеЕсли СсылкаНаТитул = ПолучениеГруза Тогда
		Возврат СтруктураПредставленияТитула(ПолучениеГруза, "1110340");
	ИначеЕсли СсылкаНаТитул = ПриемкаГруза Тогда
		Возврат СтруктураПредставленияТитула(ПриемкаГруза, "1110341");
	ИначеЕсли СсылкаНаТитул = ВыдачаГруза Тогда
		Возврат СтруктураПредставленияТитула(ВыдачаГруза, "1110342");
		
	// Динамические титулы
	ИначеЕсли СсылкаНаТитул = Переадресовка Тогда
		Возврат СтруктураПредставленияТитула(Переадресовка, "1110343");
	ИначеЕсли СсылкаНаТитул = ПереадресовкаУведомление Тогда
		Возврат СтруктураПредставленияТитула(ПереадресовкаУведомление, "1167009");
	ИначеЕсли СсылкаНаТитул = ЗаменаВодителяТС Тогда
		Возврат СтруктураПредставленияТитула(ЗаменаВодителяТС, "1110344");
	ИначеЕсли СсылкаНаТитул = ИзменениеСтоимости Тогда
		Возврат СтруктураПредставленияТитула(ИзменениеСтоимости, "1110345");
	ИначеЕсли СсылкаНаТитул = СогласованиеСтоимости Тогда
		Возврат СтруктураПредставленияТитула(СогласованиеСтоимости, "1110346");
		
	// Отрицательное завершение ДО
	ИначеЕсли СсылкаНаТитул = УведомлениеОУточнении Тогда
		Возврат СтруктураПредставленияТитула(УведомлениеОУточнении, "1115113", "УведУточ_");
	Иначе
		Возврат СтруктураПредставленияТитула(ПустаяСсылка(), "", "");
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
Функция ЭтоДинамическийТитул(ТипТитула) Экспорт
	
	РезультатФункции = Ложь;
	
	Если ЗначениеЗаполнено(ТипТитула) Тогда 
		РезультатФункции = ТипТитула = Переадресовка
			Или ТипТитула = ЗаменаВодителяТС
			Или ТипТитула = ИзменениеСтоимости
			Или ТипТитула = СогласованиеСтоимости
			Или ТипТитула = ПереадресовкаУведомление
			Или ТипТитула = УведомлениеОУточнении;
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
Функция ЭтоПервыйТитул(ТипТитула) Экспорт
	
	Возврат Не ЗначениеЗаполнено(ТипТитула) Или ТипТитула = Погрузка;
	
КонецФункции

// Возвращает первый титул в документообороте
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ТипТитулаЭтрН - первый титул
//
Функция ПервыйТитул() Экспорт
	
	Возврат Погрузка;
	
КонецФункции

// Формирует временную таблицу основных титулов для вывода в ленту
//
// Параметры:
//  МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - менеджер для сохранения таблицы дополнений.
//  ТекущиеЭтапыДокумента - Массив - массив ссылок текущих этапов документа
//
Процедура СформироватьТаблицуДополнения(МенеджерВременныхТаблиц, ТекущиеЭтапыДокумента) Экспорт
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 1) КАК Период,
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.Погрузка) КАК ТипТитула,
	|	"""" КАК ИдентификаторТитула,
	|	ИСТИНА КАК Основной,
	|	"""" КАК Данные,
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ПустаяСсылка) КАК ТипТитулаОтказа,
	|	1 КАК ТипТитулаПорядок
	|ПОМЕСТИТЬ ТаблицаДополнения
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 2),
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ПолучениеГруза),
	|	"""",
	|	ИСТИНА,
	|	"""",
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ПустаяСсылка),
	|	2
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 3),
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ПриемкаГруза),
	|	"""",
	|	ИСТИНА,
	|	"""",
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ПустаяСсылка),
	|	3
	|
	|ОБЪЕДИНИТЬ ВСЕ
	|
	|ВЫБРАТЬ
	|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 4),
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ВыдачаГруза),
	|	"""",
	|	ИСТИНА,
	|	"""",
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ПустаяСсылка),
	|	4";
	
	ДополнитьТекстЗапросаТекущимиЭтапами(ЗапросДанных, ТекущиеЭтапыДокумента);
	
	ЗапросДанных.УстановитьПараметр("ТекущаяДата", ТекущаяДатаСеанса());
	
	ЗапросДанных.Выполнить();
	
КонецПроцедуры

#КонецОбласти // СлужебныйПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

Функция СтруктураПредставленияТитула(ТипТитула, КодТитула, ПрефиксПодстановки = "ЭТрН_")
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("КодТитула",      КодТитула);
	РезультатФункции.Вставить("ИмяПодстановки", ПрефиксПодстановки + КодТитула);
	
	Имя           = "";
	Представление = "";
	Если Не ТипТитула.Пустая() Тогда
		ИндексТипа = Индекс(ТипТитула);
		МетаданныеПеречисления = ТипТитула.Метаданные().ЗначенияПеречисления[ИндексТипа];
		Имя           = МетаданныеПеречисления.Имя;
		Представление = МетаданныеПеречисления.Синоним;
	КонецЕсли;
	
	РезультатФункции.Вставить("Имя",           Имя);
	РезультатФункции.Вставить("Представление", Представление);
	
	Возврат РезультатФункции;
	
КонецФункции

Процедура ДополнитьТекстЗапросаТекущимиЭтапами(ЗапросДанных, ТекущиеЭтапыДокумента)
	
	МассивЗапросов = Новый Массив;
	
	Для Индекс = 0 По ТекущиеЭтапыДокумента.ВГраница() Цикл
		ТекущийЭтап = ТекущиеЭтапыДокумента[Индекс];
		Если Не ЭтоДинамическийТитул(ТекущийЭтап) Тогда
			Продолжить;
		КонецЕсли;
		
		ТекстЗапроса = 
		"ВЫБРАТЬ
		|	ДОБАВИТЬКДАТЕ(&ТекущаяДата, МЕСЯЦ, 1) КАК Период,
		|	&ТипТитула КАК ТипТитула,
		|	"""" КАК ИдентификаторТитула,
		|	ЛОЖЬ КАК Основной,
		|	"""" КАК Данные,
		|	ЗНАЧЕНИЕ(Перечисление.Saby_ТипТитулаЭтрН.ПустаяСсылка) КАК ТипТитулаОтказа,
		|	1 КАК ТипТитулаПорядок";
		
		ИмяПараметраТипТитула = "ТипТитула" + Формат(Индекс, "ЧДЦ=0; ЧН=0; ЧГ=");
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "&ТипТитула", "&" + ИмяПараметраТипТитула);
		ЗапросДанных.УстановитьПараметр(ИмяПараметраТипТитула, ТекущийЭтап);
		
		МассивЗапросов.Добавить(ТекстЗапроса);
		
	КонецЦикла;
	
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
