
//DynamicDirective

Функция КартинкаИнтерфейса(Форма, ИмяКартинки) Экспорт
	
	Если Форма = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Возврат Форма.Элементы[ИмяКартинки].Картинка;
	
КонецФункции

