
&НаКлиенте
Функция ИмяФормыОбработки(ПолноеИмяФормы)
	
	МассивИмен = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").СтрРазделитьЭПД(ПолноеИмяФормы, ".");
	
	ИмяФормыВнешнейОбработки = МассивИмен[МассивИмен.ВГраница()];
	
	Если ИмяФормыВнешнейОбработки = "ФормаДинамическихТитулов" Тогда
		ИмяФормыВнешнейОбработки = "Saby_ТранспортнаяНакладнаяДТ";
	КонецЕсли;
	
	ПрефиксВнешнейОбработки = "ВнешняяОбработка.СБИС.Форма.";
	
	Возврат ПрефиксВнешнейОбработки + ИмяФормыВнешнейОбработки;
	
КонецФункции

