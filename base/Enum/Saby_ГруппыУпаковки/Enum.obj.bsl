
#Область ПрограммныйИнтерфейс

// Возвращает соответствующее значение перечисления переданному коду.
//
// Параметры:
//  Код - Строка - строковый код значения. Данный код чаще всего передает онлайн.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ГруппыУпаковки - ссылка на перечисление.
//     Если по коду ссылка не найдена, то возвращается пустая ссылка.
//
Функция ЗначениеПоКоду(Код) Экспорт
	
	Если Код = "I" Тогда
		Возврат Группа1;
	ИначеЕсли Код = "II" Тогда
		Возврат Группа2;
	ИначеЕсли Код = "III" Тогда
		Возврат Группа3;
	Иначе
		Возврат ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

// Возвращает соответствующий код по указанному значению перечисления.
//
// Параметры:
//  Значение  - ПеречислениеСсылка.Saby_ГруппыУпаковки - значение перечисления
//
// Возвращаемое значение:
//   Строка - Строковое представление кода.
//
Функция КодПоЗначению(Значение) Экспорт
	
	Если Значение = Группа1 Тогда
		Возврат "I";
	ИначеЕсли Значение = Группа2 Тогда
		Возврат "II";
	ИначеЕсли Значение = Группа3 Тогда
		Возврат "III";
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс
