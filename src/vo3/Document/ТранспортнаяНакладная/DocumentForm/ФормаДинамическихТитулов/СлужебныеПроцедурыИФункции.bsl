
&НаСервере
Процедура НастроитьФормуДляСтарыхПлатформ()
	
	СистемнаяИнформация = Новый СистемнаяИнформация;
	
	ВерсияПлатформыБольшеИлиРавна8_3_12 = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").СравнитьВерсии(
		СистемнаяИнформация.ВерсияПриложения, "8.3.12.0") >= 0;
		
	ВерсияСовместимостиБольшеИлиРавна8_3_12 = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").СравнитьВерсии(
		Метаданные.РежимСовместимости, "8.3.12.0") >= 0;
		
	Если ВерсияПлатформыБольшеИлиРавна8_3_12 И ВерсияСовместимостиБольшеИлиРавна8_3_12 Тогда
		МассивИменГрупп = Новый Массив;
		МассивИменГрупп.Добавить("ГруппаДополнительныеКонтакты");
		МассивИменГрупп.Добавить("Группа_Прицепы");
		МассивИменГрупп.Добавить("Группа_Водители");
		Для Каждого ИмяГруппы Из МассивИменГрупп Цикл
			Элементы[ИмяГруппы].Поведение             = ПоведениеОбычнойГруппы.Всплывающая;
			Элементы[ИмяГруппы].ОтображениеУправления = ОтображениеУправленияОбычнойГруппы.Картинка;
		КонецЦикла;
	Иначе
		Элементы.ЗаменаВодители.ЦветРамки = ЦветаСтиля.ЦветФонаФормы;
		Элементы.ЗаменаТС.ЦветРамки       = ЦветаСтиля.ЦветФонаФормы;
		Элементы.ЗаменаПрицепы.ЦветРамки  = ЦветаСтиля.ЦветФонаФормы;
	КонецЕсли;
	
КонецПроцедуры

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

#Область include_etrn_src_vo3_Document_ТранспортнаяНакладная_DocumentForm_ФормаДинамическихТитулов_ДанныеБазы
#КонецОбласти // include_etrn_base_Document_ТранспортнаяНакладная_DocumentForm_ФормаДинамическихТитулов_ДанныеБазы

#Область include_etrn_src_vo3_CommonModule_КартинкаИнтерфейса //&НаСервере
#КонецОбласти // include_etrn_src_vo3_CommonModule_КартинкаИнтерфейса //&НаСервере

#Область include_etrn_src_vo3_CommonModule_ДокументыЭПД //&НаКлиенте
#КонецОбласти // include_etrn_src_vo3_CommonModule_ДокументыЭПД //&НаКлиенте

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияСервер_ПараметрыДаты
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияСервер_ПараметрыДаты

#Область include_etrn_base_CommonModule_ТНВыгрузкаСервер_ВзаимодействиеСОнлайном //&НаКлиенте
#КонецОбласти // include_etrn_base_CommonModule_ТНВыгрузкаСервер_ВзаимодействиеСОнлайном //&НаКлиенте

