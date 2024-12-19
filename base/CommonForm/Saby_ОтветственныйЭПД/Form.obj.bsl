
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.ЭтоВО                   = Параметры.ЭтоВО;
	ЭтаФорма.ДвоичныеДанныеОбработки = Параметры.ДвоичныеДанныеОбработки;
	
	УстановитьТипыРеквизитов();
	
	ЗаполнениеРеквизитовФормы(Параметры);
	
	УстановитьВидимостьДоступностьРеквизитов(Параметры);
	
	НастроитьФормуДляСтарыхПлатформ();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбработкаОповещения(ИмяСобытия, Параметр, Источник)
	
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ОбработатьОповещенияДляФормы(ЭтаФорма, ИмяСобытия, Параметр, Источник);
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьПоСсылке(Команда)
	
	ОбновитьДанныеПоСсылке();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНовыеДанные(Команда)
	
	ВУ  = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ПредставлениеВУ(ЭтаФорма);
	ФИО = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ПредставлениеФИО(ЭтаФорма);
	
	ТелефоныЭлектроннаяПочта = ТелефоныЭлектроннаяПочтаСериализовать();
	
	Структура = Новый Структура;
	Структура.Вставить("Фамилия",          ЭтаФорма.Фамилия);
	Структура.Вставить("Имя",              ЭтаФорма.Имя);
	Структура.Вставить("Отчество",         ЭтаФорма.Отчество);
	Структура.Вставить("ИНН",              ЭтаФорма.ИНН);
	Структура.Вставить("Телефоны",         ТелефоныЭлектроннаяПочта.Телефоны);
	Структура.Вставить("ЭлектроннаяПочта", ТелефоныЭлектроннаяПочта.ЭлектроннаяПочта);
	Структура.Вставить("ФИО",              ФИО);
	Структура.Вставить("ВУ",               ВУ);
	Структура.Вставить("Роль",             ЭтаФорма.Роль);
	
	Если Элементы.ГруппаВУ.Видимость Тогда
		Структура.Вставить("Серия",      ЭтаФорма.Серия);
		Структура.Вставить("Номер",      ЭтаФорма.Номер);
		Структура.Вставить("ДатаВыдачи", ЭтаФорма.ДатаВыдачи);
	КонецЕсли;
	
	Если Элементы.ГруппаЛицензия.Видимость Тогда
		Структура.Вставить("Серия",      ЭтаФорма.ЛицензияСерия);
		Структура.Вставить("Номер",      ЭтаФорма.ЛицензияНомер);
		Структура.Вставить("ДатаВыдачи", ЭтаФорма.ЛицензияДатаС);
		Структура.Вставить("ДатаОкончанияДействия", ЭтаФорма.ЛицензияДатаПо);
	КонецЕсли;
	
	// СНИЛС
	Если ЭтаФорма.ИспользоватьСНИЛС Тогда
		Структура.Вставить("СНИЛС", ЭтаФорма.СНИЛС);
	КонецЕсли;
	
	Структура.Вставить("Удалить", УдалитьЗапись());
	
	ЭтаФорма.Закрыть(Структура);
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьВсеПоля(Команда)
	
	ОчиститьРеквизитыФормы();
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьДанныеПоВУ(Команда)
	
	Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
	
	// Строка с файловыми фильтрами
	ФильтрКартинки = "Изображения (*.png; *.jpg; *.jpeg; *.gif)|*.png;*.jpg; *.jpeg; *.gif";
	ФильтрСканы    = "Сканы (*.pdf; *.tiff)|*.pdf;*.tiff";
	
	Диалог.Фильтр             = ФильтрКартинки + "|" + ФильтрСканы;
	Диалог.МножественныйВыбор = Ложь; // выбор только одного файла
	Диалог.Заголовок          = "Выберите скан ВУ"; // Текст заголовка окна выбора
	
	ОповещениеЗавершения = Новый ОписаниеОповещения("ПриВыбореФайлаВУ", ЭтаФорма);
	
	Диалог.Показать(ОповещениеЗавершения); // Открываем окно выбора файла
	
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОчиститьРеквизитыФормы()
	
	РеквизитыИсключения = Новый Массив;
	РеквизитыИсключения.Добавить("Роль");
	РеквизитыИсключения.Добавить("Объект");
	РеквизитыИсключения.Добавить("ЭтоВО");
	РеквизитыИсключения.Добавить("ДвоичныеДанныеОбработки");
	
	МодульКода("Saby_ТНОбщегоНазначенияСервер").ОчиститьРеквизитыФормы(ЭтаФорма, РеквизитыИсключения);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьВидимостьДоступностьРеквизитов(Знач ДанныеЗаполнения)
	
	ЭтаФорма.ТолькоПросмотр = ТолькоПросмотр;
	
	МодульКлиентСервер = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер");
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("ГруппаЗаполнениеДанных");
	МассивЭлементов.Добавить("ФормаУстановитьНовыеДанные");
	МассивЭлементов.Добавить("ФормаОчиститьВсеПоля");
	
	МодульКлиентСервер.ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Не ЭтаФорма.ТолькоПросмотр, МассивЭлементов);
	
	Роли = ПризнакиРолей(ЭтаФорма.Роль);
	
	// скроем загрузку по дефолту
	Элементы.ДекорацияЗагрузкаВУ.Видимость = Ложь;
	
	// СНИЛС
	Элементы.СНИЛС.Видимость = ЭтаФорма.ИспользоватьСНИЛС;
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("ИНН");
	МассивЭлементов.Добавить("ГруппаВУ");
	МассивЭлементов.Добавить("ГруппаЗаполнитьПоВУ");
	
	МодульКлиентСервер.ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Роли.ЭтоВодитель, МассивЭлементов);
	
	Элементы.ГруппаТелефоны.Видимость = Роли.ЭтоВодитель Или Роли.ЭтоОформитель Или Роли.ЭтоОтветственныйЗаПеревозку;
	Элементы.ГруппаЛицензия.Видимость = Роли.ЭтоМедик;
	
	МассивЭлементов = Новый Массив;
	МассивЭлементов.Добавить("ГруппаФИОИНН");
	МассивЭлементов.Добавить("Телефоны");
	МассивЭлементов.Добавить("ГруппаВУ");
	МассивЭлементов.Добавить("ГруппаЛицензия");
	МассивЭлементов.Добавить("СНИЛС");
	
	МодульКлиентСервер.ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "ТолькоПросмотр", ЭтаФорма.ТолькоПросмотр, МассивЭлементов);
	
	// дополнительные условия
	Если Параметры.Свойство("СкрываемыеЭлементы") Тогда
		
		МодульКлиентСервер.ИзменитьСвойствоЭлементовФормы(
			ЭтаФорма, "Видимость", Ложь, Параметры.СкрываемыеЭлементы);
		
	КонецЕсли;
	
