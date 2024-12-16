
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЭтаФорма.РольСтрокой = Параметры.РольСтрокой;
	ЭтаФорма.ЭтоВО       = Параметры.ЭтоВО;
	
	ИмяКонфигурации       = МодульКода("Saby_ТНОбщегоНазначенияСервер").ИмяКонфигурации();
	ДоступныеКонфигурации = МодульКода("Saby_ТНОбщегоНазначенияСервер").ДоступныеКонфигурации();
	
	Если ИмяКонфигурации = ДоступныеКонфигурации.УАТ Тогда
		ЭтаФорма.ИмяИНИ = "Blockly_ДанныеКонтрагентаОрганизации_ЭПЛ_read";
	Иначе
		ЭтаФорма.ИмяИНИ = "Blockly_ДанныеКонтрагентаОрганизации_ЭТрН_read";
	КонецЕсли;
	
	ЗаполнениеРеквизитовФормы(Параметры, Истина);
	
	УстановитьТипыРеквизитов();
	
	ОбновитьВидимостьИДоступностьЭлементов();
	
	НастроитьФормуДляСтарыхПлатформ();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьПоСсылке(Команда)
	
	ОбновитьДанныеПоСсылке();
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьНовыеДанные(Команда)
	
	Если ЭтаФорма.ЭтоИП Тогда
		
		ФИО = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ПредставлениеФИО(ЭтаФорма);
		ЭтаФорма.НаименованиеОрганизации = "ИП " + ФИО;
		
		СтруктураФИО = ФИОСтрокой(ЭтаФорма.Фамилия, ЭтаФорма.Имя, ЭтаФорма.Отчество);
		
	Иначе
		СтруктураФИО = "";
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ЭтаФорма.РольСтрокой) Тогда
		Роль = ЗначениеМетаданныхКлиент("Saby_РолиКонтрагентов." + ЭтаФорма.РольСтрокой);
	Иначе
		Роль = ЗначениеМетаданныхКлиент("Saby_РолиКонтрагентов.ПустаяСсылка");
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ЭтаФорма.ЮрФизЛицоСтрокой) Тогда
		ЮрФизЛицо = ЗначениеМетаданныхКлиент("Saby_ЮрФизЛицо." + ЭтаФорма.ЮрФизЛицоСтрокой);
	Иначе
		ЮрФизЛицо = ЗначениеМетаданныхКлиент("Saby_ЮрФизЛицо.ПустаяСсылка");
	КонецЕсли;
	
	Если ЭтаФорма.ЭтоВО Тогда
		ДокументыЮрЛиц = МодульКодаКлиент("ЭтаФорма").СформироватьДокументыЭПД(ЭтаФорма.ДокументыЭПД, ЭтаФорма.ДанныеЮрЛиц);
	Иначе
		ДокументыЮрЛиц = Новый Массив;
	КонецЕсли;
	
	Структура = Новый Структура;
	Структура.Вставить("Роль",                    Роль);
	Структура.Вставить("РольСтрокой",             ЭтаФорма.РольСтрокой);
	Структура.Вставить("ИНН",                     ЭтаФорма.ИНН);
	Структура.Вставить("КПП",                     ЭтаФорма.КПП);
	Структура.Вставить("ОГРН",                    ЭтаФорма.ОГРН);
	Структура.Вставить("ЮрФизЛицо",               ЮрФизЛицо);
	Структура.Вставить("ЮрФизЛицоСтрокой",        ЭтаФорма.ЮрФизЛицоСтрокой);
	Структура.Вставить("СтруктураФИО",            СтруктураФИО);
	Структура.Вставить("Адрес",                   ЭтаФорма.Адрес);
	Структура.Вставить("АдресСтруктура",          ЭтаФорма.АдресСтруктура);
	Структура.Вставить("СтранаРегистрации",       ЭтаФорма.СтранаРегистрации);
	Структура.Вставить("КодФилиала",              ЭтаФорма.КодФилиала);
	Структура.Вставить("Полномочия",              ЭтаФорма.Полномочия);
	Структура.Вставить("Основание",               ЭтаФорма.Основание);
	Структура.Вставить("НаименованиеОрганизации", ЭтаФорма.НаименованиеОрганизации);
	Структура.Вставить("ЭлементФормы",            ЭтаФорма.ЭлементФормы);
	Структура.Вставить("КонтактныеДанные",        КонтактныеДанные(ЭтаФорма.КонтактныеДанные));
	Структура.Вставить("ДокументыЭПД",            ДокументыЮрЛиц);
	Структура.Вставить("Удалить",                 УдалитьЗапись());
	Структура.Вставить("ИдентификаторЭДО",        ЭтаФорма.ИдентификаторЭДО);
	
	ЗаписатьИдентификаторЭДО(КонтрагентОрганизация, ЭтаФорма.ИдентификаторЭДО);
	
	ЭтаФорма.Закрыть(Структура);
	
