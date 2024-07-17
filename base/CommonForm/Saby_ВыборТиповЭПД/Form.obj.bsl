
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.СсылкаНаВладельца = Параметры.Ссылка;
	ЭтаФорма.ИмяДокумента      = Saby_ТНОбщегоНазначенияСервер.ИмяМетаданныхДокумента(ЭтаФорма.СсылкаНаВладельца);
	
	УстановитьЗаголовокФормы();
		
	ЗаполнитьТаблицуМетаданных();
	
	УстановитьВариантОтбораПоУмолчанию();
	
	УстановитьОтбор();
	
КонецПроцедуры

&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	Если ЗавершениеРаботы Тогда
		Возврат;
	КонецЕсли;
	
	Если Не ЭтаФорма.Модифицированность Тогда
		Возврат;
	КонецЕсли;
	
	СтандартнаяОбработка = Ложь;
	Отказ = Истина;
	
	ПроцедураЗакрытьФорму = Новый ОписаниеОповещения("ЗакрытьФорму", ЭтотОбъект);
	
	Saby_ТНОбщегоНазначенияКлиент.ПроверитьМодифицированностьИПродолжитьВыполнение(ПроцедураЗакрытьФорму);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ВариантОтбораПриИзменении(Элемент)
	
	УстановитьОтбор();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийЭлементовШапкиФормы

#Область ОбработчикиСобытийЭлементовТаблицыФормыТаблицаМетаданных

&НаКлиенте
Процедура ТаблицаМетаданныхПометкаПриИзменении(Элемент)
	
	ЭтаФорма.Модифицированность = Истина;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ПроцедураЗакрытьФорму = Новый ОписаниеОповещения("ЗакрытьФорму", ЭтотОбъект);
	
	Saby_ТНОбщегоНазначенияКлиент.ПроверитьМодифицированностьИПродолжитьВыполнение(ПроцедураЗакрытьФорму, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНастройкиПоУмолчанию(Команда)
	
	УстановитьНастройкиПоУмолчаниюНаСервере();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьВсе(Команда)
	
	ИзменитьПометки(Истина);
		
КонецПроцедуры

&НаКлиенте
Процедура СнятьВсе(Команда)
	
	ИзменитьПометки(Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьОтбор(Команда)
	
	УстановитьОтбор();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура Записать() Экспорт
	
	СохранитьИзменения();
	
	ЭтаФорма.Модифицированность = Ложь;
	
	Оповестить("Saby_ИзмененыТипыДокументовОснований", Неопределено, ВладелецФормы);
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьТаблицуМетаданных()
		
	ЭтаФорма.ТаблицаМетаданных.Очистить();
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(
	"<TypeDescription xmlns=""http://v8.1c.ru/8.1/data/core"">
	|      <TypeSet xmlns:cc=""http://v8.1c.ru/8.1/data/enterprise/current-config"">cc:DocumentRef</TypeSet>
	|</TypeDescription>");
	Результат = СериализаторXDTO.ПрочитатьXML(ЧтениеXML);
	
	ОтмеченныеТипы = ОтмеченныеПользователемТипы();
	
	Для Каждого Тип Из Результат.Типы() Цикл
		СтрокаТаблицы = ЭтаФорма.ТаблицаМетаданных.Добавить();
		СтрокаТаблицы.Пометка = ОтмеченныеТипы.Получить(Тип) <> Неопределено;
		СтрокаТаблицы.Тип     = Тип; 
		СтрокаТаблицы.ИмяТипа = СокрЛП(Тип); 
	КонецЦикла;
	
	// таблица была отсортирована по УИД типов
	ЭтаФорма.ТаблицаМетаданных.Сортировать("ИмяТипа");
	
КонецПроцедуры

&НаСервере
Функция ОтмеченныеПользователемТипы(ЗначенияПоУмолчанию = Ложь)
	
	РезультатФункции = Новый Соответствие;
					
	МассивТипов = Документы[ЭтаФорма.ИмяДокумента].ТипыДляЗаполненияНаОсновании(ЗначенияПоУмолчанию);
			
	Если ЗначениеЗаполнено(МассивТипов) Тогда
		
		Для Каждого Тип Из МассивТипов Цикл
			РезультатФункции.Вставить(Тип, Истина);
		КонецЦикла;
		
	Иначе 
		ТекстСообщения = "Для вашей конфигурации нет настроек по умолчанию. Воспользуйтесь ручной настройкой";		
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЕсли;
		
	Возврат РезультатФункции;
	
КонецФункции

&НаСервере
Процедура УстановитьОтбор()
	
	Если ВариантОтбора = 0 Тогда
		ОтборСтрок = Новый ФиксированнаяСтруктура("Пометка", Истина);
	Иначе
		ОтборСтрок = Неопределено;
	КонецЕсли;
	
	Элементы.ТаблицаМетаданных.ОтборСтрок = ОтборСтрок;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗакрытьФорму(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат = КодВозвратаДиалога.Нет Тогда
		ЭтаФорма.Модифицированность = Ложь;
	КонецЕсли;
	
	Если Результат <> КодВозвратаДиалога.Отмена Тогда
		Закрыть();
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура СохранитьИзменения()
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Пометка", Истина);
	
	МассивТипов = Новый Массив;
	
	НайденныеСтроки = ТаблицаМетаданных.НайтиСтроки(СтруктураПоиска);
	Для Каждого НайденнаяСтрока Из НайденныеСтроки Цикл
		МассивТипов.Добавить(НайденнаяСтрока.Тип);
	КонецЦикла;
	
	Документы[ЭтаФорма.ИмяДокумента].СохранитьВыбранныеТипыДляЗаполненияНаОсновании(МассивТипов);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьНастройкиПоУмолчаниюНаСервере()
	
	ОтмеченныеТипы = ОтмеченныеПользователемТипы(Истина);
	
	Для Каждого СтрокаТаблицы Из ТаблицаМетаданных Цикл
		СтрокаТаблицы.Пометка = ОтмеченныеТипы.Получить(СтрокаТаблицы.Тип) <> Неопределено;
	КонецЦикла;
	
	УстановитьОтбор();
	
КонецПроцедуры

&НаКлиенте
Процедура ИзменитьПометки(Пометка)
	
	ЭтаФорма.Модифицированность = Истина;
	
	Для Каждого СтрокаТаблицы Из ТаблицаМетаданных Цикл
		СтрокаТаблицы.Пометка = Пометка;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВариантОтбораПоУмолчанию()
	
	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("Пометка", Истина);
	
	НайденныеСтроки = ТаблицаМетаданных.НайтиСтроки(СтруктураПоиска);
	Если НайденныеСтроки.Количество() > 0 Тогда
		ЭтаФорма.ВариантОтбора = 0; // отбор выбранных
	Иначе
		ЭтаФорма.ВариантОтбора = 1; // без отбора
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьЗаголовокФормы()
		
	ИмяДокументаСтрокой = СтрЗаменить(ЭтаФорма.ИмяДокумента, "Saby_", "");	
	ЭтаФорма.Заголовок  = СтрЗаменить(ЭтаФорма.Заголовок, "<ИмяДокумента>", ИмяДокументаСтрокой);
	
КонецПроцедуры

#КонецОбласти // СлужебныеПроцедурыИФункции
