
&НаКлиенте
Функция МодульКодаКлиент(ИмяМодуля)
	
	МодульОсновнойКонфигурации = ИмяМодуля = "ФайловаяСистемаКлиент";
	
	Если МодульОсновнойКонфигурации Тогда
		Возврат Вычислить(ИмяМодуля);
	Иначе
		Возврат ЭтаФорма;
	КонецЕсли;
	
КонецФункции