КонецПроцедуры	

&НаСервере
Функция ПризнакиРолей(Роль)
	
	СтруктураРолей = Новый Структура;
	СтруктураРолей.Вставить("ЭтоВодитель",                 Ложь);
	СтруктураРолей.Вставить("ЭтоОтветственный",            Ложь);
	СтруктураРолей.Вставить("ЭтоМедик",                    Ложь);
	СтруктураРолей.Вставить("ЭтоМеханик",                  Ложь);
	СтруктураРолей.Вставить("ЭтоОформитель",               Ложь);
	СтруктураРолей.Вставить("ЭтоОтветственныйЗаПеревозку", Ложь);
	
	Если Роль = ЗначениеМетаданных("Saby_РолиОтветственных.Водитель") Тогда
		СтруктураРолей.ЭтоВодитель = Истина;
	ИначеЕсли Роль = ЗначениеМетаданных("Saby_РолиОтветственных.Техосмотр") Тогда
		СтруктураРолей.ЭтоМеханик = Истина;
	ИначеЕсли Роль = ЗначениеМетаданных("Saby_РолиОтветственных.ОформительДокумента") Тогда
		СтруктураРолей.ЭтоОформитель = Истина;
	ИначеЕсли Роль = ЗначениеМетаданных("Saby_РолиОтветственных.МедосмотрВыезд")
		Или Роль = ЗначениеМетаданных("Saby_РолиОтветственных.МедосмотрЗаезд") Тогда
		
		СтруктураРолей.ЭтоМедик = Истина;
		
	ИначеЕсли Роль = ЗначениеМетаданных("Saby_РолиОтветственных.Ответственный") Тогда
		СтруктураРолей.ЭтоОтветственный = Истина;
		СтруктураРолей.ЭтоОтветственныйЗаПеревозку = (ЭтаФорма.ИмяМетаданных = "Saby_ЗаказНаПеревозку");
	Иначе
		СтруктураРолей.ЭтоВодитель = Ложь;
	КонецЕсли;
	
	Возврат СтруктураРолей;
	
КонецФункции

&НаСервере
Процедура ЗаполнениеРеквизитовФормы(Знач ДанныеЗаполнения)
	
	МодульКода("Saby_ТНОбщегоНазначенияСервер").ЗаполнитьРеквизитыФормы(ЭтаФорма, ДанныеЗаполнения);
	
	ЭтаФорма.ТолькоПросмотр = ДанныеЗаполнения.Свойство("ТолькоПросмотр")
		И ДанныеЗаполнения.ТолькоПросмотр = Истина;
	
	Роли = ПризнакиРолей(ЭтаФорма.Роль);
	
	ЗаполнениеПоСсылке = ДанныеЗаполнения.Свойство("ЗаполнениеПоСсылке");
	
	Если Не ЗаполнениеПоСсылке И Роли.ЭтоМедик И ДанныеЗаполнения.Свойство("Серия") Тогда
		
		ЭтаФорма.ЛицензияСерия  = ДанныеЗаполнения.Серия;
		ЭтаФорма.ЛицензияНомер  = ДанныеЗаполнения.Номер;
		ЭтаФорма.ЛицензияДатаС  = ДанныеЗаполнения.ДатаВыдачи;
		
		Если ДанныеЗаполнения.Свойство("ДатаОкончанияДействия") Тогда
			ЭтаФорма.ЛицензияДатаПо = ДанныеЗаполнения.ДатаОкончанияДействия;
		КонецЕсли;
		
	КонецЕсли;
	
	Если Параметры.Свойство("Наименование") Тогда
		ЭтаФорма.Заголовок = Параметры.Наименование;
	КонецЕсли;
	
	СформироватьНадписьТелефоныСтрокой();
	
	// СНИЛС
	Если Роли.ЭтоВодитель
		И ЭтаФорма.ИмяМетаданных = "Saby_ПутевойЛист" Тогда
		
		ЭтаФорма.ИспользоватьСНИЛС = ХранилищеОбщихНастроек.Загрузить("Saby", "ИспользоватьСНИЛС");
		
	КонецЕсли;
	
КонецПроцедуры

#Область Телефоны

&НаКлиенте
Процедура ТелефоныПослеУдаления(Элемент)
	СформироватьНадписьТелефоныСтрокой();
КонецПроцедуры

&НаСервере
Процедура СформироватьНадписьТелефоныСтрокой()
	
	Массив = Новый Массив;
	Для Каждого Строка Из ЭтаФорма.Телефоны Цикл
		
		Если ЗначениеЗаполнено(Строка.Телефон) Тогда
			Массив.Добавить(СокрЛП(Строка.Телефон));
		КонецЕсли;
		
	КонецЦикла;
	
	Если Массив.Количество() Тогда
		ЭтаФорма.ТелефоныСтрокой = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").СтрСоединитьЭПД(Массив, ", ");
	Иначе
		ЭтаФорма.ТелефоныСтрокой = "";
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ТелефоныТелефонПриИзменении(Элемент)
	СформироватьНадписьТелефоныСтрокой();
КонецПроцедуры

&НаКлиенте
Процедура ТелефоныСтрокойНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЭтаФорма.ТекущийЭлемент = Элементы.Телефоны;
	
КонецПроцедуры

#КонецОбласти // Телефоны

&НаКлиенте
Процедура ОбработкаВыбораВодителя(ВыбранныйЭлемент, ДопПараметры) Экспорт
	
	Если ВыбранныйЭлемент <> Неопределено Тогда
		ЭтаФорма.ФизЛицо = ВыбранныйЭлемент;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СсылкаПриИзменении(Элемент)
	ОбновитьДанныеПоСсылке();
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанныеПоСсылке()
	
	Если Не ЗначениеЗаполнено(ЭтаФорма.ФизЛицо) Тогда
		Возврат;
	КонецЕсли;
	
	Результат = ОбновитьДанныеОтветственногоЭПД();
	
	Если Результат.Ошибка Тогда
		
		МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ОповеститьПользователяОРезультатах(
			ЭтаФорма, "ЗаполнитьИзINI", Результат);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Функция ОбновитьДанныеОтветственногоЭПД()
	
	ПараметрыРасчета = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ПараметрыЗаполненияНаОснованииINI();
	ПараметрыРасчета.Вставить("ini_name",  "Blockly_ДанныеОтветственногоЭПД_ЭТрН_read");
	ПараметрыРасчета.Вставить("Основание", ЭтаФорма.ФизЛицо);
	
	РезультатРасчета = Неопределено;
	Если ЭтаФорма.ЭтоВО Тогда
		ТранспортВО = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ТранспортВО(ЭтаФорма, ПараметрыРасчета.context_params);
		РезультатРасчета = РезультатРасчетаINI(ПараметрыРасчета, ТранспортВО.ТранспортБлокли);
	КонецЕсли;
	
	Результат = ЗаполнитьДанныеОтветственногоЭПД_НаОснованииINI(ПараметрыРасчета, РезультатРасчета);
	
	Если Результат.Свойство("ДанныеОтветственногоЭПД") Тогда
		Результат.ДанныеОтветственногоЭПД.Вставить("ЗаполнениеПоСсылке", Истина);
		ЗаполнениеРеквизитовФормы(Результат.ДанныеОтветственногоЭПД);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

&НаСервере
Функция ЗаполнитьДанныеОтветственногоЭПД_НаОснованииINI(Знач ПараметрыРасчета, Знач РезультатРасчета = Неопределено)
	
	Если РезультатРасчета = Неопределено Тогда
		ОбъектОбработки = Обработки.SABY.Создать();
		РезультатРасчета = МодульКода("Saby_ТНОбщегоНазначенияСервер").РезультатРасчетаINI(ПараметрыРасчета, ОбъектОбработки);
	КонецЕсли;
	
	Если РезультатРасчета.Результат.Ошибка Тогда
		
		Возврат РезультатРасчета.Результат;
		
	ИначеЕсли НЕ ЗначениеЗаполнено(РезультатРасчета.ДанныеИзИНИ) Тогда
		
		РезультатРасчета.Результат.Ошибка          = Истина;
		РезультатРасчета.Результат.ТекстСообщения  = Нстр("ru = 'Не удалось получить данные с сервера.
			|Обратитесь к администратору системы'");
		
	Иначе
		
		ДанныеИНИ = РезультатРасчета.ДанныеИзИНИ;
		
		ДляДокумента = Новый Структура;
		ДляДокумента.Вставить("ОтветственныеЛица", Новый Массив);
		ДляДокумента.Вставить("ДокументыЭПД",      Новый Массив);
		
		ДопПараметры = Новый Структура;
		ДопПараметры.Вставить("ЗагрузкаСОнлайна", Ложь);
		
		МодульКода("Saby_ТНЗагрузкаСервер").ДанныеВодителей(ЭтотОбъект, ДляДокумента, ДанныеИНИ["Водители"], ДопПараметры);
		
		Структура = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").СтруктураОтветственногоЛица();
		Если ЗначениеЗаполнено(ДляДокумента.ОтветственныеЛица) Тогда
			
			ДанныеОтветственногоЭПД      = ДляДокумента.ОтветственныеЛица[0];
			ДанныеОтветственногоЭПД.Роль = Роль;
			
			ЗаполнитьЗначенияСвойств(Структура, ДанныеОтветственногоЭПД);
			
			РезультатРасчета.Результат.Вставить("ДанныеОтветственногоЭПД", Структура);
			
		КонецЕсли;
		
	КонецЕсли;
	
	Возврат РезультатРасчета.Результат;
	
КонецФункции

&НаСервере
Функция ТелефоныЭлектроннаяПочтаСериализовать()
	
	Если ЭтаФорма.Телефоны.Количество() Тогда
		МассивТелефонов = Новый Массив;
		Для Каждого Строка Из ЭтаФорма.Телефоны Цикл
			МассивТелефонов.Добавить(Строка.Телефон);
		КонецЦикла;
		
		ВсеТелефоныСтрокой = ЗначениеВСтрокуВнутр(МассивТелефонов);
	Иначе
		ВсеТелефоныСтрокой = "";
	КонецЕсли;
	
	Если ЭтаФорма.ЭлектроннаяПочта.Количество() > 0 Тогда
		МассивЭлектроннаяПочта = Новый Массив;
		Для Каждого Строка Из ЭтаФорма.ЭлектроннаяПочта Цикл
			МассивЭлектроннаяПочта.Добавить(Строка.ЭлектроннаяПочта);
		КонецЦикла;
		
		ВсеЭлектронныеПочтыСтрокой = ЗначениеВСтрокуВнутр(МассивЭлектроннаяПочта);
	Иначе
		ВсеЭлектронныеПочтыСтрокой = "";
	КонецЕсли;
	
	Структура = Новый Структура;
	Структура.Вставить("Телефоны",         ВсеТелефоныСтрокой);
	Структура.Вставить("ЭлектроннаяПочта", ВсеЭлектронныеПочтыСтрокой);
	
	Возврат Структура;
	
КонецФункции

&НаКлиенте
Функция УдалитьЗапись()
	
	Возврат Не ЗначениеЗаполнено(ЭтаФорма.Фамилия)
		И Не ЗначениеЗаполнено(ЭтаФорма.Имя)
		И Не ЗначениеЗаполнено(ЭтаФорма.Отчество);
	
КонецФункции

&НаСервере
Процедура УстановитьТипыРеквизитов()
	
	// Физические лица
	МассивПроверяемыхТипов = Новый Массив;
	МассивПроверяемыхТипов.Добавить("Справочники.ФизическиеЛица");
	
	МодульКода("Saby_ТНОбщегоНазначенияСервер").УстановитьОграниченияТипов(Элементы.ФизЛицо, МассивПроверяемыхТипов);
	
КонецПроцедуры

&НаКлиенте
Процедура ПриВыбореФайлаВУ(ВыбранныйФайл, ДополнительныеПараметры) Экспорт
	
	Если ВыбранныйФайл <> Неопределено Тогда
		
		Элементы.ДекорацияЗагрузкаВУ.Видимость = Истина;
		
		// очистим поля
		ОчиститьРеквизитыФормы();
		
		ИмяФайлаВУ       = ВыбранныйФайл[0];
		ДвоичныеДанные   = Новый ДвоичныеДанные(ИмяФайлаВУ);
		ЗакодированныеДД = Base64Строка(ДвоичныеДанные);
		
		// переводим в фоновое выполнение
		ДопПараметры = Новый Структура;
		ДопПараметры.Вставить("ЗакодированныеДД",        ЗакодированныеДД);
		ДопПараметры.Вставить("ДвоичныеДанныеОбработки", ЭтаФорма.ДвоичныеДанныеОбработки);
		ДопПараметры.Вставить("НаКлиенте",               ЭтаФорма.ЭтоВО);
		ДопПараметры.Вставить("ОтветНаКлиенте",          Неопределено);
		
		МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ВыполнитьКомандуСбис(
			ЭтаФорма,
			"РаспознаваниеВУ", ,
			ДопПараметры);
		
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбработатьРезультатРаспознаванияВУНаСервере(Ответ) Экспорт
	
	Ошибка = Ложь;
	Если Ответ.Ошибка
		Или Не ЗначениеЗаполнено(Ответ.Результат) Тогда
		
		Причина = МодульКода("Saby_ТНОбщегоНазначенияСервер").ПричинаОшибкиИзЯдра(Ответ.ОписаниеОшибки);
		Ошибка = Истина;
		
	КонецЕсли;
	
	Если Не Ошибка Тогда
		
		ДанныеВУ = Ответ.Результат;		
		
		ИмяОтчествоСтрокой = ДанныеВУ["NamePatronymic"];
		
		Если ИмяОтчествоСтрокой <> Неопределено Тогда
						
			// ФИО
			ИмяОтчество = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").СтрРазделитьЭПД(ИмяОтчествоСтрокой, " ");
			
			ЭтаФорма.Фамилия  = ТРег(ДанныеВУ["Surname"]);
			ЭтаФорма.Имя      = ТРег(ИмяОтчество[0]);
			ЭтаФорма.Отчество = ?(ИмяОтчество.Количество() > 1, ТРег(ИмяОтчество[1]), "");
			
			// Серия и номер
			ЭтаФорма.Серия = Лев(ДанныеВУ["Id"], 4);
			ЭтаФорма.Номер = Прав(ДанныеВУ["Id"], 6);
			
			ЭтаФорма.ДатаВыдачи = ВыполнитьНаСервере("Saby_ТНОбщегоНазначенияСервер.ПреобразоватьСтрокуВДатуЭПД", ДанныеВУ["RegDate"]);
			
			Элементы.ДекорацияЗагрузкаВУ.Видимость = Ложь;
						
		КонецЕсли;
		
	КонецЕсли;
	
	Если Ошибка Тогда
		
		Сообщение = Новый СообщениеПользователю();
		Сообщение.Текст = "Ошибка распознавания скана ВУ. " + Причина;
		Сообщение.Сообщить();
		
		Элементы.ДекорацияЗагрузкаВУ.Видимость = Ложь;
		
    КонецЕсли;
		
КонецПроцедуры

#Область include_etrn_base_CommonForm_ОтветственныйЭПД_СлужебныеПроцедурыИФункции
#КонецОбласти // include_etrn_base_CommonForm_ОтветственныйЭПД_СлужебныеПроцедурыИФункции

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_Авторизация
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_Авторизация

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_ОбработкаОповещений
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиент_ОбработкаОповещений

#Область include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиентСервер_ПолучениеДанныхИзКоллекций //&НаКлиенте
#КонецОбласти // include_etrn_base_CommonModule_ТНОбщегоНазначенияКлиентСервер_ПолучениеДанныхИзКоллекций //&НаКлиенте


#КонецОбласти // СлужебныеПроцедурыИФункции