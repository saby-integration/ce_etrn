
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.ХранитьПечатнуюФормуТранспортнойНакладнойВБД = Константы.Saby_ХранитьПечатныеФормыВБД.Получить();
	
	ОбновитьВидимостьИДоступностьЭлементов();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ХранитьПечатнуюФормуТранспортнойНакладнойВБДПриИзменении(Элемент)
	
	ХранитьПечатнуюФормуТранспортнойНакладнойВБДПриИзмененииНаСервере(ХранитьПечатнуюФормуТранспортнойНакладнойВБД);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийЭлементовШапкиФормы

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура НастройкиДокументовОснований(Команда)
	
	ТекущаяКнопка = ЭтаФорма.ТекущийЭлемент;
	
	НастройкаВсехДокументовОснований(ТекущаяКнопка.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкиРегламентныхЗаданий(Команда)
	
	СсылкаНаВнешнююОбработкуСРегламентами = СсылкаНаВнешнююОбработкуСРегламентами();
	
	Если ТипЗнч(СсылкаНаВнешнююОбработкуСРегламентами) = Тип("Строка") Тогда
		
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = СсылкаНаВнешнююОбработкуСРегламентами;
		Сообщение.Сообщить();
		
	ИначеЕсли ЗначениеЗаполнено(СсылкаНаВнешнююОбработкуСРегламентами) Тогда
		
		ПараметрыФормы = Новый Структура;
		ПараметрыФормы.Вставить("Ключ", СсылкаНаВнешнююОбработкуСРегламентами);
		
		ОткрытьФорму("Справочник.ДополнительныеОтчетыИОбработки.ФормаОбъекта", ПараметрыФормы, ЭтотОбъект);
		
	Иначе
		
		ПроцедураПослеВопросаОДобавленииОбработки = Новый ОписаниеОповещения(
			"ПослеВопросаОДобавленииОбработки", ЭтотОбъект);
		
		ПоказатьВопрос(
			ПроцедураПослеВопросаОДобавленииОбработки,
			"Добавить обработку регламентных заданий сейчас?",
			РежимДиалогаВопрос.ДаНет,
			120,
			КодВозвратаДиалога.Нет,
			"Внешняя обработка не найдена.",
			КодВозвратаДиалога.Нет);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура НастройкаВыгрузки(Команда)
	НастройкиРасписанияРегламентногоЗадания(Команда.Имя);
КонецПроцедуры

&НаКлиенте
Процедура НастройкаЗагрузки(Команда)
	НастройкиРасписанияРегламентногоЗадания(Команда.Имя);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанныеНа236200(Команда)
	
	Результат = ОбновитьДанныеНа236200НаСервере();
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = ?(Не Результат.ОК, Результат.ОписаниеОшибки, "Обновление данных на версию 23.6200 выполнен успешно");
	Сообщение.Сообщить();
	
КонецПроцедуры

&НаКлиенте
Процедура АктивностьРегламентногоЗадания(Команда)
	
	ЭтоЗагрузка = (ЭтаФорма.ТекущийЭлемент = ЭтаФорма.Элементы.АктивностьЗагрузки);
	
	Если ЭтоЗагрузка Тогда
		Идентификатор = ЭтаФорма.ИдентификаторРегламентЗагрузки;
	Иначе
		Идентификатор = ЭтаФорма.ИдентификаторРегламентВыгрузки;
	КонецЕсли;	
			
	Если ЭтоЗагрузка Тогда
		ЭтаФорма.ИспользуетсяРегламентЗагрузки = Не ЭтаФорма.ИспользуетсяРегламентЗагрузки;
		Используется = ЭтаФорма.ИспользуетсяРегламентЗагрузки;
	Иначе
		ЭтаФорма.ИспользуетсяРегламентВыгрузки = Не ЭтаФорма.ИспользуетсяРегламентВыгрузки;
		Используется = ЭтаФорма.ИспользуетсяРегламентВыгрузки;
	КонецЕсли;	
	
	ПараметрыЗадания = Новый Структура("Использование", Используется);
	ИзменитьРегламентноеЗадание(Идентификатор, ПараметрыЗадания);

	ОбновитьКнопкиИспользованияРегламентныхЗаданий();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьРегламентноеЗадание(Команда)
	
	ЭтоЗагрузка = (ЭтаФорма.ТекущийЭлемент = ЭтаФорма.Элементы.ВыполнитьЗагрузку);
	
	Если ЭтоЗагрузка Тогда 
		Идентификатор = ЭтаФорма.ИдентификаторРегламентЗагрузки;
		Наименование  = "Загрузка документов ЭПД";
	Иначе 
		Идентификатор = ЭтаФорма.ИдентификаторРегламентВыгрузки;
		Наименование  = "Выгрузка документов ЭПД";
	КонецЕсли;	
	
	ПараметрыВыполнения = ВыполнитьРегламентноеЗаданиеСервер(Идентификатор);
	МассивСообщенийОбОшибках = Новый Массив;
	
	Если ПараметрыВыполнения.ЗапускВыполнен Тогда
		
		Текст = НСтр("ru = 'Запущена процедура регламентного задания';
					|en = 'Scheduled job started'");
		
		ПояснениеТекст = НСтр("ru = '%1.
							|Процедура запущена в фоновом задании %2';
							|en = '%1.
							|The scheduled job has been started in the background job ""%2"".'");
		
		Пояснение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						ПояснениеТекст,
					    Наименование,
					    Строка(ПараметрыВыполнения.МоментЗапуска));
					
		ПоказатьОповещениеПользователя(
			Текст, ,
			Пояснение,
			БиблиотекаКартинок.ВыполнитьРегламентноеЗаданиеВручную);
			
		ЭтаФорма.ИдентификаторыФоновыхЗаданийПриРучномВыполнении.Добавить(
			ПараметрыВыполнения.ИдентификаторФоновогоЗадания,
			Наименование);
		
		ПодключитьОбработчикОжидания(
			"СообщитьОбОкончанииРучногоВыполненияРегламентногоЗадания", 0.1, Истина);
		
	ИначеЕсли ПараметрыВыполнения.ПроцедураУжеВыполняется Тогда
		
		Текст = НСтр("ru = 'Процедура регламентного задания ""%1""
						|  уже выполняется в фоновом задании ""%2"", начатом %3.';
						|en = 'The scheduled job ""%1"" is running in
						|the background job ""%2""  started on %3.'");
		
		Сообщение = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
						Текст,
						Наименование,
						ПараметрыВыполнения.ПредставлениеФоновогоЗадания,
						Строка(ПараметрыВыполнения.МоментЗапуска));
		
		МассивСообщенийОбОшибках.Добавить(Сообщение);
			
	Иначе		
		Возврат;		
	КонецЕсли;
			
	КоличествоОшибок = МассивСообщенийОбОшибках.Количество();
	Если КоличествоОшибок > 0 Тогда
		
		Текст = НСтр("ru = 'Задания не выполнены (%1 из %2)';
				|en = 'The jobs are not completed (%1 out of %2)'");
		
		ЗаголовокТекстаПроОшибки = СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
			Текст,
			Формат(КоличествоОшибок, "ЧГ="),
			"1");
		
		ТекстВсехОшибок = Новый ТекстовыйДокумент;
		ТекстВсехОшибок.ДобавитьСтроку(ЗаголовокТекстаПроОшибки + ":");
		
		Для Каждого ТекстЭтойОшибки Из МассивСообщенийОбОшибках Цикл
			ТекстВсехОшибок.ДобавитьСтроку("");
			ТекстВсехОшибок.ДобавитьСтроку(ТекстЭтойОшибки);
		КонецЦикла;
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСправочникВидыУпаковки(Команда)

	РезультатЗагрузки = РезультатЗагрузкиСправочника("Saby_ВидыУпаковки");	
	ПоказатьРезультатЗагрузкиСправочника(РезультатЗагрузки);

КонецПроцедуры

&НаКлиенте
Процедура ЗагрузитьСправочникОпасныеГрузы(Команда)
	
	РезультатЗагрузки = РезультатЗагрузкиСправочника("Saby_ОпасныеГрузы");	
	ПоказатьРезультатЗагрузкиСправочника(РезультатЗагрузки);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОбновитьВидимостьИДоступностьЭлементов()
	
	ВидимостьОбработкиДляРегламентов = Ложь;
	
	СсылкаНаВнешнююОбработкуСРегламентами = СсылкаНаВнешнююОбработкуСРегламентами();
	Если ЗначениеЗаполнено(СсылкаНаВнешнююОбработкуСРегламентами)
		И ТипЗнч(СсылкаНаВнешнююОбработкуСРегламентами) = Тип("СправочникСсылка.ДополнительныеОтчетыИОбработки") Тогда 
		
		ВидимостьОбработкиДляРегламентов = Истина;
		
	КонецЕсли;	
	
	Элементы.НастройкиРегламентныхЗаданий.Видимость = ВидимостьОбработкиДляРегламентов;
	
	УстановитьДанныеРегламентныхЗаданий();
			
	ЕстьЗагрузка = ЗначениеЗаполнено(ЭтаФорма.ИдентификаторРегламентЗагрузки);
	Элементы.НастройкиЗагрузки.Видимость = ЕстьЗагрузка;
			
	ЕстьВыгрузка = ЗначениеЗаполнено(ЭтаФорма.ИдентификаторРегламентВыгрузки);
	Элементы.НастройкиВыгрузки.Видимость = ЕстьВыгрузка;
	
	ОбновитьКнопкиИспользованияРегламентныхЗаданий();
	
КонецПроцедуры

#Область РегламентныеЗадания

 &НаКлиенте
Процедура НастройкиРасписанияРегламентногоЗадания(КомандаИмя)
	
	Идентификаторы = Новый Структура;
	Идентификаторы.Вставить("Выгрузка", ЭтаФорма.ИдентификаторРегламентВыгрузки);
	Идентификаторы.Вставить("Загрузка", ЭтаФорма.ИдентификаторРегламентЗагрузки);
	
	ДанныеРасписания = РасписаниеРегламентногоЗадания(КомандаИмя, Идентификаторы);	
	Если ДанныеРасписания = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("Идентификатор", ДанныеРасписания.Идентификатор);
	
	Диалог = Новый ДиалогРасписанияРегламентногоЗадания(ДанныеРасписания.Расписание);
	Диалог.Показать(Новый ОписаниеОповещения("ОткрытиеРасписаниеЗавершение", ЭтотОбъект, ДопПараметры));
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция РегламентныеЗаданияИзБД()
		
	ЗаданиеЗагрузка = РегламентноеЗаданиеПоКлючу("Saby_Загрузка ЭПД");
	ЗаданиеВыгрузка = РегламентноеЗаданиеПоКлючу("Saby_Выгрузка ЭПД");
	
	Структура = Новый Структура;
	Структура.Вставить("ЗаданиеЗагрузка", ЗаданиеЗагрузка);
	Структура.Вставить("ЗаданиеВыгрузка", ЗаданиеВыгрузка);
	
	Возврат Структура;
	
КонецФункции

&НаСервереБезКонтекста
Функция РегламентноеЗаданиеПоКлючу(Ключ)
	
	Задание = Неопределено;
	
	Отбор = Новый Структура("Ключ", Ключ);
	НайденныеЗадания = РегламентныеЗадания.ПолучитьРегламентныеЗадания(Отбор);	
	Если НайденныеЗадания.Количество() Тогда
		Задание = НайденныеЗадания[0];
	КонецЕсли;

    Возврат Задание;
	
КонецФункции

&НаСервереБезКонтекста
Функция РасписаниеРегламентногоЗадания(Знач ИмяКоманды, Знач Идентификаторы)
		
	УстановитьПривилегированныйРежим(Истина);
		
	Если ИмяКоманды = "НастройкаЗагрузки" Тогда 
		Идентификатор = Идентификаторы.Загрузка;
	ИначеЕсли ИмяКоманды = "НастройкаВыгрузки" Тогда 
		Идентификатор = Идентификаторы.Выгрузка;
	Иначе
		Возврат Неопределено;		
	КонецЕсли;
	
	Расписание = РегламентныеЗаданияСервер.РасписаниеРегламентногоЗадания(Идентификатор);
	
	Структура = Новый Структура;
	Структура.Вставить("Идентификатор", Идентификатор);
	Структура.Вставить("Расписание",    Расписание);
	
	Возврат Структура;
		
КонецФункции

&НаКлиенте
Процедура ЗаписатьРегламентноеЗадание(НовоеРасписание, Идентификатор)
		
	ПараметрыЗадания = Новый Структура("Расписание", НовоеРасписание);
	ИзменитьРегламентноеЗадание(Идентификатор, ПараметрыЗадания);
	
КонецПроцедуры

&НаКлиенте
Процедура ОткрытиеРасписаниеЗавершение(НовоеРасписание, ДопПараметры) Экспорт
	
	Если НовоеРасписание <> Неопределено Тогда
		ЗаписатьРегламентноеЗадание(НовоеРасписание, ДопПараметры.Идентификатор);
	КонецЕсли;
	
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ИзменитьРегламентноеЗадание(Знач ИдентификаторРегламентногоЗадания, Знач ПараметрыЗадания)
	
	УстановитьПривилегированныйРежим(Истина);
	
	Попытка		
		// 3.1.24
		РегламентныеЗаданияСервер.ИзменитьРегламентноеЗадание(ИдентификаторРегламентногоЗадания, ПараметрыЗадания);		
	Исключение
		// 3.1.19
		РегламентныеЗаданияСервер.ИзменитьЗадание(ИдентификаторРегламентногоЗадания, ПараметрыЗадания);
	КонецПопытки;
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДанныеРегламентныхЗаданий()

	ЗаданияВыгрузкиЗагрузки = РегламентныеЗаданияИзБД();
	
	ЗаданиеЗагрузка = ЗаданияВыгрузкиЗагрузки.ЗаданиеЗагрузка;
	ЗаданиеВыгрузка = ЗаданияВыгрузкиЗагрузки.ЗаданиеВыгрузка;
		
	ЕстьЗагрузка = ЗаданиеЗагрузка <> Неопределено;
	Если ЕстьЗагрузка Тогда
		
		ЭтаФорма.ИдентификаторРегламентЗагрузки  = ЗаданиеВыгрузка.УникальныйИдентификатор;
		ЭтаФорма.ИспользуетсяРегламентЗагрузки   = ЗаданиеЗагрузка.Использование;
		
	КонецЕсли;
	
	ЕстьВыгрузка = ЗаданиеВыгрузка <> Неопределено;	
	Если ЕстьВыгрузка Тогда
		
		ЭтаФорма.ИдентификаторРегламентВыгрузки  = ЗаданиеВыгрузка.УникальныйИдентификатор;
		ЭтаФорма.ИспользуетсяРегламентВыгрузки   = ЗаданиеВыгрузка.Использование;
		
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура СообщитьОбОкончанииРучногоВыполненияРегламентногоЗадания()
	
	ОповещенияОбОкончанииВыполнения = ОповещенияОбОкончанииВыполненияРегламентныхЗаданий();
	
	Для каждого Оповещение Из ОповещенияОбОкончанииВыполнения Цикл
		
		ПоказатьОповещениеПользователя(
			НСтр("ru = 'Выполнена процедура регламентного задания';
				|en = 'Scheduled job procedure completed'"),
			,
			СтроковыеФункцииКлиентСервер.ПодставитьПараметрыВСтроку(
				НСтр("ru = '%1.
				           |Процедура завершена в фоновом задании %2';
				           |en = '%1.
				           |The scheduled job has been completed in the background job ""%2"".'"),
				Оповещение.ПредставлениеРегламентногоЗадания,
				Строка(Оповещение.МоментОкончания)),
			БиблиотекаКартинок.ВыполнитьРегламентноеЗаданиеВручную);
	КонецЦикла;
	
	Если ИдентификаторыФоновыхЗаданийПриРучномВыполнении.Количество() > 0 Тогда
		
		ПодключитьОбработчикОжидания(
			"СообщитьОбОкончанииРучногоВыполненияРегламентногоЗадания", 2, Истина);

	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ОповещенияОбОкончанииВыполненияРегламентныхЗаданий()
	
	ОповещенияОбОкончанииВыполнения = Новый Массив;
	
	Если ИдентификаторыФоновыхЗаданийПриРучномВыполнении.Количество() > 0 Тогда
		Индекс = ИдентификаторыФоновыхЗаданийПриРучномВыполнении.Количество() - 1;
		
		УстановитьПривилегированныйРежим(Истина);
		Пока Индекс >= 0 Цикл
			
			НовыйУникальныйИдентификатор = Новый УникальныйИдентификатор(
				ИдентификаторыФоновыхЗаданийПриРучномВыполнении[Индекс].Значение);
			Отбор = Новый Структура;
			Отбор.Вставить("УникальныйИдентификатор", НовыйУникальныйИдентификатор);
			
			МассивФоновыхЗаданий = ФоновыеЗадания.ПолучитьФоновыеЗадания(Отбор);
			
			Если МассивФоновыхЗаданий.Количество() = 1 Тогда
				МоментОкончания = МассивФоновыхЗаданий[0].Конец;
				
				Если ЗначениеЗаполнено(МоментОкончания) Тогда
					
					ОповещенияОбОкончанииВыполнения.Добавить(
						Новый Структура(
							"ПредставлениеРегламентногоЗадания,
							|МоментОкончания",
							ИдентификаторыФоновыхЗаданийПриРучномВыполнении[Индекс].Представление,
							МоментОкончания));
					
					ИдентификаторыФоновыхЗаданийПриРучномВыполнении.Удалить(Индекс);
				КонецЕсли;
			Иначе
				ИдентификаторыФоновыхЗаданийПриРучномВыполнении.Удалить(Индекс);
			КонецЕсли;
			Индекс = Индекс - 1;
		КонецЦикла;
		УстановитьПривилегированныйРежим(Ложь);
	КонецЕсли;
	
	Возврат ОповещенияОбОкончанииВыполнения;
	
КонецФункции

#КонецОбласти // РегламентныеЗадания 

&НаСервереБезКонтекста
Процедура ХранитьПечатнуюФормуТранспортнойНакладнойВБДПриИзмененииНаСервере(Знач ЗначениеКонстанты)
	
	Константы.Saby_ХранитьПечатныеФормыВБД.Установить(ЗначениеКонстанты);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция СсылкаНаВнешнююОбработкуСРегламентами()
	
	РезультатФункции = "";
	
	ЕстьДополнительныеОтчетыИОбработкиВКонфигурации = 
		Метаданные.Справочники.Найти("ДополнительныеОтчетыИОбработки") <> Неопределено;
		
	Если Не ЕстьДополнительныеОтчетыИОбработкиВКонфигурации Тогда
		РезультатФункции = "В конфигурации нет справочника ""Дополнительные отчеты и обработки"", настройка недоступна.";
		Возврат РезультатФункции;
	КонецЕсли;
	
	ДопОтчетыИОбработкиВключены = Константы.ИспользоватьДополнительныеОтчетыИОбработки.Получить();
	Если Не ДопОтчетыИОбработкиВключены Тогда
		РезультатФункции =
			"В конфигурации не включено использование дополнительных отчетов и обработок. Настройка недоступна.";
		Возврат РезультатФункции;
	КонецЕсли;
	
	РезультатФункции = Справочники.ДополнительныеОтчетыИОбработки.ПустаяСсылка();
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ ПЕРВЫЕ 1
	|	ДополнительныеОтчетыИОбработки.Ссылка КАК Ссылка
	|ИЗ
	|	Справочник.ДополнительныеОтчетыИОбработки КАК ДополнительныеОтчетыИОбработки
	|ГДЕ
	|	ДополнительныеОтчетыИОбработки.Наименование = &Наименование
	|	И НЕ ДополнительныеОтчетыИОбработки.ПометкаУдаления";
	
	ЗапросДанных.УстановитьПараметр("Наименование", "SABY_ФЗ");
	
	ВыборкаДанных = ЗапросДанных.Выполнить().Выбрать();
	Если ВыборкаДанных.Следующий() Тогда
		РезультатФункции = ВыборкаДанных.Ссылка;
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

&НаКлиенте
Процедура ПослеВопросаОДобавленииОбработки(Результат, ДополнительныеПараметры) Экспорт
	
	Если Результат <> КодВозвратаДиалога.Да Тогда
		Возврат;
	КонецЕсли;
	
	ОткрытьФорму("Справочник.ДополнительныеОтчетыИОбработки.ФормаСписка", , ЭтотОбъект);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОбновитьДанныеНа236200НаСервере()
	
	Возврат Saby_ТНОбщегоНазначенияСервер.РезультатПереходаНа236200();
	
КонецФункции

&НаКлиенте
Процедура НастройкаВсехДокументовОснований(ИмяКоманды)
		
	ПараметрыФормы = ПараметрыДляНастройкиОснований(ИмяКоманды);
	
	ОткрытьФорму("ОбщаяФорма.Saby_ВыборТиповЭПД", ПараметрыФормы, ЭтотОбъект);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ПараметрыДляНастройкиОснований(Знач ИмяКоманды)
	
	Если ИмяКоманды = "НастройкиДокументовОснованийЭПЛ" Тогда
		Ссылка = Документы.Saby_ПутевойЛист.ПустаяСсылка();		
	Иначе 	
		Ссылка = Документы.Saby_ТранспортнаяНакладная.ПустаяСсылка();
	КонецЕсли;	
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("Ссылка", Ссылка);

	Возврат ДопПараметры;
	
КонецФункции

&НаСервереБезКонтекста
Функция ВыполнитьРегламентноеЗаданиеСервер(Знач Идентификатор)
	
	Результат = РегламентныеЗаданияСлужебный.ВыполнитьРегламентноеЗаданиеВручную(Идентификатор);	
	Возврат Результат;
	
КонецФункции

&НаСервере
Процедура ОбновитьКнопкиИспользованияРегламентныхЗаданий()     
	
	НеИспользуется = Новый Картинка;
	Используется   = БиблиотекаКартинок.Saby_Успешно32;
	
	Если ЗначениеЗаполнено(ЭтаФорма.ИдентификаторРегламентЗагрузки) 
		И ЭтаФорма.ИспользуетсяРегламентЗагрузки Тогда
		
		Элементы.АктивностьЗагрузки.Картинка = Используется;
		
	Иначе		
		Элементы.АктивностьЗагрузки.Картинка = НеИспользуется;		
	КонецЕсли;
		
	Если ЗначениеЗаполнено(ЭтаФорма.ИдентификаторРегламентВыгрузки) 
		И ЭтаФорма.ИспользуетсяРегламентВыгрузки Тогда
		
		Элементы.АктивностьВыгрузки.Картинка = Используется;
		
	Иначе 			
		Элементы.АктивностьВыгрузки.Картинка = НеИспользуется; 		
	КонецЕсли;	
	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьРезультатЗагрузкиСправочника(РезультатЗагрузки)
	
	Сообщение = Новый СообщениеПользователю;
	Сообщение.Текст = РезультатЗагрузки.Текст;
	Сообщение.Сообщить();
	
	Если ЗначениеЗаполнено(РезультатЗагрузки.ОписаниеОшибок) Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = РезультатЗагрузки.ОписаниеОшибок;
		Сообщение.Сообщить();
	КонецЕсли;
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция РезультатЗагрузкиСправочника(Знач НаименованиеСправочника)
	
	Результат = Новый Структура;
	
	Справочники[НаименованиеСправочника].ЗагрузитьСОнлайна(, Результат);
	
	Возврат Результат;
	
КонецФункции

#КонецОбласти // СлужебныеПроцедурыИФункции
