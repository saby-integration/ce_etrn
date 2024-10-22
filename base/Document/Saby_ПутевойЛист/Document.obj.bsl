
#Область ОбработчикиСобытий

Процедура ПередЗаписью(Отказ, РежимЗаписи, РежимПроведения)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
		
	ЭтотОбъект.ТранспортноеСредство_РегНомер = 
		Saby_ТНОбщегоНазначенияСервер.ТранспортныеСредстваСтрокой(ЭтотОбъект);
	
	ЗаполнитьРеквизитыДляФормыСписка();
		
КонецПроцедуры

Процедура ПриЗаписи(Отказ)
	
	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	Если ДополнительныеСвойства.Свойство("ТитулыДляПривязки") Тогда
		РегистрыСведений.Saby_ДанныеТитулов.ПривязатьТитулыКДокументу(
			Ссылка,
			ДополнительныеСвойства.ТитулыДляПривязки);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриКопировании(ОбъектКопирования)
	
	РеквизитыДляОчистки = Новый Массив;
	
	// Служебные 
	РеквизитыДляОчистки.Добавить("ДатаИзменения");
	РеквизитыДляОчистки.Добавить("НомерСбис");
	РеквизитыДляОчистки.Добавить("Комментарий");
	РеквизитыДляОчистки.Добавить("КомментарийУведомление");
	РеквизитыДляОчистки.Добавить("ТекущиеЭтапы");
	РеквизитыДляОчистки.Добавить("ПЛПредыдущий");
	РеквизитыДляОчистки.Добавить("ПЛСледующий");
	РеквизитыДляОчистки.Добавить("ДокументОснование_Идентификатор");
	РеквизитыДляОчистки.Добавить("ДокументОснование_ОбъектМетаданных");
	
	// Предрейсовый МО
	РеквизитыДляОчистки.Добавить("ДоРейса_ДатаВремяМедосмотра");
	РеквизитыДляОчистки.Добавить("ДоРейса_КомментарииМедосмотра");
	РеквизитыДляОчистки.Добавить("ДоРейса_НеДопущенПослеМедосмотра");
	
	// ТО
	РеквизитыДляОчистки.Добавить("ТО_ДатаВремя");
	РеквизитыДляОчистки.Добавить("ТО_ДатаВремяВыпускаВРейс");
	РеквизитыДляОчистки.Добавить("ТО_Комментарий");
	РеквизитыДляОчистки.Добавить("ТО_НеРазрешенВыпускПосле");
	
	// Выезд
	РеквизитыДляОчистки.Добавить("Выезд_ДатаВремя");
	РеквизитыДляОчистки.Добавить("Выезд_Одометр");
	РеквизитыДляОчистки.Добавить("Выезд_ОдометрКомментарии");
	
	// Заезд
	РеквизитыДляОчистки.Добавить("Заезд_ДатаВремя");
	РеквизитыДляОчистки.Добавить("Заезд_Одометр");
	РеквизитыДляОчистки.Добавить("Заезд_ОдометрКомментарии");

	Saby_ТНОбщегоНазначенияСервер.ОчисткаРеквизитовОбъекта(ЭтотОбъект, РеквизитыДляОчистки);
	
	// Записи по ответственным
	Saby_ТНОбщегоНазначенияКлиентСервер.УдалитьСтрокиПоРоли(ЭтотОбъект.ОтветственныеЛица, "ОдометрВыезд", Истина);
	Saby_ТНОбщегоНазначенияКлиентСервер.УдалитьСтрокиПоРоли(ЭтотОбъект.ОтветственныеЛица, "ОдометрЗаезд", Истина);
	
	Если ДоРейса_МедосмотрСторонняяОрганизация Тогда
		Saby_ТНОбщегоНазначенияКлиентСервер.УдалитьСтрокиПоРоли(ЭтотОбъект.ОтветственныеЛица, "МедосмотрВыезд", Истина);		
	КонецЕсли;	
		
	Если ПослеРейса_МедосмотрСторонняяОрганизация Тогда
		Saby_ТНОбщегоНазначенияКлиентСервер.УдалитьСтрокиПоРоли(ЭтотОбъект.ОтветственныеЛица, "МедосмотрЗаезд", Истина);
	КонецЕсли;	
	
	// Установим дефолтные значения
	ЭтотОбъект.ПризнакНачалаРейса = Перечисления.Saby_ПризнакНачалаРейса.ВыездСПарковки;
	
КонецПроцедуры

Процедура ОбработкаЗаполнения(ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)
	
	ТипЗначенияЗаполнения = ТипЗнч(ДанныеЗаполнения);
	
	Если ТипЗначенияЗаполнения = Тип("ДокументСсылка.Saby_ПутевойЛист") Тогда
		ЗаполнитьНаОснованииПутевогоЛиста(ДанныеЗаполнения);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПриУстановкеНовогоНомера(СтандартнаяОбработка, Префикс)
	
	Префикс = "00";
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытий 

#Область СлужебныеПроцедурыИФункции

Процедура ЗаполнитьРеквизитыДляФормыСписка()
	
	ЗаполнитьОтветственныхЛиц();
	
	ЭтотОбъект.Организация = Saby_ТНОбщегоНазначенияКлиентСервер.ДанныеЮрЛицаПоРоли(
		ЭтотОбъект.ДанныеЮрЛиц, "Оформитель").НаименованиеОрганизации;
	
КонецПроцедуры

Процедура ЗаполнитьОтветственныхЛиц()
	
	ЗаполнитьОтветственногоМедосмотр();
	
	РольВодитель = Перечисления.Saby_РолиОтветственных.Водитель;
	РольМеханик  = Перечисления.Saby_РолиОтветственных.Техосмотр;
	
	СтруктураОтветственных = Новый Структура;
	СтруктураОтветственных.Вставить("Водитель",  "");
	СтруктураОтветственных.Вставить("Техосмотр", "");
		
	Для Каждого ОтветственноеЛицо Из ОтветственныеЛица Цикл		
		
		ПодходящаяРоль = (ОтветственноеЛицо.Роль = РольВодитель 
			Или ОтветственноеЛицо.Роль = РольМеханик);
		
		Если ПодходящаяРоль Тогда			
			
			РольСтрокой = СокрЛП(ОтветственноеЛицо.Роль);
			НаименованиеСтрокой = Saby_ТНОбщегоНазначенияКлиентСервер.ПредставлениеФИО(ОтветственноеЛицо);
			
			СтруктураОтветственных[РольСтрокой] = НаименованиеСтрокой;
			
		Иначе 		
			Продолжить;
		КонецЕсли;
		
	КонецЦикла;
	
	ЭтотОбъект.Водитель = СтруктураОтветственных.Водитель;
	ЭтотОбъект.Механик  = СтруктураОтветственных.Техосмотр;
	
КонецПроцедуры

Процедура ЗаполнитьОтветственногоМедосмотр()
	
	Если ЭтотОбъект.ДоРейса_МедосмотрСторонняяОрганизация Тогда
		ЭтотОбъект.Медик = Saby_ТНОбщегоНазначенияКлиентСервер.ДанныеЮрЛицаПоРоли(
			ЭтотОбъект.ДанныеЮрЛиц, "МедосмотрВыезд").НаименованиеОрганизации;
	Иначе
		
		РольМедик = Перечисления.Saby_РолиОтветственных.МедосмотрВыезд;
		
		Отбор = Новый Структура;
		Отбор.Вставить("Роль", РольМедик);
		
		НайденныеСтроки = Saby_ТНОбщегоНазначенияКлиентСервер.НайтиСтрокиУниверсально(ЭтотОбъект.ОтветственныеЛица, Отбор);
		Если НайденныеСтроки.Количество() Тогда
			Значение = Saby_ТНОбщегоНазначенияКлиентСервер.ПредставлениеФИО(НайденныеСтроки[0]);
		Иначе 	
			Значение = "";
		КонецЕсли;	
		
		ЭтотОбъект.Медик = Значение;
		
	КонецЕсли;
		
КонецПроцедуры

#Область ЗаполнениеНаОснованииПутевогоЛиста

