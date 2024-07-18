#Область ПрограммныйИнтерфейс

// Возвращает соответствующее значение перечисления переданному коду.
//
// Параметры:
//  Код - Строка - строковый код значения. Данный код чаще всего передает онлайн.
//
// Возвращаемое значение:
//   ПеречислениеСсылка.Saby_ВидКоммерческойПеревозки - ссылка на перечисление.
//     Если по коду ссылка не найдена, то возвращается пустая ссылка.
//
Функция ЗначениеПоКоду(Код) Экспорт
	
	Если Код = "РП" Тогда
		Возврат РегулярнаяПеревозка;
	ИначеЕсли Код = "ПГ" Тогда
		Возврат ПеревозкаНаОснованииДоговораПеревозки;
	ИначеЕсли Код = "ЗП" Тогда
		Возврат ПеревозкаПоЗаказу;
	ИначеЕсли Код = "ЛТ" Тогда
		Возврат ЛегковоеТакси;
	ИначеЕсли Код = "ПД" Тогда
		Возврат ПеревозкаДетей;
	Иначе
		Возврат ПустаяСсылка();
	КонецЕсли;
	
КонецФункции

// Возвращает соответствующий код по указанному значению перечисления.
//
// Параметры:
//  Значение  - ПеречислениеСсылка.Saby_ВидКоммерческойПеревозки - значение перечисления
//
// Возвращаемое значение:
//   Строка - Строковое представление кода.
//
Функция КодПоЗначению(Значение) Экспорт
	
	Если Значение = РегулярнаяПеревозка Тогда
		Возврат "РП";
	ИначеЕсли Значение = ПеревозкаНаОснованииДоговораПеревозки Тогда
		Возврат "ПГ";
	ИначеЕсли Значение = ПеревозкаПоЗаказу Тогда
		Возврат "ЗП";
	ИначеЕсли Значение = ЛегковоеТакси Тогда
		Возврат "ЛТ";
	ИначеЕсли Значение = ПеревозкаДетей Тогда
		Возврат "ПД";
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс
