
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьРеквизитыИзПараметров(Параметры);
	
	ОбновитьВидимостьДоступностьЭлементовФормы(Параметры.ТолькоПросмотр);
	
	Если Параметры.Свойство("ОснованияВладения") И ЭтаФорма.ДокументыЭПД.Количество() = 0 Тогда
		ЗаполнитьОснованияВладенияИзСтроки(Параметры.ОснованияВладения);
	КонецЕсли;
	
	УстановитьТипыРеквизитов();
	
	ОбновитьОтображениеОснованийВладения();
	
	НастроитьДокументыЭПД();
	
	НастроитьФормуДляСтарыхПлатформ();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ОбработатьОповещенияДляФормы(ЭтаФорма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТранспортноеСредствоПриИзменении(Элемент)
	
	ОчиститьСообщения();
	
	ЗаполнитьРеквизитыНаОснованииСправочника();
	
КонецПроцедуры

&НаКлиенте
Процедура ТипВладенияПриИзменении(Элемент)
	
	ОбновитьОтображениеОснованийВладения();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийЭлементовШапкиФормы

#Область ОбработчикиСобытийЭлементовТаблицыФормыДокументыЭПД

&НаКлиенте
Процедура ДокументыЭПДПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		
		Элемент.ТекущиеДанные.КлючСтроки = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").НовыйКлючСтроки(
			ЭтаФорма, "ДокументыЭПД");
			
		Элемент.ТекущиеДанные.Тип = ЗначениеМетаданных("Saby_ТипыДокумента.ПодтверждениеВладения");
		
	КонецЕсли;
	
	Если ЭтаФорма.ЭтоВО Тогда
		
		МодульКодаКлиент("ЭтаФорма").ДокументыЭПДОткрыть(
			Элемент.ТекущийЭлемент.Имя, 
			"Документ владения", 
			"ДокументТС",
		    Элементы.ДокументыЭПД.ТолькоПросмотр);  		
			
	КонецЕсли;
		
КонецПроцедуры

&НаКлиенте
Процедура ДокументыЭПДВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	
	Если ЭтаФорма.ЭтоВО 
		И Элементы.ДокументыЭПД.ТолькоПросмотр Тогда
		
		 МодульКодаКлиент("ЭтотОбъект").ДокументыЭПДОткрыть(
			"ДокументыЭПДНаименование", 
			"Документ владения", 
			"ДокументТС",
		    Элементы.ДокументыЭПД.ТолькоПросмотр);
		
	 КонецЕсли;
	 	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийЭлементовТаблицыФормыДокументыЭПД

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	СтруктураТранспортногоСредства = Новый Структура();
	СтруктураТранспортногоСредства.Вставить("Вид",                  ЭтаФорма.Вид);
	СтруктураТранспортногоСредства.Вставить("РегистрационныйНомер", ЭтаФорма.РегистрационныйНомер);
	СтруктураТранспортногоСредства.Вставить("Тип",                  ЭтаФорма.Тип);
	СтруктураТранспортногоСредства.Вставить("Марка",                ЭтаФорма.Марка);
	СтруктураТранспортногоСредства.Вставить("Модель",               ЭтаФорма.Модель);
	СтруктураТранспортногоСредства.Вставить("ВИН",                  ЭтаФорма.ВИН);
	СтруктураТранспортногоСредства.Вставить("НомерСТС",             ЭтаФорма.НомерСТС);
	СтруктураТранспортногоСредства.Вставить("Грузоподъемность",     ЭтаФорма.Грузоподъемность);
	СтруктураТранспортногоСредства.Вставить("Вместимость",          ЭтаФорма.Вместимость);
	СтруктураТранспортногоСредства.Вставить("ТипВладения",          ЭтаФорма.ТипВладения);
	СтруктураТранспортногоСредства.Вставить("ИнвентарныйНомер",     ЭтаФорма.ИнвентарныйНомер);
	СтруктураТранспортногоСредства.Вставить("Идентификатор",        ЭтаФорма.Идентификатор);
	СтруктураТранспортногоСредства.Вставить("ЭтоВО",                ЭтаФорма.ЭтоВО);
	
	Если ЭтаФорма.ЭтоВО Тогда
		// Формируем сложную структуру по данным связанных таблиц
		ДанныеДокументов = МодульКодаКлиент("ЭтаФорма").СформироватьДокументыЭПД(ЭтаФорма.ДокументыЭПД, ЭтаФорма.ДанныеЮрЛиц);	
	Иначе
		// простая структура со ссылками на справочник "документы эпд"
		ДанныеДокументов = ОснованияВладенияВСтроку(ЭтаФорма.ДокументыЭПД);
    КонецЕсли;
		
	СтруктураТранспортногоСредства.Вставить("ОснованияВладения", ДанныеДокументов);
	
	Закрыть(СтруктураТранспортногоСредства);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьНаОсновании(Команда)
	
	ЗаполнитьРеквизитыНаОснованииСправочника();
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьВсеПоля(Команда)
	
	ОчиститьРеквизитыФормы();
	
