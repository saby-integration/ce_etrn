
//DynamicDirective

// Возвращает с структуру данных юр лица
//
// Возвращаемое значение:
//   Структура - см. в самой функции
//
Функция ШаблонДанныхЮрЛица() Экспорт

	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("Роль",                    "");
	РезультатФункции.Вставить("ЮрФизЛицо",               "");
	РезультатФункции.Вставить("ЮрФизЛицоСтрокой",        "");
	РезультатФункции.Вставить("ИНН",                     "");
	РезультатФункции.Вставить("КПП",                     "");
	РезультатФункции.Вставить("ОГРН",                    "");
	РезультатФункции.Вставить("СтруктураФИО",            "");
	РезультатФункции.Вставить("Адрес",                   "");
	РезультатФункции.Вставить("АдресСтруктура",          "");
	РезультатФункции.Вставить("СтранаРегистрации",       "");
	РезультатФункции.Вставить("КодФилиала",              "");
	РезультатФункции.Вставить("НаименованиеОрганизации", "");
	РезультатФункции.Вставить("Полномочия",              "");
	РезультатФункции.Вставить("Основание",               "");
	РезультатФункции.Вставить("ИдентификаторЭДО",        "");
	
	РезультатФункции.Вставить("КлючСтроки",              0);
	РезультатФункции.Вставить("КлючСтроки_ДокументыЭПД", 0);
	
	РезультатФункции.Вставить("Заполнена",               Ложь);
	
	РезультатФункции.Вставить("КонтактныеДанные",        Новый Массив);
	
	Возврат РезультатФункции;
		
КонецФункции 

//DynamicDirective

// Контракт контактных данных юр лица для использования в процедурах и функциях
//
// Возвращаемое значение:
//   Структура - см. в функции
//
Функция СтруктураКонтактныхДанных() Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("Роль",                   "");
	РезультатФункции.Вставить("Тип",                    "");
	РезультатФункции.Вставить("Значение",               "");
	РезультатФункции.Вставить("Структура",              "");
	РезультатФункции.Вставить("КлючСтроки_ДанныеЮрЛиц", "");
	РезультатФункции.Вставить("Основной",               "");
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

// Контракт данных ответственного лица
//
// Возвращаемое значение:
//   Структура - см. в функции
//
Функция СтруктураОтветственногоЛица() Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("КлючСтроки",            "");
	РезультатФункции.Вставить("ИНН",                   "");
	РезультатФункции.Вставить("Серия",                 "");
	РезультатФункции.Вставить("Номер",                 "");
	РезультатФункции.Вставить("ДатаВыдачи",            "");
	РезультатФункции.Вставить("Фамилия",               "");
	РезультатФункции.Вставить("Имя",                   "");
	РезультатФункции.Вставить("Отчество",              "");
	РезультатФункции.Вставить("Телефоны",              "");
	РезультатФункции.Вставить("Роль",                  "");
	РезультатФункции.Вставить("ДатаОкончанияДействия", "");
	РезультатФункции.Вставить("ЭлектроннаяПочта",      "");
	РезультатФункции.Вставить("Должность",             "");
	РезультатФункции.Вставить("ШтатныйСотрудник",      "");
	РезультатФункции.Вставить("СНИЛС",                 "");
	РезультатФункции.Вставить("ИдентификаторСтроки",   Неопределено);
	
	РезультатФункции.Вставить("Заполнена",             Ложь);
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

// Шаблон Документа ЭПД для использования в процедурах и функциях
//
// Возвращаемое значение:
//   Структура - см. в функции
//
Функция СтруктураДокументаЭПД() Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("Тип",          Неопределено);
	РезультатФункции.Вставить("Номер",        "");
	РезультатФункции.Вставить("Дата",         "");
	РезультатФункции.Вставить("Наименование", "");
	РезультатФункции.Вставить("ИД",           "");
	РезультатФункции.Вставить("ДопСведения",  "");
	РезультатФункции.Вставить("ДанныеЮрЛиц",  Новый Массив);
	
	РезультатФункции.Вставить("ЭтоСопроводительныйДокумент", Ложь);
	
	РезультатФункции.Вставить("КлючСтроки",                       "");
	РезультатФункции.Вставить("КлючСтроки_ТранспортногоСредства", "");
	РезультатФункции.Вставить("КлючСтроки_ОтветственныеЛица",     "");
	
	РезультатФункции.Вставить("Ссылка",       "");
	
	РезультатФункции.Вставить("Заполнена",    Ложь);
	
	Возврат РезультатФункции;
	
КонецФункции

//DynamicDirective

// Возвращает с структуру данных транспортного средства
//
// Возвращаемое значение:
//   Структура - см. в самой функции
//
Функция СтруктураТранспортногоСредства() Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("Вид",                  ЗначениеМетаданных("Saby_ВидыТС.ПустаяСсылка"));
	РезультатФункции.Вставить("РегистрационныйНомер", "");
	РезультатФункции.Вставить("ИнвентарныйНомер",     "");
	РезультатФункции.Вставить("Тип",                  "");
	РезультатФункции.Вставить("Марка",                "");
	РезультатФункции.Вставить("Модель",               "");
	РезультатФункции.Вставить("ВИН",                  "");
	РезультатФункции.Вставить("НомерСТС",             "");
	РезультатФункции.Вставить("Грузоподъемность",     0);
	РезультатФункции.Вставить("Вместимость",          0);
	РезультатФункции.Вставить("ТипВладения",          ЗначениеМетаданных("Saby_ТипыВладенияТС.ПустаяСсылка"));
	РезультатФункции.Вставить("ОснованияВладения",    "");
	РезультатФункции.Вставить("Идентификатор",        "");
	
	РезультатФункции.Вставить("КлючСтроки",           0);
	
	Возврат РезультатФункции;
	
КонецФункции

// Возвращает структуру параметров настроек группировок позиций после заполнения на основании
//
// Возвращаемое значение:
//   Структура - см. в функции
//
Функция ПараметрыГруппировкиПозицийОснований() Экспорт
	
	РезультатФункции = Новый Структура;
	РезультатФункции.Вставить("ГруппироватьТоварыИзДокументовОснований", Ложь);
	РезультатФункции.Вставить("ГруппироватьПоРеквизитуНоменклатуры",     Ложь);
	РезультатФункции.Вставить("РеквизитНоменклатуры",                      "");
	РезультатФункции.Вставить("ГруппироватьВОднуПозицию",                Ложь);
	РезультатФункции.Вставить("НаименованиеОбщейПозиции",                  "");
	РезультатФункции.Вставить("ПользовательФоновыхЗаданий",                "");
	
	Возврат РезультатФункции;
	
КонецФункции

