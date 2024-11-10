
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
Функция ГруппаУпаковкиПоКоду(Код) Экспорт
	
	Если Код = "I" Тогда
		Возврат ЗначениеМетаданных("Saby_ГруппыУпаковки.Группа1");
	ИначеЕсли Код = "II" Тогда
		Возврат ЗначениеМетаданных("Saby_ГруппыУпаковки.Группа2");
	ИначеЕсли Код = "III" Тогда
		Возврат ЗначениеМетаданных("Saby_ГруппыУпаковки.Группа3");
	Иначе
		Возврат ЗначениеМетаданных("Saby_ГруппыУпаковки.ПустаяСсылка");
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
Функция КодПоГруппеУпаковки(Значение) Экспорт
	
	Если Значение = ЗначениеМетаданных("Saby_ГруппыУпаковки.Группа1") Тогда
		Возврат "I";
	ИначеЕсли Значение = ЗначениеМетаданных("Saby_ГруппыУпаковки.Группа2") Тогда
		Возврат "II";
	ИначеЕсли Значение = ЗначениеМетаданных("Saby_ГруппыУпаковки.Группа3") Тогда
		Возврат "III";
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс

#Область include_etrn_base_CommonModule_ЗначениеМетаданных
#КонецОбласти // include_etrn_base_CommonModule_ЗначениеМетаданных