КонецПроцедуры

&НаСервере
Процедура ОчиститьРеквизитыФормы(РеквизитыИсключения = Неопределено)
	
	Если РеквизитыИсключения = Неопределено Тогда
		РеквизитыИсключения = Новый Массив();
	КонецЕсли;
	
	РеквизитыИсключения.Добавить("Вид");
	РеквизитыИсключения.Добавить("Объект");
	РеквизитыИсключения.Добавить("ЭтоВО");
	РеквизитыИсключения.Добавить("ДвоичныеДанныеОбработки");
	
	МодульКода("Saby_ТНОбщегоНазначенияСервер").ОчиститьРеквизитыФормы(ЭтаФорма, РеквизитыИсключения);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьПоРегистрационномуНомеру(Команда)
	
	Если НЕ ЗначениеЗаполнено(ЭтаФорма.РегистрационныйНомер) Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = Нстр("ru = 'Необходимо заполнить Регистрационный номер!'");
		Сообщение.Поле = Элементы.РегистрационныйНомер.Имя;
		Сообщение.УстановитьДанные(ЭтаФорма);
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	Элементы.ДекорацияЗагрузкаПоРегНомеру.Видимость = Истина;
	
	РеквизитыИсключения = Новый Массив;
	РеквизитыИсключения.Добавить("РегистрационныйНомер");
	РеквизитыИсключения.Добавить("ДвоичныеДанныеОбработки");
	
	ОчиститьРеквизитыФормы(РеквизитыИсключения);
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("РегистрационныйНомер",    ЭтаФорма.РегистрационныйНомер);
	ДопПараметры.Вставить("ДвоичныеДанныеОбработки", ЭтаФорма.ДвоичныеДанныеОбработки);
	ДопПараметры.Вставить("НаКлиенте",               ЭтаФорма.ЭтоВО);
	ДопПараметры.Вставить("ОтветНаКлиенте",          Неопределено);
	  
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ВыполнитьКомандуСбис(
		ЭтаФорма,
		"ЗагрузитьДанныеТСПоРегНомеру", ,
		ДопПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьВГИБДД(Команда)
	
	Если Элементы.ДекорацияПроверкаВГИБДД.Видимость Тогда
		Возврат;
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(ЭтаФорма.ВИН) Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = Нстр("ru = 'Необходимо заполнить ВИН!'");
		Сообщение.Поле = Элементы.ВИН.Имя;
		Сообщение.УстановитьДанные(ЭтаФорма);
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	Элементы.ДекорацияПроверкаВГИБДД.Видимость = Истина;
	
	ПроверитьДанныеГИБДД();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область СлужебныеПроцедурыИФункции

#Область ЗаполнениеНаОсновании

&НаСервере
Процедура ЗаполнитьРеквизитыНаОснованииСправочника()
	
	Если Не ЗначениеЗаполнено(ЭтаФорма.ТранспортноеСредство) Тогда
		Возврат;
	КонецЕсли;
	
	МассивТС = Новый Массив;
	МассивТС.Добавить(ЭтаФорма.ТранспортноеСредство);
	РеквизитыТС = МодульКода("Saby_ТНОбщегоНазначенияСервер").РеквизитыТранспортныхСредств(МассивТС);
	РеквизитыТС = РеквизитыТС[ЭтаФорма.ТранспортноеСредство];
	
	ЗаполнитьЗначенияСвойств(ЭтаФорма, РеквизитыТС, , "Вид");
	ЗаполнитьОснованияВладенияИзСтроки(РеквизитыТС.ОснованияВладения);
	
	ОбновитьОтображениеОснованийВладения();
	
КонецПроцедуры

#КонецОбласти // ЗаполнениеНаОсновании

&НаСервере
Процедура ЗаполнитьРеквизитыИзПараметров(ДанныеЗаполнения)
		
	МодульКода("Saby_ТНОбщегоНазначенияСервер").ЗаполнитьРеквизитыФормы(ЭтаФорма, ДанныеЗаполнения);
	
	ЭтаФорма.ДвоичныеДанныеОбработки = ДанныеЗаполнения.ДвоичныеДанныеОбработки;
	
	Если Не ЗначениеЗаполнено(ЭтаФорма.Вид) Тогда
		Если ДанныеЗаполнения.ЭтоПрицеп Тогда
			ЭтаФорма.Вид = ЗначениеМетаданных("Saby_ВидыТС.Прицеп");
		Иначе
			ЭтаФорма.Вид = ЗначениеМетаданных("Saby_ВидыТС.Автомобиль");
		КонецЕсли;
	КонецЕсли;
	
	ЗагрузитьДокументыЭПД(ДанныеЗаполнения);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьОтображениеОснованийВладения()
	
	Элементы.ДокументыЭПД.Видимость = МодульКода("Перечисления.Saby_ТипыВладенияТС").ТребуетПодтвержденияВладения(
		ЭтаФорма.ТипВладения);
		
	Если Не Элементы.ДокументыЭПД.Видимость Тогда
		ЭтаФорма.ДокументыЭПД.Очистить();
	КонецЕсли;
		
КонецПроцедуры

&НаСервере
Функция ОснованияВладенияВСтроку(Знач ОснованияВладения)
	
	МассивОснований = Новый Массив;
	Для Каждого СтрокаОснованияВладения Из ОснованияВладения Цикл
		СтруктураДокументаЭПД = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").СтруктураДокументаЭПД();
		ЗаполнитьЗначенияСвойств(СтруктураДокументаЭПД, СтрокаОснованияВладения);
		СтруктураДокументаЭПД.Ссылка = СтрокаОснованияВладения.ДокументВладения;
		МассивОснований.Добавить(СтруктураДокументаЭПД);
	КонецЦикла;
	
	Если МассивОснований.Количество() > 0 Тогда
		Возврат ЗначениеВСтрокуВнутр(МассивОснований);
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьОснованияВладенияИзСтроки(ОснованияВладенияСтрокой)
	
	ДокументыЭПД.Очистить();
	
	Если Не ЗначениеЗаполнено(ОснованияВладенияСтрокой) Тогда
		Возврат;
	КонецЕсли;
	
	МассивОснований = ЗначениеИзСтрокиВнутр(ОснованияВладенияСтрокой);
	
	Для Каждого Основание Из МассивОснований Цикл
		НоваяСтрока = ДокументыЭПД.Добавить();
		НоваяСтрока.ДокументВладения = Основание.Ссылка;
	КонецЦикла;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимостьДоступностьЭлементовФормы(ТолькоПросмотр)
	
	Элементы.ГруппаЗаполнениеНаОсновании.Видимость = Не ТолькоПросмотр;
		
	УбратьДоступность = Новый Массив; 
	СкрытьВидимость   = Новый Массив;
	
	УбратьДоступность.Добавить("ФормаЗаписатьИЗакрыть");
	УбратьДоступность.Добавить("ФормаОчиститьВсеПоля");
	УбратьДоступность.Добавить("ЗаполнитьНаОсновании");
	УбратьДоступность.Добавить("ЗаполнитьПоРегистрационномуНомеру");
	УбратьДоступность.Добавить("ПроверитьВГИБДД");
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Не ТолькоПросмотр, УбратьДоступность);
	
	Если ЭтаФорма.ТипДокументаИсточника = "Saby_ПутевойЛист" Тогда
		
		СкрытьВидимость.Добавить("ГруппаВИН");
		СкрытьВидимость.Добавить("НомерСТС");
		СкрытьВидимость.Добавить("Грузоподъемность");
		СкрытьВидимость.Добавить("Вместимость");
		СкрытьВидимость.Добавить("ТипВладения");
		СкрытьВидимость.Добавить("ДокументыЭПД");
				
		Если ЭтаФорма.Вид = ЗначениеМетаданных("Saby_ВидыТС.Прицеп") Тогда
						
			СкрытьВидимость.Добавить("Тип");
			СкрытьВидимость.Добавить("ИнвентарныйНомер");
			
		КонецЕсли;
		
	Иначе
			
		СкрытьВидимость.Добавить("ИнвентарныйНомер");
		СкрытьВидимость.Добавить("Модель");
		
	КонецЕсли;
	
	Если ЭтаФорма.ЭтоВО Тогда
		СкрытьВидимость.Добавить("ДокументыЭПДДокументВладения");
	Иначе
		СкрытьВидимость.Добавить("ДокументыЭПДНаименование");
	КонецЕсли;		
	
	СкрытьВидимость.Добавить("ДекорацияЗагрузкаПоРегНомеру");
	СкрытьВидимость.Добавить("ДекорацияПроверкаВГИБДД");
	СкрытьВидимость.Добавить("ГруппаДанныеГИБДД");
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Ложь, СкрытьВидимость);
	
	Если ТолькоПросмотр Тогда 
		УстановитьТолькоПросмотр(ТолькоПросмотр);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТолькоПросмотр(ТолькоПросмотр)
	
	МассивЭлементов = Новый Массив;
	Для Каждого РеквизитФормы Из ЭтаФорма.ПолучитьРеквизиты() Цикл
		Если ЭтаФорма.Элементы.Найти(РеквизитФормы.Имя) <> Неопределено Тогда
			МассивЭлементов.Добавить(РеквизитФормы.Имя);
		КонецЕсли;		
	КонецЦикла;
	
    МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
			ЭтаФорма, "ТолькоПросмотр", Истина, МассивЭлементов);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТипыРеквизитов()
	
	МодульТНОбщегоНазначенияСервер = МодульКода("Saby_ТНОбщегоНазначенияСервер");
	
	ИмяТипаСтрока = "Строка";
	
	РазмерТипаСтрока = 32;
	ТипСтрока = Новый ОписаниеТипов(ИмяТипаСтрока, , Новый КвалификаторыСтроки(РазмерТипаСтрока));
	
	МассивТипов = Новый Массив;
	Если ЭтаФорма.ЭтоВО Тогда
		МассивТипов.Добавить(ИмяТипаСтрока);
	Иначе
		МассивТипов.Добавить("Перечисления.Saby_ТипыВладенияТС");
	КонецЕсли;
	
	МодульТНОбщегоНазначенияСервер.УстановитьОграниченияТипов(Элементы.ТипВладения, МассивТипов, ТипСтрока);
	
	Если ЭтаФорма.ЭтоВО Тогда
		
		Элементы.ТипВладения.РежимВыбораИзСписка = Истина;
		Элементы.ТипВладения.КнопкаВыпадающегоСписка = Истина;
		Элементы.ТипВладения.СписокВыбора.Добавить("Собственность");
		Элементы.ТипВладения.СписокВыбора.Добавить("СовместнаяСобственностьСупругов", "Совместная собственность супругов");
		Элементы.ТипВладения.СписокВыбора.Добавить("Аренда");
		Элементы.ТипВладения.СписокВыбора.Добавить("Лизинг");
		Элементы.ТипВладения.СписокВыбора.Добавить("БезвозмездноеПользование", "Безвозмездное пользование");
		
	КонецЕсли;
	
	МассивТипов.Очистить();
	
	МассивТипов.Добавить("Справочники.уатТС");
	МассивТипов.Добавить("Справочники.ТранспортныеСредства");
	МодульТНОбщегоНазначенияСервер.УстановитьОграниченияТипов(Элементы.ТранспортноеСредство, МассивТипов);
	
	МассивТипов.Очистить();
	Если ЭтаФорма.ЭтоВО Тогда
		МассивТипов.Добавить(ИмяТипаСтрока);
	Иначе 
		МассивТипов.Добавить("Справочники.Saby_ДокументыЭПД");
	КонецЕсли;

	МодульТНОбщегоНазначенияСервер.УстановитьОграниченияТипов(Элементы.ДокументыЭПДДокументВладения, МассивТипов);
	
	ПараметрВыбора = Новый ПараметрВыбора("Отбор.Тип", ЗначениеМетаданных("Saby_ТипыДокумента.ПодтверждениеВладения"));
	ПараметрыВыбора = Новый Массив;
	ПараметрыВыбора.Добавить(ПараметрВыбора);
	ПараметрыВыбора = Новый ФиксированныйМассив(ПараметрыВыбора);
	Элементы.ДокументыЭПДДокументВладения.ПараметрыВыбора = ПараметрыВыбора;
	
