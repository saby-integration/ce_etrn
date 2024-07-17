
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьРеквизитыИзПараметров(Параметры);
	
	ОбновитьВидимостьДоступностьЭлементовФормы(Параметры.ТолькоПросмотр);
	
	Если Параметры.Свойство("ОснованияВладения") Тогда
		ЗаполнитьОснованияВладенияИзСтроки(Параметры.ОснованияВладения);
	КонецЕсли;
	
	ОбновитьОтображениеОснованийВладения();
	
	УстановитьОграничениеТипаСсылки();
	
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

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	// проверка заполнения
	Если Не ЗначениеЗаполнено(ЭтаФорма.РегистрационныйНомер) Тогда 
		
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "Ошибка записи! Укажите регистрационный номер ТС или прицепа";
		Сообщение.Поле  = "РегистрационныйНомер";
		Сообщение.УстановитьДанные(ЭтотОбъект);
		Сообщение.Сообщить();
		
		Возврат;
		
	КонецЕсли;	
		
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
	
	СтруктураТранспортногоСредства.Вставить(
		"ОснованияВладения", ОснованияВладенияВСтроку(ЭтаФорма.ОснованияВладения));
	
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
Процедура ОчиститьРеквизитыФормы() 
	
	РеквизитыИсключения = Новый Массив();
	РеквизитыИсключения.Добавить("Вид");
	
	Saby_ТНОбщегоНазначенияСервер.ОчиститьРеквизитыФормы(ЭтаФорма, РеквизитыИсключения);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область СлужебныеПроцедурыИФункции

#Область ЗаполнениеНаОсновании

&НаСервере
Процедура ЗаполнитьРеквизитыНаОснованииСправочника()
	
	Если Не ЗначениеЗаполнено(ЭтотОбъект.ТранспортноеСредство) Тогда
		Возврат;
	КонецЕсли;
	
	МассивТС = Новый Массив;
	МассивТС.Добавить(ЭтотОбъект.ТранспортноеСредство);
	РеквизитыТС = Saby_ТНОбщегоНазначенияСервер.РеквизитыТранспортныхСредств(МассивТС);
	РеквизитыТС = РеквизитыТС[ЭтотОбъект.ТранспортноеСредство];
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, РеквизитыТС, , "ОснованияВладения,Вид");
	ЗаполнитьОснованияВладенияИзСтроки(РеквизитыТС.ОснованияВладения);
	
	ОбновитьОтображениеОснованийВладения();
	
КонецПроцедуры

#КонецОбласти // ЗаполнениеНаОсновании

&НаСервере
Процедура ЗаполнитьРеквизитыИзПараметров(ДанныеЗаполнения)
	
	РеквизитыИсключения = Новый Массив;
	РеквизитыИсключения.Добавить("ОснованияВладения");
	
	Saby_ТНОбщегоНазначенияСервер.ЗаполнитьРеквизитыФормы(ЭтаФорма, ДанныеЗаполнения, РеквизитыИсключения);
	
	Если ЭтотОбъект.Вид.Пустая() Тогда
		Если ДанныеЗаполнения.ЭтоПрицеп Тогда
			ЭтотОбъект.Вид = Перечисления.Saby_ВидыТС.Прицеп;
		Иначе
			ЭтотОбъект.Вид = Перечисления.Saby_ВидыТС.Автомобиль;
		КонецЕсли;
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьОтображениеОснованийВладения()
	
	Элементы.ОснованияВладения.Видимость = Перечисления.Saby_ТипыВладенияТС.ТребуетПодтвержденияВладения(
		ЭтотОбъект.ТипВладения);
	
КонецПроцедуры

&НаСервереБезКонтекста
Функция ОснованияВладенияВСтроку(Знач ОснованияВладения)
	
	МассивОснований = Новый Массив;
	Для Каждого СтрокаОснованияВладения Из ОснованияВладения Цикл
		МассивОснований.Добавить(СтрокаОснованияВладения.ДокументВладения);
	КонецЦикла;
	
	Если МассивОснований.Количество() > 0 Тогда
		Возврат ЗначениеВСтрокуВнутр(МассивОснований);
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

&НаСервере
Процедура ЗаполнитьОснованияВладенияИзСтроки(ОснованияВладенияСтрокой)
	
	ОснованияВладения.Очистить();
	
	Если Не ЗначениеЗаполнено(ОснованияВладенияСтрокой) Тогда
		Возврат;
	КонецЕсли;
	
	МассивОснований = ЗначениеИзСтрокиВнутр(ОснованияВладенияСтрокой);
	
	Для Каждого Основание Из МассивОснований Цикл
		НоваяСтрока = ОснованияВладения.Добавить();
		НоваяСтрока.ДокументВладения = Основание;
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
	
	Saby_ТНОбщегоНазначенияКлиентСервер.ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Доступность", Не ТолькоПросмотр, УбратьДоступность);
	
	Если ЭтаФорма.ТипДокументаИсточника = Тип("ДокументСсылка.Saby_ПутевойЛист") Тогда
		
		СкрытьВидимость.Добавить("ВИН");
		СкрытьВидимость.Добавить("НомерСТС");
		СкрытьВидимость.Добавить("Грузоподъемность");
		СкрытьВидимость.Добавить("Вместимость");
		СкрытьВидимость.Добавить("ТипВладения");
		СкрытьВидимость.Добавить("ОснованияВладения");
				
		Если ЭтаФорма.Вид = Перечисления.Saby_ВидыТС.Прицеп Тогда
						
			СкрытьВидимость.Добавить("Тип");
			СкрытьВидимость.Добавить("ИнвентарныйНомер");
			
		КонецЕсли;
		
	Иначе
			
		СкрытьВидимость.Добавить("ИнвентарныйНомер");
		СкрытьВидимость.Добавить("Модель");
		
	КонецЕсли;
			
	Saby_ТНОбщегоНазначенияКлиентСервер.ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Ложь, СкрытьВидимость);
	
	Если ТолькоПросмотр Тогда 
		УстановитьТолькоПросмотр(ТолькоПросмотр);
		Возврат;
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
	
    Saby_ТНОбщегоНазначенияКлиентСервер.ИзменитьСвойствоЭлементовФормы(
			ЭтаФорма, "ТолькоПросмотр", Истина, МассивЭлементов);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОграничениеТипаСсылки()
	
	ИмяКонфигурации = Saby_ТНОбщегоНазначенияСервер.ИмяКонфигурации();
	ДоступныеКонфигурации = Saby_ТНОбщегоНазначенияСервер.ДоступныеКонфигурации();
	
	Если ИмяКонфигурации = ДоступныеКонфигурации.УАТ Тогда
		Элементы.ТранспортноеСредство.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.уатТС");
	Иначе
		Элементы.ТранспортноеСредство.ОграничениеТипа = Новый ОписаниеТипов("СправочникСсылка.ТранспортныеСредства");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // СлужебныеПроцедурыИФункции
