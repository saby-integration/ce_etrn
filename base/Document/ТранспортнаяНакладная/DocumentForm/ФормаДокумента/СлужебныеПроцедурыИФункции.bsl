
&НаКлиенте
Функция ИсточникДанныхКлиент()
	
	Возврат Объект;
	
КонецФункции

&НаСервере
Функция ИсточникДанных()
	
	Возврат Объект;
	
КонецФункции

&НаКлиенте
Процедура ЗаполнитьДанныеТитулов(ПараметрыФормыРасшифровки)
	
	Возврат;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьСтруктуруДокумента(Параметры = Неопределено) Экспорт
	
	ЭтаФорма.ДвоичныеДанныеОбработки = Неопределено;
	
КонецПроцедуры

&НаСервере
Процедура УстановитьОтборДокументовЭПД()
	Возврат;
КонецПроцедуры

&НаСервере
Процедура НастроитьУсловноеОформление()
	Возврат;
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьДанныеДокументаИзСБИС(ПараметрыЗагрузки, ОбщиеПараметрыЗагрузки, Результат)
	
	Возврат;
	
КонецПроцедуры

&НаКлиенте
Функция ЗаполнитьНаОснованииINI(НеИспользуется1, НеИспользуется2, НеИспользуется3)
	
	Возврат Неопределено;
	
КонецФункции

&НаСервере
Процедура НастроитьФормуДляСтарыхПлатформ()
	
	Возврат;
	
КонецПроцедуры

#Область include_etrn_base_CommonModule_ОпределениеМодуляКода
#КонецОбласти // include_etrn_base_CommonModule_ОпределениеМодуляКода

#Область include_etrn_base_CommonModule_ОпределениеМодуляКодаКлиент
#КонецОбласти // include_etrn_base_CommonModule_ОпределениеМодуляКодаКлиент

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_ОткрытиеФорм
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_ОткрытиеФорм

#Область include_etrn_base_CommonModule_ЗначениеМетаданных
#КонецОбласти // include_etrn_base_CommonModule_ЗначениеМетаданных

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_КлючиСтрок
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_КлючиСтрок