КонецПроцедуры

&НаКлиенте
Процедура ПроверитьДанныеГИБДД()
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("ВИН",                     ЭтаФорма.ВИН);
	ДопПараметры.Вставить("ДвоичныеДанныеОбработки", ЭтаФорма.ДвоичныеДанныеОбработки);
	ДопПараметры.Вставить("НаКлиенте",               ЭтаФорма.ЭтоВО);
	ДопПараметры.Вставить("ОтветНаКлиенте",          Неопределено);
	
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ВыполнитьКомандуСбис(
		ЭтаФорма,
		"ЗагрузитьДанныеТСПоВИН", ,
		ДопПараметры);
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьРезультатЗагрузкиДанныхТСПоРегНомеру(Результат) Экспорт
	
	Элементы.ДекорацияЗагрузкаПоРегНомеру.Видимость = Ложь;
	
	Если ТипЗнч(Результат) = Тип("Строка") Тогда
		Сообщение = Новый СообщениеПользователю;
		Сообщение.Текст = Результат;
		Сообщение.Сообщить();
		Возврат;
	КонецЕсли;
	
	ЭтаФорма.Тип              = Результат["PassportTypeName"];
	ЭтаФорма.ВИН              = Результат["VIN"];
	ЭтаФорма.НомерСТС         = Результат["RegCertNumber"];
	ЭтаФорма.Идентификатор    = Результат["UUID"];
	ЭтаФорма.ИнвентарныйНомер = Результат["GarageNumber"];
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработатьРезультатЗагрузкиДанныхТСПоВИН(Результат) Экспорт
	
	СтатусОтвета = Результат["Status"];
	
	ЗапросВыполнен = СтатусОтвета = "Выполнено";
	НетИнформации  = СтатусОтвета = "По указанному VIN не найдена информация о транспортном средстве";
	
	ЗаголовокПоУмолчанию = "Данные из ГИБДД еще не получены. Необходимо повторить проверку позже"
		+ Символы.ПС
		+ "Статус запроса: ";
		
	ВыполнениеЗавершено = ЗапросВыполнен Или НетИнформации;
		
	Элементы.ДекорацияПроверкаВГИБДД.Видимость      = Не ВыполнениеЗавершено;
	Элементы.ГруппаДанныеГИБДД.Видимость            = Истина;
	Элементы.ДанныеГИБДД.Видимость                  = ЗапросВыполнен;
	Элементы.ДекорацияОжиданиеДанныхГИБДД.Видимость = Не ЗапросВыполнен Или НетИнформации;
	Элементы.ДекорацияОжиданиеДанныхГИБДД.Заголовок = ?(НетИнформации, "", ЗаголовокПоУмолчанию) + СтатусОтвета;
	
	Если ВыполнениеЗавершено Тогда
		ОтключитьОбработчикОжидания("ПроверитьДанныеГИБДД");
	Иначе
		ПодключитьОбработчикОжидания("ПроверитьДанныеГИБДД", 30);
	КонецЕсли;
	
	Если Не ЗапросВыполнен Тогда
		Возврат;
	КонецЕсли;
	
	ДанныеТС = Результат["Vehicle"];
	
	ЭтаФорма.ДанныеГИБДД.Очистить();
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Номер кузова";
	СтрокаДанных.Значение = ДанныеТС["BodyNumber"];
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "ВИН";
	СтрокаДанных.Значение = ДанныеТС["VIN"];
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Категория";
	СтрокаДанных.Значение = ДанныеТС["Category"];
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Цвет";
	СтрокаДанных.Значение = ДанныеТС["Color"];
	
	МодельГИБДД = ДанныеТС["Model"];
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Модель";
	СтрокаДанных.Значение = МодельГИБДД;
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Номер двигателя";
	СтрокаДанных.Значение = ДанныеТС["EngineNumber"];
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Объем двигателя";
	СтрокаДанных.Значение = ДанныеТС["EngineVolume"];
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Мощность, л.с.";
	СтрокаДанных.Значение = ДанныеТС["PowerHp"];
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Мощность, кВт";
	СтрокаДанных.Значение = ДанныеТС["PowerKwt"];
	
	ТипГИБДД = ДанныеТС["TypeVerbose"];
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Тип";
	СтрокаДанных.Значение = ТипГИБДД;
	
	СтрокаДанных = ЭтаФорма.ДанныеГИБДД.Добавить();
	СтрокаДанных.Реквизит = "Год";
	СтрокаДанных.Значение = ДанныеТС["Year"];
	
	Если Не ЗначениеЗаполнено(ЭтаФорма.Модель) Тогда
		ЭтаФорма.Модель = МодельГИБДД;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ЭтаФорма.Марка) Тогда
		ЭтаФорма.Марка = МодельГИБДД;
	КонецЕсли;
	
	Если Не ЗначениеЗаполнено(ЭтаФорма.Тип) Тогда
		ЭтаФорма.Тип = ТипГИБДД;
	КонецЕсли;
	
КонецПроцедуры

#Область include_etrn_base_CommonForm_ТранспортноеСредствоЭПД_СлужебныеПроцедурыИФункции
#КонецОбласти // include_etrn_base_CommonForm_ТранспортноеСредствоЭПД_СлужебныеПроцедурыИФункции

#КонецОбласти // СлужебныеПроцедурыИФункции