КонецПроцедуры

&НаКлиенте
Процедура ОчиститьВсеПоля(Команда)
	
	ОчиститьРеквизитыФормы();
	
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура КонтрагентОрганизацияПриИзменении(Элемент)
	ОбновитьДанныеПоСсылке();
КонецПроцедуры

&НаКлиенте
Процедура АдресДоставкиНажатие(Элемент)
	ИзменитьАдрес(Ложь);
КонецПроцедуры

&НаКлиенте
Процедура АдресНажатие(Элемент, СтандартнаяОбработка)
	ИзменитьАдрес(СтандартнаяОбработка);
КонецПроцедуры

&НаКлиенте
Процедура ОснованиеОформителяОткрытие(Элемент, СтандартнаяОбработка)
	
	Если ЭтаФорма.ЭтоВО Тогда 
		
		ПараметрыДокумента = МодульКодаКлиент("ЭтаФорма").ПараметрыДокументаЭПД(
			"ОформительОснование",
			"Основание оформления ЭТрН",
			"Основание",
			"ДокументЭПД");
		
		МодульКодаКлиент("ЭтаФорма").ОткрытьДокументЭПД(ПараметрыДокумента, СтандартнаяОбработка);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ОснованиеОткрытие(Элемент, СтандартнаяОбработка)
	
	Если ЭтаФорма.ЭтоВО Тогда
		
		ПараметрыДокумента = МодульКодаКлиент("ЭтаФорма").ПараметрыДокументаЭПД(
			"ОснованиеПолномочий",
			"Основание полномочий",
			"Основание",
			"ДокументЭПД");
		
		МодульКодаКлиент("ЭтаФорма").ОткрытьДокументЭПД(ПараметрыДокумента, СтандартнаяОбработка);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ИдентификаторЭДОПриИзменении(Элемент)
	
	ЭтаФорма.ИдентификаторЭДОИзменен = Истина;
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийЭлементовШапкиФормы

#Область ОбработчикиСобытийЭлементовТаблицыФормыКонтактныеДанные

&НаКлиенте
Процедура КонтактныеДанныеЗначениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ЗначениеКонтактныхДанныхНачалоВыбора(
		ЭтаФорма, Элементы.КонтактныеДанные.ТекущиеДанные, ЭтаФорма.РольСтрокой, СтандартнаяОбработка);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактныеДанныеЗначениеПриИзменении(Элемент)
	
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ЗначениеКонтактныхДанныхПриИзменении(
		ЭтаФорма, Элементы.КонтактныеДанные.ТекущиеДанные, ЭтаФорма.РольСтрокой);
	
КонецПроцедуры

&НаКлиенте
Процедура КонтактныеДанныеПриНачалеРедактирования(Элемент, НоваяСтрока, Копирование)
	
	Если НоваяСтрока Тогда
		Если Копирование Тогда
			Элементы.КонтактныеДанные.ТекущиеДанные.Основной = Ложь;
		КонецЕсли;
		ОбработатьНовуюСтрокуКонтактнойИнформации(Элемент.Имя);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийЭлементовТаблицыФормыКонтактныеДанные

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ОчиститьРеквизитыФормы()
	
	РеквизитыИсключения = Новый Массив;
	РеквизитыИсключения.Добавить("РольСтрокой");
	РеквизитыИсключения.Добавить("ЭлементФормы");
	РеквизитыИсключения.Добавить("Объект");
	РеквизитыИсключения.Добавить("ЭтоВО");
	РеквизитыИсключения.Добавить("ИмяИНИ");
	
	МодульКода("Saby_ТНОбщегоНазначенияСервер").ОчиститьРеквизитыФормы(ЭтаФорма, РеквизитыИсключения);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимостьИДоступностьЭлементов()
	
	УстановитьДоступНаЭлементы();
	
	МассивСкрыть   = Новый Массив;
	МассивПоказать = Новый Массив;
	
	ЭтаФорма.ЭтоИП = (ЭтаФорма.ЮрФизЛицоСтрокой = "ИндивидуальныйПредприниматель");
	
	Если ЭтаФорма.ЭтоИП Тогда
		
		МассивСкрыть.Добавить("НаименованиеОрганизации");
		МассивСкрыть.Добавить("КодФилиала");
		МассивСкрыть.Добавить("КПП");
		
		МассивПоказать.Добавить("ГруппаФИО");
		
	Иначе
		
		МассивСкрыть.Добавить("ГруппаФИО");
		
		МассивПоказать.Добавить("НаименованиеОрганизации");
		МассивПоказать.Добавить("КодФилиала");
		МассивПоказать.Добавить("КПП");
		
	КонецЕсли;
	
	МассивСкрыть.Добавить("СтранаРегистрации");
	
	Если ЗначениеЗаполнено(ЭтаФорма.Адрес) Тогда
		МассивСкрыть.Добавить("ДекорацияЗаполнитьАдресДоставки");
	Иначе
		МассивПоказать.Добавить("ДекорацияЗаполнитьАдресДоставки");
	КонецЕсли;
	
	ОбновитьВидимостьДоступностьПоРолям(МассивПоказать, МассивСкрыть);
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Истина, МассивПоказать);
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Ложь, МассивСкрыть);
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимостьДоступностьПоРолям(МассивПоказать, МассивСкрыть)
	
	// Для ВО форма используется для сторон документов ЭПД
	Если ЭтаФорма.РольСтрокой = "СторонаДокумента"
		Или ЭтаФорма.РольСтрокой = "ПустаяСсылка" Тогда
		ОбновитьВидимостьДоступностьСтороныДокумента(МассивПоказать, МассивСкрыть);
		Возврат;
	КонецЕсли;
	
	Если ЭтаФорма.РольСтрокой = "ИнойПолучатель" Тогда
		ОбновитьВидимостьДоступностьИнойПолучатель(МассивПоказать, МассивСкрыть);
		Возврат;
	КонецЕсли;
	
	ОбновитьВидимостьДоступностьПоОформителю(МассивПоказать, МассивСкрыть);
	
	Если ЭтаФорма.РольСтрокой = "УполномоченноеЛицо"
		Или ЭтаФорма.РольСтрокой = "УполномоченноеЛицоПеревозчика" Тогда
		
		МассивПоказать.Добавить("ГруппаПолномочия");
		
		Если ЭтаФорма.РольСтрокой = "УполномоченноеЛицоПеревозчика" Тогда
			Элементы.Полномочия.Доступность = Ложь;
		КонецЕсли;
	
	Иначе
		МассивСкрыть.Добавить("ГруппаПолномочия");
	КонецЕсли;
	
	Если ЭтаФорма.РольСтрокой = "МедосмотрВыезд" Или ЭтаФорма.РольСтрокой = "МедосмотрЗаезд" Тогда
		МассивСкрыть.Добавить("ГруппаАдрес");
		МассивСкрыть.Добавить("КодФилиала");
	КонецЕсли;
	
	МассивСкрыть.Добавить("ИдентификаторЭДО");
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимостьДоступностьПоОформителю(МассивПоказать, МассивСкрыть)
	
	ЭтоПутевойЛист = (ЭтаФорма.ТипДокументаИсточника = "Saby_ПутевойЛист");
	РольОформитель = "Оформитель";
	
	Если (ЭтоПутевойЛист И ЭтаФорма.РольСтрокой <> РольОформитель) Или ЭтаФорма.РольСтрокой = "СторонаДокумента" Тогда
		МассивСкрыть.Добавить("ГруппаКонтакты");
	КонецЕсли;
	
	ПоказатьОснование = ЭтаФорма.РольСтрокой = РольОформитель И Не ЭтаФорма.ЭтоВО И Не ЭтоПутевойЛист;
	
	Если ПоказатьОснование Тогда
		МассивПоказать.Добавить("ГруппаОснованиеОформителя");
	Иначе
		МассивСкрыть.Добавить("ГруппаОснованиеОформителя");
	КонецЕсли;
	
	Если ЭтаФорма.РольСтрокой <> РольОформитель И ЭтаФорма.РольСтрокой <> "Отправитель" Тогда
		МассивСкрыть.Добавить("КодФилиала");
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимостьДоступностьСтороныДокумента(МассивПоказать, МассивСкрыть)
	
	МассивСкрыть.Добавить("ГруппаПолномочия");
	МассивСкрыть.Добавить("ГруппаОснованиеОформителя");
	МассивСкрыть.Добавить("ГруппаАдрес");
	МассивСкрыть.Добавить("КПП");
	МассивСкрыть.Добавить("КодФилиала");
	МассивСкрыть.Добавить("ГруппаКонтакты");
	МассивСкрыть.Добавить("ИдентификаторЭДО");
	
КонецПроцедуры

&НаСервере
Процедура ОбновитьВидимостьДоступностьИнойПолучатель(МассивПоказать, МассивСкрыть)
	
	МассивСкрыть.Добавить("ГруппаПолномочия");
	МассивСкрыть.Добавить("ГруппаОснованиеОформителя");
	МассивСкрыть.Добавить("ГруппаАдрес");
	МассивСкрыть.Добавить("ГруппаКонтакты");
	
КонецПроцедуры

&НаСервере
Процедура УстановитьДоступНаЭлементы()
	
	МассивТолькоПросмотр = Новый Массив;
	МассивТолькоПросмотр.Добавить("ФормаЗаписатьИЗакрыть");
	МассивТолькоПросмотр.Добавить("ФормаОчиститьВсеПоля");
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "Видимость", Не ЭтаФорма.ТолькоПросмотрФормы, МассивТолькоПросмотр);
	
	МассивТолькоПросмотр.Очистить();
	// МассивТолькоПросмотр.Добавить("ЮрФизЛицо");
	
	МассивТолькоПросмотр.Добавить("ЮрФизЛицоСтрокой");
	МассивТолькоПросмотр.Добавить("НаименованиеОрганизации");
	МассивТолькоПросмотр.Добавить("ГруппаФИО");
	МассивТолькоПросмотр.Добавить("ГруппаКоды");
	МассивТолькоПросмотр.Добавить("СтранаРегистрации");
	МассивТолькоПросмотр.Добавить("ГруппаАдрес");
	МассивТолькоПросмотр.Добавить("ГруппаКонтакты");
	МассивТолькоПросмотр.Добавить("ГруппаПолномочия");
	МассивТолькоПросмотр.Добавить("ГруппаОснованиеОформителя");
	
	МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИзменитьСвойствоЭлементовФормы(
		ЭтаФорма, "ТолькоПросмотр", ЭтаФорма.ТолькоПросмотрФормы, МассивТолькоПросмотр);
	
	Элементы.ГруппаЗаполнениеДанных.Видимость            = Не ЭтаФорма.ТолькоПросмотрФормы;
	Элементы.ДекорацияЗаполнитьАдресДоставки.Доступность = Не ЭтаФорма.ТолькоПросмотрФормы;
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнениеРеквизитовФормы(Знач ДанныеЗаполнения, Знач ВызовПриСозданииНаСервере = Ложь)
	
	Если Параметры.Свойство("ТолькоПросмотр") Тогда
		ЭтаФорма.ТолькоПросмотрФормы = Параметры.ТолькоПросмотр;
	КонецЕсли;
	
	Если Параметры.Свойство("Наименование") Тогда
		ЭтаФорма.Заголовок = Параметры.Наименование;
	КонецЕсли;
	
	МодульКода("Saby_ТНОбщегоНазначенияСервер").ЗаполнитьРеквизитыФормы(ЭтаФорма, ДанныеЗаполнения);
	
	Если ЗначениеЗаполнено(ДанныеЗаполнения.ЮрФизЛицо) Тогда
		ЭтаФорма.ЮрФизЛицоСтрокой = ДанныеЗаполнения.ЮрФизЛицоСтрокой;
	Иначе
		ЭтаФорма.ЮрФизЛицоСтрокой = "ЮрЛицо";
	КонецЕсли;
	
	ЭтаФорма.ЭтоИП = (ЭтаФорма.ЮрФизЛицоСтрокой = "ИндивидуальныйПредприниматель");
	Если ЭтоИП И ДанныеЗаполнения.Свойство("СтруктураФИО") Тогда
		Если ЗначениеЗаполнено(ДанныеЗаполнения.СтруктураФИО) Тогда
			СтруктураФИО = ЗначениеИзСтрокиВнутр(ДанныеЗаполнения.СтруктураФИО);
			ЗаполнитьЗначенияСвойств(ЭтаФорма, СтруктураФИО);
		КонецЕсли;
	КонецЕсли;
	
	Если ДанныеЗаполнения.Свойство("ЭлементФормы") Тогда
		ЭтаФорма.ЭлементФормы = ДанныеЗаполнения.ЭлементФормы;
	КонецЕсли;
	
	Если ЭтаФорма.РольСтрокой = "УполномоченноеЛицоПеревозчика" Тогда
		ЭтаФорма.Полномочия = 1;
	КонецЕсли;
	
	МожемПопробоватьЗаполнитьСсылку = Не ЭтаФорма.ТолькоПросмотрФормы
		И ВызовПриСозданииНаСервере
		И (ЗначениеЗаполнено(ЭтаФорма.ИНН)
			ИЛИ ЗначениеЗаполнено(ЭтаФорма.КПП)
			Или ЗначениеЗаполнено(ЭтаФорма.НаименованиеОрганизации));
	
	Если МожемПопробоватьЗаполнитьСсылку Тогда
		ЭтаФорма.КонтрагентОрганизация = МодульКода("Saby_ТНОбщегоНазначенияСервер").ОрганизацияКонтрагент(
			ЭтаФорма.ИНН, ЭтаФорма.КПП, ЭтаФорма.НаименованиеОрганизации).Ссылка;
	КонецЕсли;
	
КонецПроцедуры

#Область Телефоны

&НаКлиенте
Процедура ТелефоныТелефонПриИзменении(Элемент)
КонецПроцедуры

&НаКлиенте
Процедура ТелефоныСтрокойНажатие(Элемент, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	ЭтаФорма.ТекущийЭлемент = Элементы.Телефоны;
	
КонецПроцедуры

&НаКлиенте
Процедура ТелефоныПослеУдаления(Элемент)
КонецПроцедуры

#КонецОбласти // Телефоны

&НаКлиенте
Процедура ОбработкаВыбораВодителя(ВыбранныйЭлемент, ДопПараметры) Экспорт
	
	Если ВыбранныйЭлемент <> Неопределено Тогда
		ЭтаФорма.Водитель = ВыбранныйЭлемент;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура СсылкаПриИзменении(Элемент)
	
	ОбновитьДанныеПоСсылке();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьДанныеПоСсылке()
	
	Если Не ЗначениеЗаполнено(ЭтаФорма.КонтрагентОрганизация) Тогда
		Возврат;
	КонецЕсли;
	
	Результат = ОбновитьДанныеЮрЛиц();
	
	Если Результат.Ошибка Тогда
		
		МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ОповеститьПользователяОРезультатах(
			ЭтаФорма, "ЗаполнитьИзINI", Результат);
		
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЮрФизЛицоПриИзменении(Элемент)
	
	ОбновитьВидимостьИДоступностьЭлементов();
	
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВидимостьИДоступностьЭлементовНаКлиенте() Экспорт
	ОбновитьВидимостьИДоступностьЭлементов();
КонецПроцедуры

&НаСервереБезКонтекста
Функция ФИОСтрокой(Знач Фамилия, Знач Имя, Знач Отчество)
	
	СтруктураФИО = Новый Структура;
	СтруктураФИО.Вставить("Фамилия",  Фамилия);
	СтруктураФИО.Вставить("Имя",      Имя);
	СтруктураФИО.Вставить("Отчество", Отчество);
	
	Возврат ЗначениеВСтрокуВнутр(СтруктураФИО);
	
КонецФункции

&НаКлиенте
Функция ОбновитьДанныеЮрЛиц()
	
	ПараметрыРасчета = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").ПараметрыЗаполненияНаОснованииINI();
	ПараметрыРасчета.Вставить("ini_name",  ЭтаФорма.ИмяИНИ);
	ПараметрыРасчета.Вставить("Основание", ЭтаФорма.КонтрагентОрганизация);
	
	РезультатРасчета = Неопределено;
	Если ЭтаФорма.ЭтоВО Тогда
		ТранспортВО = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").ТранспортВО(ЭтаФорма, ПараметрыРасчета.context_params);
		РезультатРасчета = РезультатРасчетаINI(ПараметрыРасчета, ТранспортВО.ТранспортБлокли);
	КонецЕсли;
	
	Возврат ОбновитьДанныеЮрЛицНаСервере(ПараметрыРасчета, РезультатРасчета);
	
КонецФункции

&НаСервере
Функция ОбновитьДанныеЮрЛицНаСервере(Знач ПараметрыРасчета, Знач РезультатРасчета = Неопределено)
	
	// зачистка данных перед обновлением
	ЭтаФорма.ДанныеЮрЛиц.Очистить();
	ЭтаФорма.КонтактныеДанные.Очистить();
	
	Результат = ЗаполнитьДанныеЮрЛицНаОснованииINI(ПараметрыРасчета, РезультатРасчета);
	
	Если ЭтаФорма.ДанныеЮрЛиц.Количество() Тогда
		
		Строка    = ЭтаФорма.ДанныеЮрЛиц[0];
		Структура = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ШаблонДанныхЮрЛица();
		Структура.Удалить("КонтактныеДанные");
		
		Строка.РольСтрокой = ЭтаФорма.РольСтрокой;
		ЗаполнитьЗначенияСвойств(Структура, Строка);
		ЗаполнениеРеквизитовФормы(Структура);
		
		Структура.Заполнена = Истина;
		
	Иначе
		ОчиститьРеквизитыФормы();
	КонецЕсли;
	
	Для Каждого СтруктураКонтактныхДанных Из ЭтаФорма.КонтактныеДанные Цикл
		СтруктураКонтактныхДанных.РольСтрокой            = ЭтаФорма.РольСтрокой;
		СтруктураКонтактныхДанных.КлючСтроки_ДанныеЮрЛиц = ЭтаФорма.КлючСтроки;
	КонецЦикла;
	
	ОбновитьВидимостьИДоступностьЭлементов();
	
	Возврат Результат;
	
КонецФункции

&НаКлиенте
Функция КонтактныеДанные(ТаблицаКонтактныхДанных)
	
	РезультатФункции = Новый Массив;
	
	Для Каждого СтрокаКонтактныхДанных Из ТаблицаКонтактныхДанных Цикл
		
		СтруктураКонтактныхДанных = МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиентСервер").СтруктураКонтактныхДанных();
		ЗаполнитьЗначенияСвойств(СтруктураКонтактныхДанных, СтрокаКонтактныхДанных);
		
		РезультатФункции.Добавить(СтруктураКонтактныхДанных);
		
	КонецЦикла;
	
	Возврат РезультатФункции;
	
КонецФункции

&НаКлиенте
Процедура ОбработатьНовуюСтрокуКонтактнойИнформации(ИмяТЧ)
	
	Отбор = Новый Структура;
	Отбор.Вставить("РольСтрокой", "");
	
	НайденныеСтроки = КонтактныеДанные.НайтиСтроки(Отбор);
	Для Каждого Строка Из НайденныеСтроки Цикл
		Строка.РольСтрокой            = ЭтаФорма.РольСтрокой;
		Строка.КлючСтроки_ДанныеЮрЛиц = ЭтаФорма.КлючСтроки;
	КонецЦикла;
	
КонецПроцедуры

&НаКлиенте
Функция УдалитьЗапись()
	
	Если ЭтаФорма.ЭтоИП Тогда
		Возврат Не ЗначениеЗаполнено(ЭтаФорма.Фамилия)
			И Не ЗначениеЗаполнено(ЭтаФорма.Имя)
			И Не ЗначениеЗаполнено(ЭтаФорма.Отчество)
			И Не ЗначениеЗаполнено(ЭтаФорма.ИНН);
	Иначе
		Возврат Не ЗначениеЗаполнено(ЭтаФорма.ИНН)
			И Не ЗначениеЗаполнено(ЭтаФорма.КПП)
			И Не ЗначениеЗаполнено(ЭтаФорма.НаименованиеОрганизации);
	КонецЕсли;
	
КонецФункции

&НаКлиенте
Процедура ИзменитьАдрес(СтандартнаяОбработка)
	
	ПараметрыВыбораАдреса = Новый Структура;
	ПараметрыВыбораАдреса.Вставить("РольСтрокой",    ЭтаФорма.РольСтрокой);
	ПараметрыВыбораАдреса.Вставить("Значение",       ЭтаФорма.АдресСтруктура);
	ПараметрыВыбораАдреса.Вставить("Текст",          ЭтаФорма.Адрес);
	ПараметрыВыбораАдреса.Вставить("ТолькоПросмотр", ЭтаФорма.ТолькоПросмотрФормы);
	
	МодульКодаКлиент("Saby_ТНОбщегоНазначенияКлиент").АдресНачалоВыбора(ЭтаФорма, ПараметрыВыбораАдреса, СтандартнаяОбработка);
	
КонецПроцедуры

&НаСервере
Процедура УстановитьТипыРеквизитов()
	
	МодульТНОбщегоНазначенияСервер = МодульКода("Saby_ТНОбщегоНазначенияСервер");
	
	// Контрагенты и организации
	МассивПроверяемыхТипов = Новый Массив;
	МассивПроверяемыхТипов.Добавить("Справочники.Контрагенты");
	МассивПроверяемыхТипов.Добавить("Справочники.Организации");
	
	МодульТНОбщегоНазначенияСервер.УстановитьОграниченияТипов(Элементы.КонтрагентОрганизация, МассивПроверяемыхТипов);
	
	// Основание
	МассивТиповОснований = Новый Массив;
	Если ЭтаФорма.ЭтоВО Тогда
		МассивТиповОснований.Добавить("Строка");
	Иначе
		МассивТиповОснований.Добавить("Справочники.Saby_ДокументыЭПД");
	КонецЕсли;
	
	МодульТНОбщегоНазначенияСервер.УстановитьОграниченияТипов(Элементы.Основание, МассивТиповОснований);
	МодульТНОбщегоНазначенияСервер.УстановитьОграниченияТипов(Элементы.ОснованиеОформителя, МассивТиповОснований);
	
	Элементы.КонтактныеДанныеТип.СписокВыбора.Очистить();
	Элементы.КонтактныеДанныеТип.СписокВыбора.Добавить(
		ЗначениеМетаданных("ТипыКонтактнойИнформации.Телефон"), "Телефон");
	Элементы.КонтактныеДанныеТип.СписокВыбора.Добавить(
		ЗначениеМетаданных("ТипыКонтактнойИнформации.АдресЭлектроннойПочты"), "Адрес электронной почты");
	
КонецПроцедуры

&НаСервере
Функция ЗаполнитьДанныеЮрЛицНаОснованииINI(Знач ПараметрыРасчета, Знач РезультатРасчета)
	
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
		ДляДокумента.Вставить("ДанныеЮрЛиц",      Новый Массив);
		ДляДокумента.Вставить("КонтактныеДанные", Новый Массив);
		
		МодульКода("Saby_ТНЗагрузкаСервер").ЗагрузитьДанныеЮрЛиц(ДляДокумента, ДанныеИНИ, ЭтаФорма.РольСтрокой);
		
		Для Каждого ЭлементЮрЛиц Из ДляДокумента.ДанныеЮрЛиц Цикл
			НС = ЭтаФорма.ДанныеЮрЛиц.Добавить();
			ЗаполнитьЗначенияСвойств(НС, ЭлементЮрЛиц);
		КонецЦикла;
		
		Для Каждого ЭлементКИ Из ДляДокумента.КонтактныеДанные Цикл
			НС = ЭтаФорма.КонтактныеДанные.Добавить();
			ЗаполнитьЗначенияСвойств(НС, ЭлементКИ);
			
			// правка косяка с текущими типами перечисления
			Если НС.Тип = "Адрес электронной почты" Тогда
				НС.Тип = "АдресЭлектроннойПочты";
			КонецЕсли;
			
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат РезультатРасчета.Результат;
	
КонецФункции

&НаСервере
Процедура ЗаписатьИдентификаторЭДО(Знач СсылкаНаОбъект, Знач ЗначениеДляЗаписи)
	
	Если Не ЭтаФорма.ИдентификаторЭДОИзменен
		Или Не ЗначениеЗаполнено(СсылкаНаОбъект)
		Или Метаданные.РегистрыСведений.Найти("ДополнительныеСведения") = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ИмяСвойстваИдентификатор = МодульКода("Saby_ТНОбщегоНазначенияКлиентСервер").ИмяСвойстваИдентификатор();
	
	// BSLLS:SetPrivilegedMode-off
	УстановитьПривилегированныйРежим(Истина);
	// BSLLS:SetPrivilegedMode-on
	
	СвойствоДляЗаписи = СвойствоДляЗаписи(ИмяСвойстваИдентификатор);
	Если СвойствоДляЗаписи = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	МенеджерЗаписи = РегистрыСведений.ДополнительныеСведения.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.Объект	= СсылкаНаОбъект;
	МенеджерЗаписи.Свойство	= СвойствоДляЗаписи;
	МенеджерЗаписи.Значение	= ЗначениеДляЗаписи;
	
	Попытка
		МенеджерЗаписи.Записать(Истина);
	Исключение
		МенеджерЗаписи = Неопределено;
	КонецПопытки;
	
КонецПроцедуры

&НаСервере
Функция СвойствоДляЗаписи(ИмяСвойства)
	
	РазмерИдентификатора = 64;
	
	РезультатФункции = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.НайтиПоРеквизиту("Имя", ИмяСвойства);
	Если Не ЗначениеЗаполнено(РезультатФункции) Тогда
		РезультатФункции = ПланыВидовХарактеристик.ДополнительныеРеквизитыИСведения.СоздатьЭлемент();
		РезультатФункции.Наименование              = ИмяСвойства;
		РезультатФункции.Заголовок                 = ИмяСвойства;
		РезультатФункции.Имя                       = ИмяСвойства;
		РезультатФункции.ТипЗначения               = Новый ОписаниеТипов("Строка", , Новый КвалификаторыСтроки(РазмерИдентификатора));
		РезультатФункции.ЭтоДополнительноеСведение = Истина;
		Попытка
			РезультатФункции.Записать();
			РезультатФункции = РезультатФункции.Ссылка;
		Исключение
			РезультатФункции = Неопределено;
		КонецПопытки;
	КонецЕсли;
	
	Возврат РезультатФункции;
	
КонецФункции

#Область include_etrn_base_CommonForm_ОрганизацииЭПД_СлужебныеПроцедурыИФункции
#КонецОбласти // include_etrn_base_CommonForm_ОрганизацииЭПД_СлужебныеПроцедурыИФункции

#КонецОбласти
