
&НаКлиенте
// Универсальное выполнение команд
// Параметры:
//	Форма - ФормаКлиентскогоПриложения - источник вызова выполнения
//	ИмяКоманды - Строка - имя команды, которую требуется выполнить
//	МассивДокументов - Массив - документы для выполнения команды
//  ДополнительныеПараметры - Структура - дополнительные параметры команды
//
Процедура ВыполнитьКомандуСбис(Форма, ИмяКоманды, МассивДокументов, ДополнительныеПараметры = Неопределено) Экспорт
	
	ДопПараметры = Новый Структура;		
	ДопПараметры.Вставить("ИмяКоманды", ИмяКоманды);
	
	context_params = АвторизацияSaby(ИмяКоманды, Форма);
	
	ТранспортВО = Неопределено;
	Если ДополнительныеПараметры <> Неопределено И ДополнительныеПараметры.ДвоичныеДанныеОбработки <> Неопределено Тогда
		ТранспортВО = ТранспортВО(Форма, context_params);
	КонецЕсли;
	
	Если ЭтоЗагрузкаЧтениеИлиОбновление(ИмяКоманды) Тогда
		
		Если МассивДокументов.Количество() > 1 Тогда 
			Сообщение = Новый СообщениеПользователю;
			Сообщение.Текст = "Данная команда предназначена для выполнения по 1 документу. 
				|Будет использован первый выбранный документ из списка";
			Сообщение.Сообщить();			
		КонецЕсли;
		
		Если context_params <> Неопределено Тогда
			
			Если ЗначениеЗаполнено(МассивДокументов) Тогда 
				Массив = Новый Массив;
				Массив.Добавить(МассивДокументов[0]);
			КонецЕсли;
			
			ПередВыполнениемКоманды(Массив, ТранспортВО, context_params, ДополнительныеПараметры);
			
			ДопПараметры.Вставить("МассивДокументов", Массив);
			ДопПараметры.Вставить("context_params",   context_params);			
			ДопПараметры.Вставить("ДопПараметры",     ДополнительныеПараметры);
			ДопПараметры.Вставить("Источник",         Форма.УникальныйИдентификатор);
			ВыполнитьКомандуВФоне(Форма, ДопПараметры);
			
		КонецЕсли;
		
	ИначеЕсли ИмяКоманды = "ОткрытьВСбис" Тогда  		
		
		Массив = Новый Массив;
		Массив.Добавить(МассивДокументов[0]);
		// Источник = Массив;
		
		ПараметрыФормы = Новый Структура;		
		ПараметрыФормы.Вставить("Форма", Форма);
		
		МодульКодаКлиент("Saby_КомандыОбменаДляФормыКлиент").ПриНажатииОткрытьВСБИСПолучитьUID(ИмяКоманды, ПараметрыФормы);
		
	ИначеЕсли ЭтоДополнительнаяКоманда(ИмяКоманды) Тогда
		
		ДополнительныеПараметры.Вставить("context_params", context_params);
		
		ДопПараметры.Вставить("ДопПараметры", ДополнительныеПараметры);
		
		ПередВыполнениемДополнительныхКоманд(ТранспортВО, ДопПараметры, context_params);
		
		ПараметрыОжидания = Новый Структура;
		ПараметрыОжидания.Вставить("ВыводитьОкноОжидания", Ложь);
		
		ДопПараметры.Вставить("ПараметрыОжидания", ПараметрыОжидания);
		ДопПараметры.Вставить("Источник",          Форма.УникальныйИдентификатор);
		
		ВыполнитьКомандуВФоне(Форма, ДопПараметры);
		
	Иначе
		
		ВызватьИсключение("Для команды " + ИмяКоманды + " не предусмотрен обработчик! Обратитесь к администратору");
			
	КонецЕсли;
	
КонецПроцедуры

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_ТранспортВО
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_ТранспортВО

