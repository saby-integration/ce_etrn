
//DynamicDirective

// Установка основного телефона
// Параметры:
// 	Форма - ФормаКлиентскогоПриложения - источник вызова	
//	СтрокаЮрЛица - ДанныеФормы - строка таблицы  
//	СтрокаТелефона - ДанныеФормы - строка таблицы
//
Процедура ЗаполнитьПолеОсновногоТелефона(Форма, СтрокаЮрЛица, СтрокаТелефона)
	
	ПараметрыРеквизитаФормы = СтрокаЮрЛица.ПараметрыРеквизитаФормы;
	
	Если ПараметрыРеквизитаФормы.ЭтоСтрокаТаблицы Тогда
		
		ЗаполнитьКолонкуОсновногоТелефонаВСтроке(Форма, ПараметрыРеквизитаФормы, СтрокаТелефона);
		
	ИначеЕсли СтрокаТелефона <> Неопределено И СтрокаТелефона.Основной Тогда
		
		Форма[СтрокаЮрЛица.ПолеОсновногоТелефона] = СтрокаТелефона.Значение;
		
	ИначеЕсли СтрокаТелефона = Неопределено Тогда
			
		Форма[СтрокаЮрЛица.ПолеОсновногоТелефона] = "";
	
	Иначе
		Возврат;
	КонецЕсли;
		
КонецПроцедуры

//DynamicDirective

// Проверка что строка должна стать основной
// Параметры:
// 	РезультатФункции - Структура - данные для установки 
//	ДопПараметры - Структура - дополнительные параметры
//
// Возвращаемое значение:
//	Булево - результат проверки
//
Функция ЭтаСтрокаДолжнаБытьОсновной(РезультатФункции, ДопПараметры)
	
	Возврат ДопПараметры.Значение = Неопределено И РезультатФункции.СтрокаТелефона = Неопределено;
	
КонецФункции

//DynamicDirective

Процедура ЗаполнитьКолонкуОсновногоТелефонаВСтроке(Форма, ПараметрыРеквизитаФормы, СтрокаТелефона)
		
	ФормаОбъект = ФормаОбъект(Форма);
	СтрокаДанныхЮрЛица = ФормаОбъект.ДанныеЮрЛиц.НайтиПоИдентификатору(ПараметрыРеквизитаФормы.ИдентификаторСтроки);
	
	Если СтрокаДанныхЮрЛица = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	Если СтрокаТелефона <> Неопределено И СтрокаТелефона.Основной Тогда
		
		СтрокаДанныхЮрЛица.Телефон = СтрокаТелефона.Значение;
		
	ИначеЕсли СтрокаТелефона = Неопределено Тогда				
		
		СтрокаДанныхЮрЛица.Телефон = "";			
		
	Иначе
		Возврат;
	КонецЕсли;
			
КонецПроцедуры

//DynamicDirective

Процедура ОбновитьАдресаОтправителяПолучателя(Форма, ФормаОбъект, ДопПараметры)
	
	ТаблицаЮрЛиц = ДопПараметры.ТаблицаЮрЛиц;
	Если ТаблицаЮрЛиц = Неопределено Тогда
		ТаблицаЮрЛиц = ТаблицаЮрЛиц(Форма, ДопПараметры.Роли, ФормаОбъект);
	КонецЕсли;
	
	Роли = МассивРолей(ДопПараметры.Роли);
	Если Роли.Количество() Тогда 
		Роль        = Роли[0].Роль;
		РольСтрокой = Роли[0].РольСтрокой;
	Иначе
		Возврат;
	КонецЕсли;
	
	ДанныеКИ = ДопПараметры.Значение;
	
	// ДТ и основные титулы отличаются
	Если ДанныеКИ = Неопределено Тогда 
	    ДанныеКИ = НайтиСтрокуЮрЛиц(ТаблицаЮрЛиц, Роль, "Роль");
	КонецЕсли;	
		
	Если ДанныеКИ <> Неопределено Тогда
		
		Если ТипЗнч(ДанныеКИ) = Тип("Структура") Тогда
			
			Адрес    = ДанныеКИ.Представление;
			Значение = ДанныеКИ.КонтактнаяИнформация;
						
		Иначе 
			
			Адрес    = ДанныеКИ.Адрес;
			Значение = ДанныеКИ.АдресСтруктура;
			
		КонецЕсли;	
		
		Если РольСтрокой = "Отправитель" 
			И ЕстьРеквизитИлиСвойство(ФормаОбъект, "Погрузка_Адрес") Тогда
			
			ФормаОбъект.Погрузка_Адрес        = Адрес;
			ФормаОбъект.АдресПогрузкиЗначение = Значение;
			
		ИначеЕсли РольСтрокой = "Получатель" 
			И ЕстьРеквизитИлиСвойство(ФормаОбъект, "Отправитель_АдресДоставки") Тогда
			
			ФормаОбъект.Отправитель_АдресДоставки = Адрес;
			ФормаОбъект.АдресДоставкиЗначение     = Значение;
			
		Иначе 
			Возврат;			
		КонецЕсли;
		
	КонецЕсли;
	
КонецПроцедуры

//DynamicDirective

