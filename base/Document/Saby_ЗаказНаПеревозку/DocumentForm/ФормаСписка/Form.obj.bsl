
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Saby_ТНОбщегоНазначенияСервер.УстановитьПараметрАккаунтаВСписке(Список);
	
	СтандартныеПодсистемыСервер.УстановитьУсловноеОформлениеПоляДата(ЭтаФорма,
		"Список.Дата", "Дата");
			
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	// обновление статуса версии в фоне
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("ДвоичныеДанныеОбработки", Неопределено);
	ДополнительныеПараметры.Вставить("НаКлиенте",               Ложь);
	ДополнительныеПараметры.Вставить("ОтветНаКлиенте",          Неопределено);
	
	Saby_ТНОбщегоНазначенияКлиент.ВыполнитьКомандуСбис(ЭтаФорма, "АктуальныйСтатусВерсии", Неопределено, ДополнительныеПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	Saby_ТНОбщегоНазначенияКлиент.ОбработатьОповещенияДляФормы(ЭтаФорма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ВыгрузитьВСбис(Команда)
	
	Saby_ТНОбщегоНазначенияКлиент.ОбменДаннымиСБИСИзФормыСписка(ЭтаФорма, Команда.Имя);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДокументИзСбис(Команда)
			
	Saby_ТНОбщегоНазначенияКлиент.ОбновитьДокументыСБИС(ЭтаФорма, Команда.Имя, "Saby_ПутевойЛист");		
			
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДокументИзСбисЗаПериод(Команда)
	
	Saby_ТНОбщегоНазначенияКлиент.ОбновитьДокументыЗаПериод(ЭтаФорма, "ОбновитьДокументИзСбис", Истина); 

КонецПроцедуры

&НаКлиенте
Процедура ТипПриИзменении(Элемент)
	
	Saby_ТНОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список, 
		Тип, 
		"Направление"); 
		
КонецПроцедуры

&НаКлиенте
Процедура Просмотрено(Команда)
	
	МассивДокументов = Saby_ТНОбщегоНазначенияКлиент.ДокументыДляОбработки(ЭтаФорма);
	Saby_ТНОбщегоНазначенияСервер.СбросСтатусаНеПросмотрено(МассивДокументов);
	ОповеститьОбИзменении(Тип("ДокументСсылка.Saby_ЗаказНаПеревозку"));
	
КонецПроцедуры

&НаКлиенте
Процедура ОтборИзмененныхДокументов(Команда)
	
	УстановленОтборИзмененныхДокументов = Не УстановленОтборИзмененныхДокументов;
	Если УстановленОтборИзмененныхДокументов Тогда		
		Значение = Ложь;		
	Иначе		
		Значение = Неопределено;		
	КонецЕсли;
		
	Saby_ТНОбщегоНазначенияКлиентСервер.УстановитьЭлементОтбораДинамическогоСписка(
		Список,
		Значение, 
		"Просмотрен");
	
КонецПроцедуры

&НаКлиенте
Процедура Печать(Команда)
	
	Saby_ТНОбщегоНазначенияКлиент.ПечатьДокумента(ЭтаФорма, Команда.Имя, "", Истина);
		
КонецПроцедуры

&НаКлиенте
Процедура СсылкаОбновлениеНажатие(Элемент)
	ЗапуститьПриложение(Элемент.Подсказка);
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область СлужебныеПроцедурыИФункции

#Область ОбработкаОповещений

&НаКлиенте
Процедура ОбработатьОповещениеВыполнитьПереходНаФорме() Экспорт
	
	Saby_ТНОбщегоНазначенияКлиент.ОбменДаннымиСБИСИзФормыСписка(ЭтаФорма, "ОбновитьАктивныйЭтап");
	
КонецПроцедуры
	
#КонецОбласти // ОбработкаОповещений

#КонецОбласти // СлужебныеПроцедурыИФункции