&НаКлиенте
Процедура ПередВыполнениемКоманды(МассивПараметров, ТранспортВО, context_params, ДополнительныеПараметры)
	
	Если Не ЗначениеЗаполнено(МассивПараметров) Или ТранспортВО = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЗагрузитьОпасныеГрузы = Ложь;
	ЗагрузитьВидыУпаковки = Ложь;
	
	ОбщиеПараметрыЗагрузки = Новый Структура;
	ОбщиеПараметрыЗагрузки.Вставить("context_params",  context_params);
	ОбщиеПараметрыЗагрузки.Вставить("ОбъектОбработки", ТранспортВО.ТранспортИнтеграции);
	ОбщиеПараметрыЗагрузки.Вставить("ТранспортБлокли", ТранспортВО.ТранспортБлокли);
	
	Для Каждого ПараметрыЗагрузки Из МассивПараметров Цикл
		
		Если ПараметрыЗагрузки.Свойство("ТолькоАктивныйЭтап") И ПараметрыЗагрузки.ТолькоАктивныйЭтап Тогда
			ЗаписатьСтатистикуНапрямую(ПараметрыЗагрузки, ОбщиеПараметрыЗагрузки);
		КонецЕсли;
		
		Результат = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").РезультатВзаимодействияСоСБИС(1);
		
		МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ДанныеДокументаИзСБИС(
			ПараметрыЗагрузки, ОбщиеПараметрыЗагрузки, Результат);
			
		ЗагрузитьОпасныеГрузы = ЗагрузитьОпасныеГрузы Или НужноЗагружатьОпасныеГрузы(ПараметрыЗагрузки);
		ЗагрузитьВидыУпаковки = ЗагрузитьВидыУпаковки Или НужноЗагружатьВидыУпаковки(ПараметрыЗагрузки);
		
	КонецЦикла;
	
	Если ЗагрузитьОпасныеГрузы Тогда
		ДополнительныеПараметры.Вставить(
			"ОпасныеГрузыСОнлайна", СправочникСОнлайна("Справочник опасных грузов", ОбщиеПараметрыЗагрузки));
	КонецЕсли;
	Если ЗагрузитьВидыУпаковки Тогда
		ДополнительныеПараметры.Вставить(
			"ВидыУпаковкиСОнлайна", СправочникСОнлайна("Вид упаковки Меркурия", ОбщиеПараметрыЗагрузки));
	КонецЕсли;
	
	ОбщиеПараметрыЗагрузки.ОбъектОбработки = Неопределено;
	ОбщиеПараметрыЗагрузки.ТранспортБлокли = Неопределено;
	
КонецПроцедуры

&НаКлиенте
Функция НужноЗагружатьОпасныеГрузы(ПараметрыЗагрузки)
	
	РезультатФункции = Ложь;
	
	ПервыйТитул = ПодстановкаПервогоТитула(ПараметрыЗагрузки);
	
	ПозицииГруза = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ДанныеСоответствия(ПервыйТитул, "Груз.Позиция");
	
	Если ЗначениеЗаполнено(ПозицииГруза) Тогда
		Для Каждого ПозицияГруза Из ПозицииГруза Цикл
			ОпасныйГруз = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ДанныеСоответствия(ПозицияГруза, "ОпасныйГруз");
			РезультатФункции = РезультатФункции Или ЗначениеЗаполнено(ОпасныйГруз);
		КонецЦикла;
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

&НаКлиенте
Функция НужноЗагружатьВидыУпаковки(ПараметрыЗагрузки)
	
	РезультатФункции = Ложь;
	
	ПервыйТитул = ПодстановкаПервогоТитула(ПараметрыЗагрузки);
	
	ПозицииГруза = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ДанныеСоответствия(ПервыйТитул, "Груз.Позиция");
	
	Если ЗначениеЗаполнено(ПозицииГруза) Тогда
		Для Каждого ПозицияГруза Из ПозицииГруза Цикл
			ТараКод = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ДанныеСоответствия(ПозицияГруза, "ТараКод");
			РезультатФункции = РезультатФункции Или ЗначениеЗаполнено(ТараКод);
		КонецЦикла;
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

&НаКлиенте
Функция ПодстановкаПервогоТитула(ПараметрыЗагрузки)
	
	ПервыйТитул = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ДанныеСоответствия(
		ПараметрыЗагрузки.ДанныеДокумента, "Подстановки.ЭТрН_1110339");
	Если ЗначениеЗаполнено(ПервыйТитул) Тогда
		ПервыйТитул = ПервыйТитул[0];
	Иначе
		ПервыйТитул = Новый Соответствие;
	КонецЕсли;
	
	Возврат ПервыйТитул;
	
