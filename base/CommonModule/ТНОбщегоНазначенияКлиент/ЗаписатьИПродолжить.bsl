
&НаКлиенте
// Проверка что документ не изменен
// Параметры:
// 	ПроцедураДляВыполнения - Структура - данные для проверки, в том числе форма источник
//  ЗаписыватьБезВопроса- Булево - запись документа без вопросов
//
Процедура ПроверитьМодифицированностьИПродолжитьВыполнение(ПроцедураДляВыполнения, ЗаписыватьБезВопроса = Ложь) Экспорт
	
	Форма = ПроцедураДляВыполнения.Модуль;
	
	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Форма",                  Форма);
	ДополнительныеПараметры.Вставить("ПроцедураДляВыполнения", ПроцедураДляВыполнения);
	
	Если Не НеобходимоЗаписатьФорму(Форма) Тогда
		ПослеВопросаОЗаписиФормы(КодВозвратаДиалога.Нет, ДополнительныеПараметры);
	ИначеЕсли ЗаписыватьБезВопроса Тогда
		ПослеВопросаОЗаписиФормы(КодВозвратаДиалога.Да, ДополнительныеПараметры);
	Иначе
		ПроцедураПослеВопросаОЗаписиФормы = Новый ОписаниеОповещения(
			"ПослеВопросаОЗаписиФормы",
			МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент"),
			ДополнительныеПараметры);
		
		ПоказатьВопрос(
			ПроцедураПослеВопросаОЗаписиФормы,
			"Перед выполнением операции необходимо записать изменения.",
			РежимДиалогаВопрос.ДаНетОтмена,
			,
			КодВозвратаДиалога.Отмена,
			"Записать изменения?");

	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
// Выполняет действия после вопроса о сохранении объекта
//
// Параметры:
//  Результат - КодВозвратаДиалога - выбранный ответ в форме вопроса
//  ДополнительныеПараметры - Структура - контекст, переданный из вызывающей процедуры
//
Процедура ПослеВопросаОЗаписиФормы(Результат, ДополнительныеПараметры) Экспорт
	
	Форма = ДополнительныеПараметры.Форма;
	
	Если НеобходимоЗаписатьФорму(Форма) И Результат = КодВозвратаДиалога.Да Тогда
		Форма.Записать();
	КонецЕсли;
	
	Если Результат <> КодВозвратаДиалога.Отмена Тогда
		ВыполнитьОбработкуОповещения(ДополнительныеПараметры.ПроцедураДляВыполнения, Результат);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
// Определяет необходимость записи формы
//
// Параметры:
//  Форма - ФормаКлиентскогоПриложения - источник перехода
//
// Возвращаемое значение:
//   Булево - Истина, если необходимо записать данные формы
//
Функция НеобходимоЗаписатьФорму(Форма)
	
	Возврат Форма.Модифицированность
		Или (Форма.Параметры.Свойство("Ключ") И Не ЗначениеЗаполнено(Форма.Параметры.Ключ));
	
КонецФункции

