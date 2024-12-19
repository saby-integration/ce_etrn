#Область ПрограммныйИнтерфейс

// Возвращает соответствующее значение перечисления переданному коду.
//
// Параметры:
//  Код - Строка - строковый код значения. Данный код чаще всего передает онлайн.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ВидСообщенияЭПЛ - ссылка на перечисление.
//     Если по коду ссылка не найдена, то возвращается пустая ссылка.
//
Функция ЗначениеПоКоду(Код) Экспорт
	
	Если Код = "Г" Тогда
		Возврат Городское;
	ИначеЕсли Код = "П" Тогда
		Возврат Пригородное;
	ИначеЕсли Код = "М" Тогда
		Возврат Междугородное;
	Иначе
		Возврат ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

// Возвращает соответствующий код по указанному значению перечисления.
//
// Параметры:
//  Значение  - ПеречислениеСсылка.Saby_ВидСообщенияЭПЛ - значение перечисления
//
// Возвращаемое значение:
//   Строка - Строковое представление кода.
//
Функция КодПоЗначению(Значение) Экспорт
	
	Если Значение = Городское Тогда
		Возврат "Г";
	ИначеЕсли Значение = Пригородное Тогда
		Возврат "П";
	ИначеЕсли Значение = Междугородное Тогда
		Возврат "М";
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс
