
&НаСервере
Процедура НастроитьДокументыЭПД()
	
	СкрытьВидимость = Новый Массив;
	СкрытьВидимость.Добавить("ДокументыЭПДДокументВладения");
	СкрытьВидимость.Добавить("ДокументыЭПДТип");
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Ложь, СкрытьВидимость);
	
КонецПроцедуры

&НаКлиенте
Функция ФормаОбъект(Форма)
	
	Возврат Форма;
	
КонецФункции

#Область include_etrn_src_vo3_CommonModule_ОпределениеМодуляКода
#КонецОбласти // include_etrn_src_vo3_CommonModule_ОпределениеМодуляКода

#Область include_etrn_src_vo3_CommonModule_ОпределениеМодуляКодаКлиент
#КонецОбласти // include_etrn_src_vo3_CommonModule_ОпределениеМодуляКодаКлиент

#Область include_etrn_src_vo3_CommonModule_ЗначениеМетаданных
#КонецОбласти // include_etrn_src_vo3_CommonModule_ЗначениеМетаданных

#Область include_etrn_base_Enum_ТипыВладенияТС_Enum
#КонецОбласти // include_etrn_base_Enum_ТипыВладенияТС_Enum

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиентСервер_РаботаСоСвязаннымиТаблицами //&НаКлиенте
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиентСервер_РаботаСоСвязаннымиТаблицами //&НаКлиенте