// Параметры КИ по заданному отбору
// Параметры:
//	ФормаОбъект - ФормаКлиентскогоПриложения - источник вызова
//	ДопПараметры - Структура - дополнительные параметры 
//	СтруктураПоиска - Структура - отбор для поиска строк
//
// Возвращаемое значение:
//	Структура - структура, с данными строки телефона и наличия основного номера
//
Функция ПараметрыНайденныхСтрок(ФормаОбъект, ДопПараметры, СтруктураПоиска)
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("СтрокаТелефона",      Неопределено);
	РезультатФункции.Вставить("ЕстьОсновнойТелефон", Ложь);
	
	НайденныеСтроки = ФормаОбъект.КонтактныеДанные.НайтиСтроки(СтруктураПоиска);
	Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
		
		РезультатФункции.ЕстьОсновнойТелефон = РезультатФункции.ЕстьОсновнойТелефон Или НайденнаяСтрока.Основной;
		
		Если ДопПараметры.Значение <> Неопределено Тогда
			Если ИдентификаторыСтрокСовпадают(НайденнаяСтрока, ДопПараметры) Тогда
				РезультатФункции.СтрокаТелефона = НайденнаяСтрока;
				РезультатФункции.СтрокаТелефона.Значение = ДопПараметры.Значение.Представление;
				РезультатФункции.СтрокаТелефона.Структура = ДопПараметры.Значение.Значение;
			ИначеЕсли НайденнаяСтрока.Значение = ДопПараметры.Значение.Представление Тогда
				РезультатФункции.СтрокаТелефона = НайденнаяСтрока;
			Иначе
				Продолжить;
			КонецЕсли;
		ИначеЕсли ЭтаСтрокаДолжнаБытьОсновной(РезультатФункции, ДопПараметры) Тогда
			РезультатФункции.СтрокаТелефона = НайденнаяСтрока;
			НайденнаяСтрока.Основной = Истина;
		Иначе
			Продолжить;
		КонецЕсли;
				
	КонецЦикла;
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

Процедура ДозаполнитьКонтактныеДанные(ИменаПеречисления, СтруктураКонтактныхДанных)
	
	Если ТипЗнч(СтруктураКонтактныхДанных.Тип) = Тип("Строка") Тогда 
		СтруктураКонтактныхДанных.Тип = ИменаПеречисления[СтруктураКонтактныхДанных.Тип];
	КонецЕсли;
	
КонецПроцедуры

//DynamicDirective

// Возвращает структуру найденных контактных данных по виду или массив найденных контактных данных
//
// Параметры:
//  ТаблицаКИ - Массив - см. Saby_ТНОбщегоНазначенияСервер.КонтактнаяИнформацияИзБазы
//  Ссылка - ЛюбаяСсылка - ссылка на владельца контактной информации
//  Вид - СправочникСсылка.ВидыКонтактнойИнформации - вид контактной информации
//  ПервоеЗначение - Булево - признак возврата одного значения или массива
//
// Возвращаемое значение:
//   Структура,Массив - см. СтруктураКИ 
//
Функция ПолучитьКИ(ТаблицаКИ, Ссылка, Вид, ПервоеЗначение = Истина) Экспорт
	
	Отбор = Новый Структура("Ссылка,Вид", Ссылка, Вид);
	
	НайденныеСтроки = НайтиСтрокиУниверсально(ТаблицаКИ, Отбор);
	
	Если ПервоеЗначение Тогда
		
		РезультатФункции = СтруктураКИ(Ссылка, Вид);
		Если НайденныеСтроки.Количество() > 0 Тогда
			ЗаполнитьЗначенияСвойств(РезультатФункции, НайденныеСтроки[0]);
		КонецЕсли;
		
	Иначе
		
		РезультатФункции = Новый Массив;
		
		Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
			СтруктураКИ = СтруктураКИ(Ссылка, Вид);
			ЗаполнитьЗначенияСвойств(СтруктураКИ, НайденнаяСтрока);
			РезультатФункции.Добавить(СтруктураКИ);
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

// Возвращает данные конактной информации
//
// Параметры:
//  Ссылка - ЛюбаяСсылка - ссылка на владельца контактной информации
//  Вид - СправочникСсылка.ВидыКонтактнойИнформации - вид контактной информации
//
// Возвращаемое значение:
//   Структура - см. в самой функции
//
Функция СтруктураКИ(Ссылка, Вид) Экспорт
	
	ПустойТип = ЗначениеМетаданных("ТипыКонтактнойИнформации.ПустаяСсылка");
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("Ссылка",        Ссылка);
	РезультатФункции.Вставить("Вид",           Вид);
	РезультатФункции.Вставить("Тип",           ПустойТип);
	РезультатФункции.Вставить("Значение",      "");
	РезультатФункции.Вставить("Представление", "");
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective
// Проверка совпадения идентификаторов разных объектов
// Параметры:
// 	НайденнаяСтрока - ДанныеФормы - строка для сравнения
//	ДопПараметры - Структура - доп параметры для сравнения, в том числе идентификатор
//
// Возвращаемое значение:
//  Булево - результат сравнения
//
Функция ИдентификаторыСтрокСовпадают(НайденнаяСтрока, ДопПараметры)
	
	ИдентификаторСтроки = НайденнаяСтрока.ПолучитьИдентификатор();
	Возврат ДопПараметры.ИдентификаторСтроки <> Неопределено И ИдентификаторСтроки = ДопПараметры.ИдентификаторСтроки;
	
КонецФункции

