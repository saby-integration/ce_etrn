
&НаСервере
Процедура НастроитьДокументыЭПД()
	
	СкрытьВидимость = Новый Массив;
	СкрытьВидимость.Добавить("ДокументыЭПДТип");
	СкрытьВидимость.Добавить("ДокументыЭПДНаименование");
	СкрытьВидимость.Добавить("ДокументыЭПДНомер");
	СкрытьВидимость.Добавить("ДокументыЭПДДата");
	СкрытьВидимость.Добавить("ДокументыЭПДДопСведения");
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Ложь, СкрытьВидимость);
	
КонецПроцедуры

&НаСервере
Процедура ЗагрузитьДокументыЭПД(ДанныеЗаполнения)
	Возврат;
КонецПроцедуры

&НаСервере
Процедура НастроитьФормуДляСтарыхПлатформ()
	
	Возврат;
	
КонецПроцедуры

#Область include_etrn_base_CommonModule_ОпределениеМодуляКода
#КонецОбласти // include_etrn_base_CommonModule_ОпределениеМодуляКода

#Область include_etrn_base_CommonModule_ОпределениеМодуляКодаКлиент
#КонецОбласти // include_etrn_base_CommonModule_ОпределениеМодуляКодаКлиент

#Область include_etrn_base_CommonModule_ВыполнениеФункцииНаСервере 
#КонецОбласти // include_etrn_base_CommonModule_ВыполнениеФункцииНаСервере

#Область include_etrn_base_CommonModule_ЗначениеМетаданных
#КонецОбласти // include_etrn_base_CommonModule_ЗначениеМетаданных