Процедура ЗаполнитьНаОснованииПутевогоЛиста(ДанныеЗаполнения)
	
	ДанныеСостояния = Saby_ТНОбщегоНазначенияСервер.ДанныеСостоянияОбъекта(ДанныеЗаполнения);	
	Если Не ЗначениеЗаполнено(ДанныеСостояния) 
		Или Не ЗначениеЗаполнено(ДанныеСостояния.UID) Тогда
		
		ВызватьИсключение("Документ не найден в SABY! Проверьте данные авторизации и статус документа");
		
	Иначе 	
		ЭтотОбъект.ПЛПредыдущий = ДанныеСостояния.UID;
	КонецЕсли;	
			
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ
	|	Saby_ПутевойЛист.ВидПеревозки КАК ВидПеревозки,
	|	Saby_ПутевойЛист.ВидТранспортногоСообщения КАК ВидТранспортногоСообщения,
	|	Saby_ПутевойЛист.МестоОтправления КАК МестоОтправления,
	|	Saby_ПутевойЛист.Организация КАК Организация,
	|	ЗНАЧЕНИЕ(Перечисление.Saby_ПризнакНачалаРейса.ПриемСдачаПослеСмены) КАК ПризнакНачалаРейса,
	|	Saby_ПутевойЛист.ПослерейсовыйМедосмотрТребуется КАК ПослерейсовыйМедосмотрТребуется,
	|	Saby_ПутевойЛист.ВидКоммерческойПеревозки КАК ВидКоммерческойПеревозки,
	|	Saby_ПутевойЛист.ДатаНачалаИсполнения КАК ДатаНачалаИсполнения,
	|	Saby_ПутевойЛист.ДатаОкончанияИсполнения КАК ДатаОкончанияИсполнения,
	|	Saby_ПутевойЛист.ДоРейса_МедосмотрСторонняяОрганизация КАК ДоРейса_МедосмотрСторонняяОрганизация,
	|	Saby_ПутевойЛист.ПослеРейса_МедосмотрСторонняяОрганизация КАК ПослеРейса_МедосмотрСторонняяОрганизация
	|ИЗ
	|	Документ.Saby_ПутевойЛист КАК Saby_ПутевойЛист
	|ГДЕ
	|	Saby_ПутевойЛист.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	""ОтветственныеЛица"" КАК ИмяТабличнойЧасти,
	|	Saby_ПутевойЛистОтветственныеЛица.НомерСтроки КАК НомерСтроки,
	|	Saby_ПутевойЛистОтветственныеЛица.КлючСтроки КАК КлючСтроки,
	|	Saby_ПутевойЛистОтветственныеЛица.ИНН КАК ИНН,
	|	Saby_ПутевойЛистОтветственныеЛица.Серия КАК Серия,
	|	Saby_ПутевойЛистОтветственныеЛица.Номер КАК Номер,
	|	Saby_ПутевойЛистОтветственныеЛица.ДатаВыдачи КАК ДатаВыдачи,
	|	Saby_ПутевойЛистОтветственныеЛица.Фамилия КАК Фамилия,
	|	Saby_ПутевойЛистОтветственныеЛица.Имя КАК Имя,
	|	Saby_ПутевойЛистОтветственныеЛица.Отчество КАК Отчество,
	|	Saby_ПутевойЛистОтветственныеЛица.Телефоны КАК Телефоны,
	|	Saby_ПутевойЛистОтветственныеЛица.Роль КАК Роль,
	|	Saby_ПутевойЛистОтветственныеЛица.ДатаОкончанияДействия КАК ДатаОкончанияДействия,
	|	Saby_ПутевойЛистОтветственныеЛица.ЭлектроннаяПочта КАК ЭлектроннаяПочта,
	|	Saby_ПутевойЛистОтветственныеЛица.Должность КАК Должность,
	|	Saby_ПутевойЛистОтветственныеЛица.ШтатныйСотрудник КАК ШтатныйСотрудник
	|ИЗ
	|	Документ.Saby_ПутевойЛист.ОтветственныеЛица КАК Saby_ПутевойЛистОтветственныеЛица
	|ГДЕ
	|	Saby_ПутевойЛистОтветственныеЛица.Ссылка = &Ссылка
	|	И Saby_ПутевойЛистОтветственныеЛица.Роль <> &РольТехосмотр
	|	И Saby_ПутевойЛистОтветственныеЛица.Роль <> &РольВодитель
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	""ТранспортныеСредства"" КАК ИмяТабличнойЧасти,
	|	Saby_ПутевойЛистТранспортныеСредства.НомерСтроки КАК НомерСтроки,
	|	Saby_ПутевойЛистТранспортныеСредства.Вид КАК Вид,
	|	Saby_ПутевойЛистТранспортныеСредства.РегистрационныйНомер КАК РегистрационныйНомер,
	|	Saby_ПутевойЛистТранспортныеСредства.Тип КАК Тип,
	|	Saby_ПутевойЛистТранспортныеСредства.Марка КАК Марка,
	|	Saby_ПутевойЛистТранспортныеСредства.Модель КАК Модель,
	|	Saby_ПутевойЛистТранспортныеСредства.ИнвентарныйНомер КАК ИнвентарныйНомер
	|ИЗ
	|	Документ.Saby_ПутевойЛист.ТранспортныеСредства КАК Saby_ПутевойЛистТранспортныеСредства
	|ГДЕ
	|	Saby_ПутевойЛистТранспортныеСредства.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	""АдресаПунктовВыгрузки"" КАК ИмяТабличнойЧасти,
	|	Saby_ПутевойЛистАдресаПунктовВыгрузки.НомерСтроки КАК НомерСтроки,
	|	Saby_ПутевойЛистАдресаПунктовВыгрузки.Значение КАК Значение,
	|	Saby_ПутевойЛистАдресаПунктовВыгрузки.Структура КАК Структура,
	|	Saby_ПутевойЛистАдресаПунктовВыгрузки.КлючСтроки КАК КлючСтроки
	|ИЗ
	|	Документ.Saby_ПутевойЛист.АдресаПунктовВыгрузки КАК Saby_ПутевойЛистАдресаПунктовВыгрузки
	|ГДЕ
	|	Saby_ПутевойЛистАдресаПунктовВыгрузки.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	""ДанныеЮрЛиц"" КАК ИмяТабличнойЧасти,
	|	Saby_ПутевойЛистДанныеЮрЛиц.НомерСтроки КАК НомерСтроки,
	|	Saby_ПутевойЛистДанныеЮрЛиц.Роль КАК Роль,
	|	Saby_ПутевойЛистДанныеЮрЛиц.ИНН КАК ИНН,
	|	Saby_ПутевойЛистДанныеЮрЛиц.КПП КАК КПП,
	|	Saby_ПутевойЛистДанныеЮрЛиц.ОГРН КАК ОГРН,
	|	Saby_ПутевойЛистДанныеЮрЛиц.ЮрФизЛицо КАК ЮрФизЛицо,
	|	Saby_ПутевойЛистДанныеЮрЛиц.СтруктураФИО КАК СтруктураФИО,
	|	Saby_ПутевойЛистДанныеЮрЛиц.Адрес КАК Адрес,
	|	Saby_ПутевойЛистДанныеЮрЛиц.АдресСтруктура КАК АдресСтруктура,
	|	Saby_ПутевойЛистДанныеЮрЛиц.СтранаРегистрации КАК СтранаРегистрации,
	|	Saby_ПутевойЛистДанныеЮрЛиц.КодФилиала КАК КодФилиала,
	|	Saby_ПутевойЛистДанныеЮрЛиц.НаименованиеОрганизации КАК НаименованиеОрганизации,
	|	Saby_ПутевойЛистДанныеЮрЛиц.КлючСтроки КАК КлючСтроки
	|ИЗ
	|	Документ.Saby_ПутевойЛист.ДанныеЮрЛиц КАК Saby_ПутевойЛистДанныеЮрЛиц
	|ГДЕ
	|	Saby_ПутевойЛистДанныеЮрЛиц.Ссылка = &Ссылка
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	""КонтактныеДанные"" КАК ИмяТабличнойЧасти,
	|	Saby_ПутевойЛистКонтактныеДанные.НомерСтроки КАК НомерСтроки,
	|	Saby_ПутевойЛистКонтактныеДанные.Роль КАК Роль,
	|	Saby_ПутевойЛистКонтактныеДанные.Тип КАК Тип,
	|	Saby_ПутевойЛистКонтактныеДанные.Значение КАК Значение,
	|	Saby_ПутевойЛистКонтактныеДанные.Структура КАК Структура,
	|	Saby_ПутевойЛистКонтактныеДанные.КлючСтроки_ДанныеЮрЛиц КАК КлючСтроки_ДанныеЮрЛиц
	|ИЗ
	|	Документ.Saby_ПутевойЛист.КонтактныеДанные КАК Saby_ПутевойЛистКонтактныеДанные
	|ГДЕ
	|	Saby_ПутевойЛистКонтактныеДанные.Ссылка = &Ссылка";
	
	ЗапросДанных.УстановитьПараметр("Ссылка",        ДанныеЗаполнения);
	ЗапросДанных.УстановитьПараметр("РольТехосмотр", Перечисления.Saby_РолиОтветственных.Техосмотр);
	ЗапросДанных.УстановитьПараметр("РольВодитель",  Перечисления.Saby_РолиОтветственных.Водитель);
	
	Результат = ЗапросДанных.ВыполнитьПакет();
	ВыборкаРеквизитов = Результат[0].Выбрать();
	
	Если ВыборкаРеквизитов.Следующий() Тогда
		ЗаполнитьЗначенияСвойств(ЭтотОбъект, ВыборкаРеквизитов);
	КонецЕсли;
	
	Для Индекс = 1 По Результат.ВГраница() Цикл
		
		ВыборкаТабличнойЧасти = Результат[Индекс].Выбрать();
		
		Пока ВыборкаТабличнойЧасти.Следующий() Цикл
			
			СтрокаТабличнойЧасти = ЭтотОбъект[ВыборкаТабличнойЧасти.ИмяТабличнойЧасти].Добавить();
			ЗаполнитьЗначенияСвойств(СтрокаТабличнойЧасти, ВыборкаТабличнойЧасти);
			
		КонецЦикла;
		
	КонецЦикла;
	
	ЭтотОбъект.ДокументОснование_Идентификатор    = ДанныеЗаполнения.УникальныйИдентификатор();
	ЭтотОбъект.ДокументОснование_ОбъектМетаданных = Saby_ТНОбщегоНазначенияСервер.ИмяМетаданныхДокумента(
		ДанныеЗаполнения);
				
КонецПроцедуры

#КонецОбласти // ЗаполнениеНаОснованииПутевогоЛиста

#КонецОбласти // СлужебныеПроцедурыИФункции
