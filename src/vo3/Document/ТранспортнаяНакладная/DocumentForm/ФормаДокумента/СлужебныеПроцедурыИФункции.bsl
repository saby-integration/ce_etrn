
&НаКлиенте
Процедура Записать(ПараметрыЗаписи)
	
КонецПроцедуры

&НаКлиенте
Функция ИсточникДанныхКлиент()
	
	Возврат ЭтаФорма;
	
КонецФункции

&НаСервере
Функция ИсточникДанных()
	
	Возврат ЭтаФорма;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьДанныеТитулов(ПараметрыФормыРасшифровки)
	
	ПараметрыФормыРасшифровки.ДанныеТитулов = ЭтаФорма.ДанныеТитулов;
	
КонецПроцедуры

&НаСервере
Функция ОбъектОбработки()
	
	Возврат РеквизитФормыВЗначение("Объект");
	
КонецФункции

#Область include_etrn_src_vo3_CommonModule_ВыполнениеФункцииНаСервере //&НаСервере
#КонецОбласти // include_etrn_src_vo3_CommonModule_ВыполнениеФункцииНаСервере //&НаСервере

#Область include_etrn_src_vo3_CommonModule_ОпределениеМодуляКода
#КонецОбласти // include_etrn_src_vo3_CommonModule_ОпределениеМодуляКода

#Область include_etrn_src_vo3_CommonModule_ОпределениеМодуляКодаКлиент
#КонецОбласти // include_etrn_src_vo3_CommonModule_ОпределениеМодуляКодаКлиент

#Область include_etrn_src_vo3_CommonModule_ЗначениеМетаданных
#КонецОбласти // include_etrn_src_vo3_CommonModule_ЗначениеМетаданных

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_CommonModule
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_CommonModule

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиентСервер_CommonModule //&НаКлиенте
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиентСервер_CommonModule //&НаКлиенте

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияСервер_CommonModule
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияСервер_CommonModule

#Область include_etrn_base_Document_ТранспортнаяНакладная_РеквизитыТитулов
#КонецОбласти // include_etrn_base_Document_ТранспортнаяНакладная_РеквизитыТитулов
