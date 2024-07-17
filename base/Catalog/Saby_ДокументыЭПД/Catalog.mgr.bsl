
#Область СлужебныйПрограммныйИнтерфейс

Функция ПеренестиДанныеСторонНепосредственноВДокумент() Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("ОК",             Истина);
	РезультатФункции.Вставить("ОписаниеОшибки", "");
	
	// Реквизита со ссылкой больше нет, поэтому делать ничего не надо.
	Если ПустаяСсылка().Метаданные().ТабличныеЧасти.ДанныеЮрЛиц.Реквизиты.Найти("Сторона") = Неопределено Тогда
		Возврат РезультатФункции;
	КонецЕсли;
	
	СоответствиеДанныхПоСсылкам = Новый Соответствие;
	ДобавитьДанныеПоКонтрагентамИОрганизациям(СоответствиеДанныхПоСсылкам);
	ДобавитьДанныеПоСторонамДокумента(СоответствиеДанныхПоСсылкам);
	
	ЗаполнитьДанныеСторонПоСсылкам(СоответствиеДанныхПоСсылкам);
	
	Возврат РезультатФункции;
	
КонецФункции

#КонецОбласти // СлужебныйПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьДанныеПоКонтрагентамИОрганизациям(СоответствиеДанныхПоСсылкам)
	
	РольСторонаДокумента = Перечисления.Saby_РолиКонтрагентов.СторонаДокумента;
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	Saby_ДокументыЭПДДанныеЮрЛиц.Сторона КАК Сторона
	|ИЗ
	|	Справочник.Saby_ДокументыЭПД.ДанныеЮрЛиц КАК Saby_ДокументыЭПДДанныеЮрЛиц
	|ГДЕ
	|	Saby_ДокументыЭПДДанныеЮрЛиц.Роль = ЗНАЧЕНИЕ(Перечисление.Saby_РолиКонтрагентов.ПустаяСсылка)
	|	И ТИПЗНАЧЕНИЯ(Saby_ДокументыЭПДДанныеЮрЛиц.Сторона) В (ТИП(Справочник.Контрагенты), ТИП(Справочник.Организации))
	|	И Saby_ДокументыЭПДДанныеЮрЛиц.Сторона <> ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
	|	И Saby_ДокументыЭПДДанныеЮрЛиц.Сторона <> ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)";
	
	ВыборкаДанных = ЗапросДанных.Выполнить().Выбрать();
	
	КолонкиТаблицы = "Ссылка,РольСтрокой,Роль,ПолеОсновногоТелефона,КлючСтроки,ПараметрыРеквизитаФормы";
	
	ТаблицаЮрЛиц = Новый Массив;
	Пока ВыборкаДанных.Следующий() Цикл
		СтруктураДанных = Новый Структура(КолонкиТаблицы);
		СтруктураДанных.Ссылка = ВыборкаДанных.Сторона;
		СтруктураДанных.РольСтрокой = "СторонаДокумента";
		СтруктураДанных.Роль = РольСторонаДокумента;
		СтруктураДанных.ПолеОсновногоТелефона = "";
		
		ТаблицаЮрЛиц.Добавить(СтруктураДанных);
	КонецЦикла;
	
	ВыборкаДанных = Saby_ТНОбщегоНазначенияСервер.ВыборкаДанныхЮрЛиц(Неопределено, Неопределено, ТаблицаЮрЛиц);
	Пока ВыборкаДанных.Следующий() Цикл
		СтруктураДанныхЮрЛица = Saby_ТНОбщегоНазначенияКлиентСервер.СтруктураДанныхЮрЛица();
		ЗаполнитьЗначенияСвойств(СтруктураДанныхЮрЛица, ВыборкаДанных);
		СоответствиеДанныхПоСсылкам.Вставить(ВыборкаДанных.Ссылка, СтруктураДанныхЮрЛица);
	КонецЦикла;
	
КонецПроцедуры

Процедура ДобавитьДанныеПоСторонамДокумента(СоответствиеДанныхПоСсылкам)
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ РАЗЛИЧНЫЕ
	|	ВЫРАЗИТЬ(Saby_ДокументыЭПДДанныеЮрЛиц.Сторона КАК Справочник.Saby_СторонаДокумента) КАК Сторона
	|ПОМЕСТИТЬ СтороныДокумента
	|ИЗ
	|	Справочник.Saby_ДокументыЭПД.ДанныеЮрЛиц КАК Saby_ДокументыЭПДДанныеЮрЛиц
	|ГДЕ
	|	Saby_ДокументыЭПДДанныеЮрЛиц.Роль = ЗНАЧЕНИЕ(Перечисление.Saby_РолиКонтрагентов.ПустаяСсылка)
	|	И ТИПЗНАЧЕНИЯ(Saby_ДокументыЭПДДанныеЮрЛиц.Сторона) = ТИП(Справочник.SABY_СторонаДокумента)
	|	И Saby_ДокументыЭПДДанныеЮрЛиц.Сторона <> ЗНАЧЕНИЕ(Справочник.SABY_СторонаДокумента.ПустаяСсылка)
	|;
	|
	|////////////////////////////////////////////////////////////////////////////////
	|ВЫБРАТЬ
	|	СтороныДокумента.Сторона КАК Ссылка,
	|	СтороныДокумента.Сторона.Наименование КАК НаименованиеОрганизации,
	|	СтороныДокумента.Сторона.ИНН КАК ИНН,
	|	СтороныДокумента.Сторона.КПП КАК КПП,
	|	СтороныДокумента.Сторона.ЮрФизЛицо КАК ЮрФизЛицо,
	|	СтороныДокумента.Сторона.СтранаРегистрации КАК СтранаРегистрации,
	|	СтороныДокумента.Сторона.КодФилиала КАК КодФилиала
	|ИЗ
	|	СтороныДокумента КАК СтороныДокумента";
	
	ВыборкаДанных = ЗапросДанных.Выполнить().Выбрать();
	Пока ВыборкаДанных.Следующий() Цикл
		СтруктураДанныхЮрЛица = Saby_ТНОбщегоНазначенияКлиентСервер.СтруктураДанныхЮрЛица();
		ЗаполнитьЗначенияСвойств(СтруктураДанныхЮрЛица, ВыборкаДанных);
		СоответствиеДанныхПоСсылкам.Вставить(ВыборкаДанных.Ссылка, СтруктураДанныхЮрЛица);
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗаполнитьДанныеСторонПоСсылкам(СоответствиеДанныхПоСсылкам)
	
	Если СоответствиеДанныхПоСсылкам.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	РольСторонаДокумента = Перечисления.Saby_РолиКонтрагентов.СторонаДокумента;
	
	ЗапросДанных = Новый Запрос;
	ЗапросДанных.Текст =
	"ВЫБРАТЬ
	|	Saby_ДокументыЭПДДанныеЮрЛиц.Ссылка КАК Ссылка,
	|	Saby_ДокументыЭПДДанныеЮрЛиц.НомерСтроки КАК НомерСтроки,
	|	Saby_ДокументыЭПДДанныеЮрЛиц.Сторона КАК Сторона
	|ИЗ
	|	Справочник.Saby_ДокументыЭПД.ДанныеЮрЛиц КАК Saby_ДокументыЭПДДанныеЮрЛиц
	|ГДЕ
	|	Saby_ДокументыЭПДДанныеЮрЛиц.Роль = ЗНАЧЕНИЕ(Перечисление.Saby_РолиКонтрагентов.ПустаяСсылка)
	|	И Saby_ДокументыЭПДДанныеЮрЛиц.Сторона <> ЗНАЧЕНИЕ(Справочник.Организации.ПустаяСсылка)
	|	И Saby_ДокументыЭПДДанныеЮрЛиц.Сторона <> ЗНАЧЕНИЕ(Справочник.Контрагенты.ПустаяСсылка)
	|	И Saby_ДокументыЭПДДанныеЮрЛиц.Сторона <> ЗНАЧЕНИЕ(Справочник.SABY_СторонаДокумента.ПустаяСсылка)
	|	И Saby_ДокументыЭПДДанныеЮрЛиц.Сторона <> НЕОПРЕДЕЛЕНО
	|ИТОГИ ПО
	|	Ссылка";
	
	ВыборкаПоДокументам = ЗапросДанных.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам);
	Пока ВыборкаПоДокументам.Следующий() Цикл
		
		ОбъектСправочника = ВыборкаПоДокументам.Ссылка.ПолучитьОбъект();
		ОбъектСправочника.ДанныеЮрЛиц.Очистить();
		
		ВыборкаСторон = ВыборкаПоДокументам.Выбрать();
		Пока ВыборкаСторон.Следующий() Цикл
			СтрокаЮрЛица = ОбъектСправочника.ДанныеЮрЛиц.Добавить();
			СтруктураЮрЛица = СоответствиеДанныхПоСсылкам.Получить(ВыборкаСторон.Сторона);
			ЗаполнитьЗначенияСвойств(СтрокаЮрЛица, СтруктураЮрЛица);
			СтрокаЮрЛица.Роль = РольСторонаДокумента;
		КонецЦикла;
		
		ОбъектСправочника.Записать();
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти // СлужебныеПроцедурыИФункции
