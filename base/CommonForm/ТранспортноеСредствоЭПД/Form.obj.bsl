
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
		Элемент.ТекущиеДанные.КлючСтроки = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").НовыйКлючОсновнойСтроки(
			ЭтаФорма, "ДокументыЭПД");
		Элемент.ТекущиеДанные.Тип = ЗначениеМетаданных("Saby_ТипыДокумента.ПодтверждениеВладения");
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
	
	СтруктураТранспортногоСредства.Вставить(
		"ОснованияВладения", ОснованияВладенияВСтроку(ЭтаФорма.ДокументыЭПД));
	
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
	
	ОчиститьРеквизитыФормы(РеквизитыИсключения);
	
	ДопПараметры = Новый Структура;
	ДопПараметры.Вставить("РегистрационныйНомер", ЭтаФорма.РегистрационныйНомер);
	  
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
	
	Если Не ЗначениеЗаполнено(ЭтотОбъект.ТранспортноеСредство) Тогда
		Возврат;
	КонецЕсли;
	
	МассивТС = Новый Массив;
	МассивТС.Добавить(ЭтотОбъект.ТранспортноеСредство);
	РеквизитыТС = МодульКода("Saby_ТНОбщегоНазначенияСервер").РеквизитыТранспортныхСредств(МассивТС);
	РеквизитыТС = РеквизитыТС[ЭтотОбъект.ТранспортноеСредство];
	
	ЗаполнитьЗначенияСвойств(ЭтотОбъект, РеквизитыТС, , "Вид");
	ЗаполнитьОснованияВладенияИзСтроки(РеквизитыТС.ОснованияВладения);
	
	ОбновитьОтображениеОснованийВладения();
	
КонецПроцедуры

#КонецОбласти // ЗаполнениеНаОсновании

&НаСервере
Процедура ЗаполнитьРеквизитыИзПараметров(ДанныеЗаполнения)
	
	РеквизитыИсключения = Новый Массив;
	РеквизитыИсключения.Добавить("ДокументыЭПД");
	
	МодульКода("Saby_ТНОбщегоНазначенияСервер").ЗаполнитьРеквизитыФормы(ЭтаФорма, ДанныеЗаполнения, РеквизитыИсключения);
	
	Если Не ЗначениеЗаполнено(ЭтотОбъект.Вид) Тогда
		Если ДанныеЗаполнения.ЭтоПрицеп Тогда
			ЭтотОбъект.Вид = ЗначениеМетаданных("Saby_ВидыТС.Прицеп");
		Иначе
			ЭтотОбъект.Вид = ЗначениеМетаданных("Saby_ВидыТС.Автомобиль");
		КонецЕсли;
	КонецЕсли;
	
	ЗагрузитьДокументыЭПД(ДанныеЗаполнения);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьОтображениеОснованийВладения()
	
	Элементы.ДокументыЭПД.Видимость = МодульКода("Перечисления.Saby_ТипыВладенияТС").ТребуетПодтвержденияВладения(
		ЭтотОбъект.ТипВладения);
		
	Если Не Элементы.ДокументыЭПД.Видимость Тогда
		ЭтаФорма.ДокументыЭПД.Очистить();
	КонецЕсли;
		
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
	
	ДокументыЭПД.Очистить();
	
	Если Не ЗначениеЗаполнено(ОснованияВладенияСтрокой) Тогда
		Возврат;
	КонецЕсли;
	
	МассивОснований = ЗначениеИзСтрокиВнутр(ОснованияВладенияСтрокой);
	
	Для Каждого Основание Из МассивОснований Цикл
		НоваяСтрока = ДокументыЭПД.Добавить();
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
	УбратьДоступность.Добавить("ЗаполнитьПоРегистрационномуНомеру");
	УбратьДоступность.Добавить("ПроверитьВГИБДД");
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Доступность", Не ТолькоПросмотр, УбратьДоступность);
	
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
	
	ТипСтрока = Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(32));
	
    МассивТипов = Новый Массив;
	МассивТипов.Добавить("Перечисления.Saby_ТипыВладенияТС");
	МодульТНОбщегоНазначенияСервер.УстановитьОграниченияТипов(Элементы.ТипВладения, МассивТипов, ТипСтрока);
	
	Если Элементы.ТипВладения.ОграничениеТипа.СодержитТип(Тип("Строка")) Тогда
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
	МассивТипов.Добавить("Справочники.Saby_ДокументыЭПД");
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
	ДопПараметры.Вставить("ВИН", ЭтаФорма.ВИН);
	
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
