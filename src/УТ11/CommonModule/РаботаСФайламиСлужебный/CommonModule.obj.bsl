       
#Область СлужебныеПроцедурыИФункции

&Вместо ("ЗаписатьФайлВИнформационнуюБазу")
Процедура Saby_ЗаписатьФайлВИнформационнуюБазу(Знач ПрисоединенныйФайл, Знач ДвоичныеДанные) Экспорт
	
	УстановитьОтключениеБезопасногоРежима(Истина);
	УстановитьПривилегированныйРежим(Истина);
	
	// для записи файлов для расширения используем отдельный РС
	Если Saby_ОбщегоНазначенияКлиентСервер.ПрисоединенныйФайлВРасширении(ПрисоединенныйФайл) Тогда  
		МенеджерЗаписи = РегистрыСведений.Saby_ДвоичныеДанныеФайлов.СоздатьМенеджерЗаписи();		
	Иначе
		
		Если Метаданные.РегистрыСведений.Найти("ХранилищеФайлов") <> Неопределено Тогда
			РегистрыСведений.ХранилищеФайлов.ЗаписатьДвоичныеДанные(ПрисоединенныйФайл, ДвоичныеДанные);
			Возврат;
		Иначе
			МенеджерЗаписи = РегистрыСведений.ДвоичныеДанныеФайлов.СоздатьМенеджерЗаписи();
		КонецЕсли;
		
	КонецЕсли;
	
	МенеджерЗаписи.Файл                = ПрисоединенныйФайл;
	МенеджерЗаписи.ДвоичныеДанныеФайла = Новый ХранилищеЗначения(ДвоичныеДанные, Новый СжатиеДанных(9));
	МенеджерЗаписи.Записать(Истина);
	
КонецПроцедуры  

&Вместо ("КонтекстОбновленияФайла")
Функция Saby_КонтекстОбновленияФайла(ПрисоединенныйФайл, ДанныеФайла, СсылкаНаФайл, ТипХраненияФайла)
	Контекст = Новый Структура;
	Контекст.Вставить("ИзменяемыеРеквизиты", Новый Структура);
	Контекст.Вставить("СтарыйПутьКФайлу", "");
	Контекст.Вставить("ПараметрыДобавленияФайла", РаботаСФайламиВТомахСлужебный.ПараметрыДобавленияФайла());
	Контекст.Вставить("ЭтоНовый", Ложь);
	Контекст.Вставить("ПрисоединенныйФайл", Неопределено);
	ТипПараметраФайла = ТипЗнч(ПрисоединенныйФайл); 	
	
	Если НЕ Saby_ОбщегоНазначенияКлиентСервер.ПрисоединенныйФайлВРасширении(ПрисоединенныйФайл.Ссылка)
		И НЕ ОбщегоНазначения.ЭтоСсылка(ТипПараметраФайла) Тогда
		Контекст.ЭтоНовый =  ПрисоединенныйФайл.ЭтоНовый();
	КонецЕсли;	
	
	Контекст.ПрисоединенныйФайл = ?(ЗначениеЗаполнено(СсылкаНаФайл), СсылкаНаФайл, ПрисоединенныйФайл.Ссылка);

	ЗаполнитьЗначенияСвойств(Контекст.ПараметрыДобавленияФайла, ПрисоединенныйФайл);
	Контекст.ПараметрыДобавленияФайла.ТипХраненияФайла = ТипХраненияФайла;

	Если ТипЗнч(ДанныеФайла) = Тип("Строка") И ЭтоАдресВременногоХранилища(ДанныеФайла) Тогда
		ДанныеФайла = ПолучитьИзВременногоХранилища(ДанныеФайла);
	КонецЕсли;

	Контекст.Вставить("ДанныеФайла", ДанныеФайла);
	Возврат Контекст;
КонецФункции

#КонецОбласти