КонецФункции
&НаКлиенте
Процедура ПередВыполнениемДополнительныхКоманд(ТранспортВО, ДопПараметры, context_params)
	
	Если Не ДопПараметры.ДопПараметры.НаКлиенте Тогда
		Возврат;
	КонецЕсли;
	
	ОбщиеПараметрыЗагрузки = Новый Структура;
	ОбщиеПараметрыЗагрузки.Вставить("context_params",  context_params);
	ОбщиеПараметрыЗагрузки.Вставить("ОбъектОбработки", ТранспортВО.ТранспортИнтеграции);
	ОбщиеПараметрыЗагрузки.Вставить("ТранспортБлокли", ТранспортВО.ТранспортБлокли);
	
	Если ДопПараметры.ИмяКоманды = "РаспознаваниеВУ" Тогда
		ДопПараметры.ДопПараметры.ОтветНаКлиенте = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").РаспознаваниеВУ(
			ДопПараметры.ДопПараметры, ОбщиеПараметрыЗагрузки);
	ИначеЕсли ДопПараметры.ИмяКоманды = "ЗагрузитьДанныеТСПоРегНомеру" Тогда
		ДопПараметры.ДопПараметры.ОтветНаКлиенте = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ЗагрузитьДанныеТСПоРегНомеру(
			ДопПараметры.ДопПараметры, ОбщиеПараметрыЗагрузки);
	ИначеЕсли ДопПараметры.ИмяКоманды = "ЗагрузитьДанныеТСПоВИН" Тогда
		ДопПараметры.ДопПараметры.ОтветНаКлиенте = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ЗагрузитьДанныеТСПоВИН(
			ДопПараметры.ДопПараметры, ОбщиеПараметрыЗагрузки);
	Иначе
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
// Фоновое выполнене команды
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - источник вызова выполнения
//  СтруктураПараметров - Структура - параметры для выполнения команды
//
Процедура ВыполнитьКомандуВФоне(Форма, СтруктураПараметров) Экспорт
	
	ДлительнаяОперация = ВыполнитьНаСервере("Saby_ТНОбщегоНазначенияСервер.ДлительнаяОперация",
		СтруктураПараметров, 
		Форма.УникальныйИдентификатор);
	
	ПараметрыОжидания = ДлительныеОперацииКлиент.ПараметрыОжидания(Форма); 
	Если СтруктураПараметров.Свойство("ПараметрыОжидания") Тогда
		ЗаполнитьЗначенияСвойств(ПараметрыОжидания, СтруктураПараметров.ПараметрыОжидания);
	КонецЕсли;	
	
	СтруктураПараметров.Вставить("Форма", Форма);
	
	Оповещение = Новый ОписаниеОповещения(
		"ОбработатьРезультат", МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент"), СтруктураПараметров);
	ДлительныеОперацииКлиент.ОжидатьЗавершение(ДлительнаяОперация, Оповещение, ПараметрыОжидания);
	
КонецПроцедуры

&НаКлиенте
// Вывести ошибку или оповестить источник о успешном выполнении команды
// Параметры:
//	Результат - Структура - данные по результатам выполнения команды 
//  ДополнительныеПараметры - Структура - параметры для обработки результата
//
Процедура ОбработатьРезультат(Результат, ДополнительныеПараметры) Экспорт
		
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
		
	Если Результат.Статус = "Ошибка" Тогда
		ВызватьИсключение Результат.КраткоеПредставлениеОшибки;
	КонецЕсли;
	
	ИмяКоманды = ДополнительныеПараметры.ИмяКоманды;
	Источник   = ДополнительныеПараметры.Источник;
	
	РезультатОбработки = ПолучитьИзВременногоХранилища(Результат.АдресРезультата);
	УдалитьИзВременногоХранилища(Результат.АдресРезультата);
	
	Если ЭтоЗагрузкаЧтениеИлиОбновление(ИмяКоманды) Тогда
		
		ОбработатьРезультатКоманды(РезультатОбработки, ИмяКоманды, ДополнительныеПараметры);  
		
		// Обновить форму списка после каких то изменений
		Оповестить("Saby_СписокДокументовОбновить", , Источник);   
		
	ИначеЕсли ЭтоДополнительнаяКоманда(ИмяКоманды) Тогда
	
		Оповестить("Saby_" + ИмяКоманды, РезультатОбработки, Источник);
		
	Иначе		
		Возврат;		
	КонецЕсли;
			
КонецПроцедуры

&НаКлиенте
Функция ЭтоЗагрузкаЧтениеИлиОбновление(ИмяКоманды)
	
	Возврат ИмяКоманды = "ВыгрузитьВСбис"
		Или ИмяКоманды = "ЗагрузитьВСбисДинамическийТитул"
		Или ИмяКоманды = "ПрочитатьДокумент"
		Или ИмяКоманды = "ОбновитьАктивныйЭтап"  
		Или ИмяКоманды = "ОбновитьДокументИзСбис";
	
КонецФункции

&НаКлиенте
Функция ЭтоДополнительнаяКоманда(ИмяКоманды)
	
	Возврат ИмяКоманды = "АктуальныйСтатусВерсии"
		Или ИмяКоманды = "РаспознаваниеВУ"
		Или ИмяКоманды = "ЗагрузитьДанныеТСПоРегНомеру"
		Или ИмяКоманды = "ЗагрузитьДанныеТСПоВИН";
	
КонецФункции

&НаКлиенте
Процедура ОбработатьРезультатКоманды(РезультатОбработки, ИмяКоманды, ДополнительныеПараметры)
	
	ПродолжитьВыполнениеНаКлиенте(РезультатОбработки, ИмяКоманды, ДополнительныеПараметры);
	
	ОповеститьПослеОбработкиРезультатаКоманды(ИмяКоманды, РезультатОбработки, ДополнительныеПараметры.Источник);
	
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ОповеститьПользователяОРезультатах(
		Неопределено, ИмяКоманды, РезультатОбработки);
	
КонецПроцедуры

&НаКлиенте
Процедура ПродолжитьВыполнениеНаКлиенте(РезультатОбработки, ИмяКоманды, ДополнительныеПараметры)
    
    Если Не РезультатОбработки.Выполнение.НаКлиенте Тогда
        Возврат;
    КонецЕсли;
    
    Если ИмяКоманды = "ВыгрузитьВСбис" Или ИмяКоманды = "ЗагрузитьВСбисДинамическийТитул" Тогда
		Для Каждого СтруктураПараметров Из РезультатОбработки.Выполнение.Параметры Цикл
			ТранспортВО = ТранспортВО(ДополнительныеПараметры.Форма, СтруктураПараметров.ОбщиеПараметрыВыгрузки.context_params);
			СтруктураПараметров.ОбщиеПараметрыВыгрузки.ОбъектОбработки = ТранспортВО.ТранспортИнтеграции;
			СтруктураПараметров.ОбщиеПараметрыВыгрузки.ТранспортБлокли = ТранспортВО.ТранспортБлокли;
			МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ВыполнитьВыгрузку(
				СтруктураПараметров.ПараметрыВыгрузки, СтруктураПараметров.ОбщиеПараметрыВыгрузки, РезультатОбработки);
		КонецЦикла;
	КонецЕсли;
    
КонецПроцедуры

&НаКлиенте
Процедура ОповеститьПослеОбработкиРезультатаКоманды(ИмяКоманды, РезультатОбработки, Источник)
	
	Если РезультатОбработки.Ошибки.Количество() Тогда
		
		Если Не ЭтоВыгрузкаДинамическогоТитула(ИмяКоманды) Тогда
			МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ОткрытьПервыйДокументИзСоответствия(РезультатОбработки.Ошибки);
		КонецЕсли;
		
		ПараметрыФормы = Новый Структура();
		ПараметрыФормы.Вставить("СписокДокументов",     РезультатОбработки.Ошибки);
		ПараметрыФормы.Вставить("ЭтоДинамическийТитул", ЭтоВыгрузкаДинамическогоТитула(ИмяКоманды));
		
		Оповестить("Saby_СписокДокументов", ПараметрыФормы);
		
	КонецЕсли;
	
	Если Не РезультатОбработки.Итог.Успех Тогда
		Возврат;
	КонецЕсли;
	
	МассивСсылок = РезультатОбработки.Успешные;
	Для Каждого Элемент Из МассивСсылок Цикл
		
		// одиночная команда
		Если ИмяКоманды = "ПрочитатьДокумент"
			Или ИмяКоманды = "ОбновитьАктивныйЭтап"
			Или ИмяКоманды = "ЗагрузитьВСбисДинамическийТитул" Тогда
			
			Оповестить("Saby_ОбновитьДокумент", Элемент, Источник);
			
		ИначеЕсли ИмяКоманды = "ВыгрузитьВСбис" Тогда
			
			Оповестить("Saby_ВыполнитьПереход", Элемент, Источник);
			
		Иначе
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция ЭтоВыгрузкаДинамическогоТитула(ИмяКоманды)
	
	Возврат ИмяКоманды = "ЗагрузитьВСбисДинамическийТитул";
	
КонецФункции

