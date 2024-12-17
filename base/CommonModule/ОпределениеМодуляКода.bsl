
//DynamicDirective

Функция МодульКода(ИмяМодуля)
	
	Модули = Новый Соответствие;
	Модули.Вставить("Saby_Core",                           Saby_Core);
	Модули.Вставить("Saby_ТНВыгрузкаСервер",               Saby_ТНВыгрузкаСервер);
	Модули.Вставить("Saby_ТНОбщегоНазначенияКлиентСервер", Saby_ТНОбщегоНазначенияКлиентСервер);
	Модули.Вставить("Saby_ТНЗагрузкаСервер",               Saby_ТНЗагрузкаСервер);
	Модули.Вставить("Saby_ТНОбщегоНазначенияСервер",       Saby_ТНОбщегоНазначенияСервер);
	Модули.Вставить("Saby_ОбщегоНазначенияКлиентСервер",   Saby_ОбщегоНазначенияКлиентСервер);
	
	#Если Сервер Тогда

		ИмяБухгалтерскийУчетПереопределяемый = "БухгалтерскийУчетПереопределяемый";
		Попытка
			МодульБухгалтерскийУчетПереопределяемый = ОбщегоНазначения.ВычислитьВБезопасномРежиме(ИмяБухгалтерскийУчетПереопределяемый);
			Модули.Вставить(ИмяБухгалтерскийУчетПереопределяемый, МодульБухгалтерскийУчетПереопределяемый);
		Исключение
			Модули.Вставить(ИмяБухгалтерскийУчетПереопределяемый, Неопределено);
		КонецПопытки;

		ИмяУправлениеКонтактнойИнформациейСлужебный = "УправлениеКонтактнойИнформациейСлужебный";
		Попытка
			МодульУправлениеКонтактнойИнформациейСлужебный = ОбщегоНазначения.ВычислитьВБезопасномРежиме(ИмяУправлениеКонтактнойИнформациейСлужебный);
			Модули.Вставить(ИмяУправлениеКонтактнойИнформациейСлужебный, МодульУправлениеКонтактнойИнформациейСлужебный);
		Исключение
			Модули.Вставить(ИмяУправлениеКонтактнойИнформациейСлужебный, Неопределено);
		КонецПопытки;
		
		ИмяДлительныеОперации = "ДлительныеОперации";
		Попытка
			МодульДлительныеОперации = ОбщегоНазначения.ВычислитьВБезопасномРежиме(ИмяДлительныеОперации);
			Модули.Вставить(ИмяДлительныеОперации, МодульДлительныеОперации);
		Исключение
			Модули.Вставить(ИмяДлительныеОперации, Неопределено);
		КонецПопытки;

		Модули.Вставить("Справочники.Saby_СторонаДокумента",  Справочники.Saby_СторонаДокумента);
		Модули.Вставить("Справочники.Saby_ВидыУпаковки",      Справочники.Saby_ВидыУпаковки);
		Модули.Вставить("Справочники.Saby_ДокументыЭПД",      Справочники.Saby_ДокументыЭПД);
		Модули.Вставить("Справочники.Saby_ОпасныеГрузы",      Справочники.Saby_ОпасныеГрузы);
		Модули.Вставить("Справочники.Saby_СостоянияОбъектов", Справочники.Saby_СостоянияОбъектов);
		
		Модули.Вставить("Документы.Saby_ПутевойЛист",           Документы.Saby_ПутевойЛист);
		Модули.Вставить("Документы.Saby_ЗаказНаПеревозку",      Документы.Saby_ЗаказНаПеревозку);
		Модули.Вставить("Документы.Saby_ТранспортнаяНакладная", Документы.Saby_ТранспортнаяНакладная);
		
		Модули.Вставить("Перечисления.Saby_ДоступныеДействия",                  Перечисления.Saby_ДоступныеДействия);
		Модули.Вставить("Перечисления.Saby_ВидыТС",                             Перечисления.Saby_ВидыТС);
		Модули.Вставить("Перечисления.Saby_ВидКоммерческойПеревозки",           Перечисления.Saby_ВидКоммерческойПеревозки);
		Модули.Вставить("Перечисления.Saby_ВидСообщенияЭПЛ",                    Перечисления.Saby_ВидСообщенияЭПЛ);
		Модули.Вставить("Перечисления.Saby_ВидПеревозки",                       Перечисления.Saby_ВидПеревозки);
		Модули.Вставить("Перечисления.Saby_ВладелецОбъектаОтгрузки",            Перечисления.Saby_ВладелецОбъектаОтгрузки);
		Модули.Вставить("Перечисления.Saby_ГруппыУпаковки",                     Перечисления.Saby_ГруппыУпаковки);
		Модули.Вставить("Перечисления.Saby_РолиОтветственных",                  Перечисления.Saby_РолиОтветственных);
		Модули.Вставить("Перечисления.Saby_КлассыОпасностиГрузов",              Перечисления.Saby_КлассыОпасностиГрузов);
		Модули.Вставить("Перечисления.Saby_ПризнакНачалаРейса",                 Перечисления.Saby_ПризнакНачалаРейса);
		Модули.Вставить("Перечисления.Saby_Направление",                        Перечисления.Saby_Направление);
		Модули.Вставить("Перечисления.Saby_ТипГруза",                           Перечисления.Saby_ТипГруза);
		Модули.Вставить("Перечисления.Saby_КодыОграниченийПроездаЧерезТуннели", Перечисления.Saby_КодыОграниченийПроездаЧерезТуннели);
		Модули.Вставить("Перечисления.Saby_МетодОпределенияМассы",              Перечисления.Saby_МетодОпределенияМассы);
		Модули.Вставить("Перечисления.Saby_РолиКонтрагентов",                   Перечисления.Saby_РолиКонтрагентов);
		Модули.Вставить("Перечисления.Saby_ТипДокументаЗнП",                    Перечисления.Saby_ТипДокументаЗнП);
		Модули.Вставить("Перечисления.Saby_ЮрФизЛицо",                          Перечисления.Saby_ЮрФизЛицо);
		Модули.Вставить("Перечисления.Saby_ТипТитулаЗнП",                       Перечисления.Saby_ТипТитулаЗнП);
		Модули.Вставить("Перечисления.Saby_ТипыВладенияТС",                     Перечисления.Saby_ТипыВладенияТС);
		Модули.Вставить("Перечисления.Saby_ТипТитулаЭтрН",                      Перечисления.Saby_ТипТитулаЭтрН);
		Модули.Вставить("Перечисления.Saby_ТипТитулаЭПЛ",                       Перечисления.Saby_ТипТитулаЭПЛ);
		Модули.Вставить("Перечисления.Saby_ТипыДокумента",                      Перечисления.Saby_ТипыДокумента);
		
		Модули.Вставить("РегистрыСведений.Saby_ДанныеТитулов",        РегистрыСведений.Saby_ДанныеТитулов);
		Модули.Вставить("РегистрыСведений.Saby_Состояние",            РегистрыСведений.Saby_Состояние);
		Модули.Вставить("РегистрыСведений.Saby_ДвоичныеДанныеФайлов", РегистрыСведений.Saby_ДвоичныеДанныеФайлов);

	#КонецЕсли
	
	#Если Клиент Тогда
		Модули.Вставить("Saby_ТНОбщегоНазначенияКлиент", Saby_ТНОбщегоНазначенияКлиент);
	#КонецЕсли
	
	Возврат Модули[ИмяМодуля];
	
КонецФункции

