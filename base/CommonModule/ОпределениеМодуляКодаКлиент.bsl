
&НаКлиенте
Функция МодульКодаКлиент(ИмяМодуля)
	
	#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ТолстыйКлиентУправляемоеПриложение Или ВнешнееСоединение Тогда
		УстановитьБезопасныйРежим(Истина);
	#КонецЕсли
	
	РезультатФункции = Вычислить(ИмяМодуля);
	
	Возврат РезультатФункции;
	
КонецФункции

