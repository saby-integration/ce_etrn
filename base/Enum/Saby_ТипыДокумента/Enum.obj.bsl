
#Область ПрограммныйИнтерфейс

// Возвращает подсказку для типа документ, чтобы показать ее пользователю.
//
// Параметры:
//  ТипДокумента - ПеречислениеСсылка.Saby_ТипыДокумента - тип документа, для которого необходимо получить подсказку.
//
// Возвращаемое значение:
//   Строка - подсказка для вывода пользователю.
//
Функция Подсказка(ТипДокумента) Экспорт
	
	Если ТипДокумента = АктВзвешивания Тогда
		РезультатФункции = "результат взвешивания и (или) измерения габаритов транспортного средства.";
	ИначеЕсли ТипДокумента = АктКоммерческий Тогда
		РезультатФункции = "основной документ, подтверждающий обстоятельства утраты, недостачи, ";
		РезультатФункции = РезультатФункции + "порчи или повреждения перевозимого груза.";
	ИначеЕсли ТипДокумента = ДоговорПеревозки Тогда
		РезультатФункции = "договор, предметом которого является оказание услуг по перевозке грузов, багажа или людей.";
	ИначеЕсли ТипДокумента = КГрузу Тогда
		РезультатФункции = "сертификаты, паспорта качества, удостоверения и другие документы.";
	ИначеЕсли ТипДокумента = КТранспортнойНакладной Тогда
		РезультатФункции = "сопроводительные документы в случае перевозки опасных грузов";
	ИначеЕсли ТипДокумента = ОтветственныйНаОсновании Тогда
		РезультатФункции = "документ, подтверждающий полномочия ответственного лица.";
	ИначеЕсли ТипДокумента = ПодтверждениеВладения Тогда
		РезультатФункции = "документ, подтверждающий право владения ТС или прицепом.";
	ИначеЕсли ТипДокумента = ПередачиЦенностей Тогда
		РезультатФункции = "подтверждает факт отгрузки товара.";
	ИначеЕсли ТипДокумента = СопроводительнаяВедомость Тогда
		РезультатФункции = "документ служит для учета и контроля использования контейнеров.";
	ИначеЕсли ТипДокумента = ПравоПереадресации Тогда
		РезультатФункции = "документ подтверждает полномочия лица, осуществляющего переадресовку груза.";
	ИначеЕсли ТипДокумента = ПутевойЛист Тогда
		РезультатФункции = "документ учета и контроля работы транспортного средства и водителя.";
	ИначеЕсли ТипДокумента = ОснованиеОплатыПеревозки Тогда
		РезультатФункции = "документ, являющийся основанием оплаты.";
	ИначеЕсли ТипДокумента = СоставительНаОсновании Тогда
		РезультатФункции = "документ подтверждает полномочия лица, составляющего документ вместо отправителя.";
	Иначе
		РезультатФункции = "";
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

// Добавляет в указанный массив все ссылки на типы документов по порядку указанному в конфигураторе.
//
// Параметры:
//  МассивТипов - Массив - массив для добавления ссылок на типы документов.
//
Процедура ЗаполнитьВсеТипыПоПорядку(МассивТипов) Экспорт
	
	Для Индекс = 0 По Количество() - 1 Цикл
		МассивТипов.Добавить(Получить(Индекс));
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс
