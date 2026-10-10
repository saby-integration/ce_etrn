
#Область Record_ПрограммныйИнтерфейс

Функция Create(Значение = Неопределено, ТипыПолей = Неопределено) Экспорт
	// BSLLS:TooManyReturns-off
	// Создание без переданного значения
	Если Значение = Неопределено Тогда
		Record = Новый Соответствие;
		Record.Вставить("type", "record");
		Record.Вставить("Values", Новый Соответствие);
		Record.Вставить("Columns", Новый Соответствие);
		Возврат Record;
	КонецЕсли;
	
	ТипЗнч = ТипЗнч(Значение);
	
	Если ЗначениеЗаполнено(ТипыПолей) Тогда
		Если ТипЗнч <> ТипЗнч(ТипыПолей) Тогда
			ВызватьИсключение "Указываемые типы полей должны быть переданы той же структурой данных, что и значения";	
		КонецЕсли;
	КонецЕсли;
	
	Если ТипЗнч = Тип("Соответствие") Тогда
		Возврат MapToRecord(Значение, ТипыПолей);
	ИначеЕсли ТипЗнч = Тип("Структура") Тогда
		Возврат ObjectToRecord(Значение, ТипыПолей);
	ИначеЕсли ТипЗнч = Тип("Строка") Тогда
		Возврат JsonToRecord(Значение);
	Иначе
		ВызватьИсключение "Неподдерживаемый тип данных параметра ""Значение""";
	КонецЕсли;
	// BSLLS:TooManyReturns-on
КонецФункции

Функция AppendField(Value, Знач Field, Знач Type = Неопределено, Record = Неопределено) Экспорт
	// BSLLS:FunctionOutParameter-off
	Если Record = Неопределено Тогда
		Record = Create();
	КонецЕсли;
	// BSLLS:FunctionOutParameter-on
	
	Values = Record["Values"];
	Columns = Record["Columns"];
	
	Если ПустаяСтрока(Field) Тогда
		ВызватьИсключение "Не указано наименование поля";
	КонецЕсли;
	Field = СокрЛП(Field);
	
	Если Type = Неопределено Тогда
		Values.Вставить(Field, Value);
		Columns.Вставить(Field, ТипПоУмолчанию(Value));
		Возврат Record;
	КонецЕсли;
	
	Если Type = "record" Тогда
		Если Не IsRecord(Value) Тогда
			ВызватьИсключение "Значение поля """ + Field + """ не является record";
		КонецЕсли;
	ИначеЕсли Type = "recordset" Тогда
		Если Не IsRecordset(Value) Тогда
			ВызватьИсключение "Значение поля """ + Field + """ не является recordset";
		КонецЕсли;
	Иначе
		IsCorrectType(Type);	
	КонецЕсли;
	
	Values.Вставить(Field, Value);
	Columns.Вставить(Field, Type);
	
	Возврат Record;
КонецФункции

Функция Expand(Знач Object) Экспорт
	ObjectType = ТипЗнч(Object);
	Если ObjectType = Тип("Соответствие") Тогда
		Result = ExpandRecord(Object, 0);
	ИначеЕсли ObjectType = Тип("Массив") Тогда
		Result = ExpandRecordset(Object, 0);
	Иначе
		ВызватьИсключение "Переданный объект не является Record или Recordset";
	КонецЕсли;
	
	Возврат Result;
КонецФункции

Функция Decrease(Знач Object) Экспорт
	ObjectType = ТипЗнч(Object);
	Если ObjectType <> Тип("Соответствие") Тогда
		ВызватьИсключение "Некорректный тип переданного значения Object";	
	КонецЕсли;
	
	type = Object["_type"];
	Если type = "record" Тогда
		Возврат DecreaseRecord(Object);	
	ИначеЕсли type = "recordset" Тогда
		Возврат DecreaseRecordset(Object);
	Иначе
		ВызватьИсключение "Указан некорректный тип";	
	КонецЕсли;
КонецФункции

Функция AsJSON(Знач Object) Экспорт
	Возврат ConvertToJSON(Object);	
КонецФункции

Функция FromJSON(Знач JSON) Экспорт
	Возврат ConvertFromJSON(JSON, Истина);
КонецФункции

Функция Get(Record, Field) Экспорт
	Columns = Record["Columns"];
	Values = Record["Values"];
	
	Result = Новый Соответствие;
	Result.Вставить("Value", Values[Field]);
	Result.Вставить("Column", Columns[Field]);
	Возврат Result;
КонецФункции

#КонецОбласти

#Область Record_ДополнительныеПроцедурыИФункции

Функция ObjectToRecord(Знач Object, Знач ОписаниеПолей = Неопределено)
	Record = Create();
	
	Если ТипЗнч(ОписаниеПолей) <> Тип("Структура") Тогда
		ОписаниеПолей = Новый Структура;
	КонецЕсли;
	
	Для Каждого elem Из Object Цикл
		Field = elem.Ключ;
		Value = elem.Значение;
		
		Type = Неопределено;
		ОписаниеПолей.Свойство(Field, Type);
		
		AppendField(Value, Field, Type, Record);
	КонецЦикла;
	
	Возврат Record;
КонецФункции

Функция MapToRecord(Map, ОписаниеПолей)
	Record = Create();
	
	// BSLLS:FunctionOutParameter-off
	Если ТипЗнч(ОписаниеПолей) <> Тип("Соответствие") Тогда
		ОписаниеПолей = Новый Соответствие;
	КонецЕсли;
	// BSLLS:FunctionOutParameter-on
	
	Для Каждого elem Из Map Цикл
		Field = elem.Ключ;
		Value = elem.Значение;
		Type = ОписаниеПолей[Field];
		
		AppendField(Value, Field, Type, Record);
	КонецЦикла;
	
	Возврат Record;		
КонецФункции

Функция JsonToRecord(JSON)
	Object = ConvertFromJSON(JSON, Истина);
	Если Object["Values"] <> Неопределено Тогда
		Возврат Create(Object["Values"], Object["Columns"]);
	КонецЕсли;
	
	Возврат Create(Object);		
КонецФункции

Функция ExpandRecord(Record, f)
	Результат = __Record(, f);
	d = Результат["d"];
	s = Результат["s"];
	
	Values = Record["Values"];
	Columns = Record["Columns"];
	Для Каждого Field Из Values Цикл
		Value = Field.Значение;
		Name = Field.Ключ;
		Type = Columns[Name];
		
		s.Добавить(__Column(Name, ExpandType(Type)));
		
		Если Type = "record" Тогда
			// BSLLS:FunctionOutParameter-off
			f = f + 1;
			// BSLLS:FunctionOutParameter-on
			d.Добавить(ExpandRecord(Value, f));
		ИначеЕсли Type = "recordset" Тогда
			// BSLLS:FunctionOutParameter-off
			f = f + 1;
			// BSLLS:FunctionOutParameter-on
			d.Добавить(ExpandRecordset(Value, f));
		Иначе
			d.Добавить(Value);
		КонецЕсли;
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

Функция ExpandRecordset(Recordset, Знач f)
	Результат = __Record("recordset", f);
	s = Результат["s"];
	d = Результат["d"];
	
	Columns = Recordset[0]["Columns"];
	Для Каждого Column Из Columns Цикл
		s.Добавить(__Column(Column["n"], ExpandType(Column["t"])));			
	КонецЦикла;
	
	Для Каждого Record Из Recordset Цикл
		dValues = Новый Массив;
		
		Values = Record["Values"];
		Для i = 0 По Values.Количество() - 1 Цикл
			Value = Values[i];
			
			Type = s[i]["t"];
			Если Type = "record" Тогда
				dValues.Добавить(ExpandRecord(Value, f + 1));
			ИначеЕсли Type = "recordset" Тогда
				dValues.Добавить(ExpandRecordset(Value, f + 1));
			Иначе
				dValues.Добавить(Value);
			КонецЕсли;		
		КонецЦикла;
		d.Добавить(dValues);
	КонецЦикла;
	
	Возврат Результат;	
КонецФункции

Функция DecreaseRecord(Record, Cashe = Неопределено)
	Если Record = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	// BSLLS:FunctionOutParameter-off
	Если Cashe = Неопределено Тогда
		Cashe = Новый Соответствие;
	КонецЕсли;
	// BSLLS:FunctionOutParameter-on
	
	f = Record["f"];
	d = Record["d"];
	s = Record["s"];
	
	Result = Create();
	Values = Result["Values"];
	Columns = Result["Columns"];
		
	Если s = Неопределено Тогда
		CasheColumns = Cashe[f];
		
		Для i = 0 По d.Количество() - 1 Цикл
			Column = CasheColumns[i];
			Name = Column["n"];
			Type = Column["t"];
			Value = DecreaseValue(d[i], Type, Cashe);	
			
			Values.Вставить(Name, Value);
			Columns.Вставить(Name, Type);
		КонецЦикла;		
	Иначе
		CasheColumns = Новый Массив;
		
		Types = __Types(Истина);
		Для i = 0 По d.Количество() - 1 Цикл
			Column = s[i];
			Name = Column["n"];
			Type = DecreaseType(Column["t"], Types);		
			Value = DecreaseValue(d[i], Type, Cashe);	
			
			Columns.Вставить(Name, Type);
			Values.Вставить(Name, Value);
			
			CasheColumns.Добавить(Новый Структура("n,t", Name, Type));
		КонецЦикла;
		Cashe.Вставить(f, CasheColumns);	
	КонецЕсли;
	
	Возврат Result;
КонецФункции

Функция DecreaseRecordset(Recordset, Cashe = Неопределено)
	Если Recordset = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	// BSLLS:FunctionOutParameter-off
	Если Cashe = Неопределено Тогда
		Cashe = Новый Соответствие;
	КонецЕсли;
	// BSLLS:FunctionOutParameter-on
	
	Result = Новый Массив;
	
	Records = Recordset["d"];
	Columns	= Recordset["s"];
	f 		= Recordset["f"];
	
	Для Каждого Record Из Records Цикл
		SubRecord = __Record(, f);
		SubRecord["d"] = Record;
		SubRecord["s"] = Columns;
		
		Result.Добавить(DecreaseRecord(SubRecord, Cashe));
	КонецЦикла;
	
	Возврат Result;
КонецФункции

Функция DecreaseValue(Value, Type, Cashe)
	Если Type = "record" Тогда
		Value_ = DecreaseRecord(Value, Cashe);
	ИначеЕсли Type = "recordset" Тогда
		Value_ = DecreaseRecordset(Value, Cashe);
	Иначе
		Value_ = Value;
	КонецЕсли;
	
	Возврат Value_;
КонецФункции

Функция ConvertToJSON(Obj)
	ЗаписьJSON = Новый ЗаписьJSON;
	ПараметрыЗаписиJSON = Новый ПараметрыЗаписиJSON(ПереносСтрокJSON.Windows, Символы.Таб);
	ЗаписьJSON.УстановитьСтроку(ПараметрыЗаписиJSON);
	ЗаписатьJSON(ЗаписьJSON, Obj);
	Возврат ЗаписьJSON.Закрыть();
КонецФункции

Функция ConvertFromJSON(JSON, ВСоответствие = Ложь)
	ЧтениеJSON = Новый ЧтениеJSON;
	ЧтениеJSON.УстановитьСтроку(JSON);
	РезультатФункции = ПрочитатьJSON(ЧтениеJSON, ВСоответствие);
	ЧтениеJSON.Закрыть();
	
	Возврат РезультатФункции;
КонецФункции

Функция __Column(n = "", t = "", s = Неопределено)
	Result = Новый Соответствие;
	Result.Вставить("n", n);
	Если ЗначениеЗаполнено(t) Тогда
		Result.Вставить("t", t);
	КонецЕсли;
	Если ЗначениеЗаполнено(s) Тогда
		Result.Вставить("s", s);
		Result.Вставить("s1", s);
	КонецЕсли;
	
	Возврат Result;
КонецФункции

Функция __Record(_type = "record", f = 0)
	Result = Новый Соответствие;
	Result.Вставить("_type", _type);
	Result.Вставить("d", Новый Массив);
	Result.Вставить("s", Новый Массив);
	Result.Вставить("f", f);
	
	Возврат Result;
КонецФункции

#КонецОбласти

#Область Record_Types

Функция __Types(Reverse = Ложь)
	Types = Новый Соответствие;
	Если Reverse Тогда
		Types.Вставить(strInteger(), "integer");
		Types.Вставить(strReal(), "real");
		Types.Вставить(strMoney(), "money");
		Types.Вставить(strBoolean(), "boolean");
		Types.Вставить(strString(), "string");
		Types.Вставить(strDate(), "date");
		Types.Вставить(strTime(), "time");
		Types.Вставить(strDateTime(), "datetime");
		Types.Вставить(strTimeInterval(), "timeinterval");
		Types.Вставить(strXML(), "xml");
		Types.Вставить(strLink(), "link");
		Types.Вставить(strIdentity(), "identity");
		Types.Вставить(strEnum(), "enum");
		Types.Вставить(strFlags(), "flags");
		Types.Вставить(strRecord(), "record");
		Types.Вставить(strRecordset(), "recordset");
		Types.Вставить(strBinary(), "binary");
		Types.Вставить(strUUID(), "uuid");
		Types.Вставить(strRPCFile(), "rpcfile");
		Types.Вставить(strObject(), "object");
		Types.Вставить(strArray(), "array");
	Иначе
		Types.Вставить("integer", strInteger());
		Types.Вставить("real", strReal());
		Types.Вставить("money", strMoney());
		Types.Вставить("boolean", strBoolean());
		Types.Вставить("string", strString());
		Types.Вставить("date", strDate());
		Types.Вставить("time", strTime());
		Types.Вставить("datetime", strDateTime());
		Types.Вставить("timeinterval", strTimeInterval());
		Types.Вставить("xml", strXML());
		Types.Вставить("link", strLink());
		Types.Вставить("identity", strIdentity());
		Types.Вставить("enum", strEnum());
		Types.Вставить("flags", strFlags());
		Types.Вставить("record", strRecord());
		Types.Вставить("recordset", strRecordset());
		Types.Вставить("binary", strBinary());
		Types.Вставить("uuid", strUUID());
		Types.Вставить("rpcfile", strRPCFile());
		Types.Вставить("object", strObject());
		Types.Вставить("array", strArray());	
	КонецЕсли;
	
	Возврат Types;
КонецФункции

Функция DecreaseType(t, Types)
	Если ТипЗнч(t) = Тип("Строка") Тогда
		Возврат Types[t];
	КонецЕсли;
	
	n = Types[t["n"]];
	
	Result = Новый Структура;
	Result.Вставить("n", n);
	Если n = "link" Тогда
		Result.Вставить("t", t["t"]);
	ИначеЕсли n = "array" Тогда
		Result.Вставить("t", Types[t["t"]]);
	ИначеЕсли n = "enum" Тогда
		Result.Вставить("s", t["s"]);
	ИначеЕсли n = "flags" Тогда
		Result.Вставить("s", t["s"]);
	Иначе
		Result = Неопределено;
	КонецЕсли;
	
	Возврат Result;
КонецФункции

Функция ExpandType(Type)
	Результат = Неопределено;
	
	Types = __Types();
	Если ТипЗнч(Type) = Тип("Строка") Тогда
		Результат = Types[Type];
	ИначеЕсли Type["n"] = "array" Тогда
		Результат = Новый Соответствие;
		Результат.Вставить("n", Types[Type["n"]]);
		Результат.Вставить("t", Types[Type["t"]]);
	ИначеЕсли Type["n"] = "enum" Или Type["n"] = "flags" Тогда
		Результат = Новый Соответствие;
		Результат.Вставить("n", Types[Type["n"]]);
		
		s = Новый Соответствие;
		Для i = 0 По Type["s"].Количество() - 1 Цикл
			s.Вставить(Формат(i, "ЧГ=0"), Type["s"][i]);	
		КонецЦикла;
		
		Если Type.Свойство("null") Тогда
			s.Вставить("null", Type["null"]);	
		КонецЕсли;
		
		Результат.Вставить("s", s);
		Результат.Вставить("s1", s);
	Иначе
		Результат = Неопределено;
	КонецЕсли;
	
	Возврат Результат;
КонецФункции

Функция tInteger() Экспорт
	Возврат "integer";	
КонецФункции

Функция tReal() Экспорт
	Возврат "read";
КонецФункции

Функция tMoney() Экспорт
	Возврат "money";
КонецФункции

Функция tBoolean() Экспорт
	Возврат "boolean";
КонецФункции

Функция tString() Экспорт
	Возврат "string";
КонецФункции

Функция tDate() Экспорт
	Возврат "date";
КонецФункции

Функция tTime() Экспорт
	Возврат "time";	
КонецФункции

Функция tDateTime() Экспорт
	Возврат "datetime";
КонецФункции

Функция tTimeInterval() Экспорт
	Возврат "timeinterval";	
КонецФункции

Функция tXML() Экспорт
	Возврат "xml";
КонецФункции

Функция tLink(Связь) Экспорт
	Возврат Новый Структура("n,t", "link", Связь);
КонецФункции

Функция tIdentity() Экспорт
	Возврат "identity";
КонецФункции

Функция tEnum(СписокЗначений, ЕстьNull = Ложь, ПредставлениеNull = Неопределено) Экспорт
	result = Новый Структура("n", "enum");
	
	Если ТипЗнч(СписокЗначений) = Тип("Массив") Тогда
		s = Новый Соответствие;
		Для i = 0 По СписокЗначений.Количество() - 1 Цикл
			s.Вставить(Формат(i, "ЧГ=0"), СписокЗначений[i]);		
		КонецЦикла;
		Если ЕстьNull Тогда
			s.Вставить("null", ПредставлениеNull);
		КонецЕсли;
		result.Вставить("s", s);
	ИначеЕсли ТипЗнч(СписокЗначений) = Тип("Соответствие") Тогда
		result.Вставить("s", СписокЗначений);
	Иначе
		ВызватьИсключение "Некорректый тип переданного объекта ""СписокЗначений""";
	КонецЕсли;
	
	Возврат result;
КонецФункции

Функция tFlags(СписокЗначений) Экспорт
	result = Новый Структура("n", "flags");
	
	Если ТипЗнч(СписокЗначений) = Тип("Массив") Тогда
		s = Новый Соответствие;
		Для i = 0 По СписокЗначений.Количество() - 1 Цикл
			s.Вставить(Формат(i, "ЧГ=0"), СписокЗначений[i]);		
		КонецЦикла;
		result.Вставить("s", s);
	ИначеЕсли ТипЗнч(СписокЗначений) = Тип("Соответствие") Тогда
		result.Вставить("s", СписокЗначений);
	Иначе
		ВызватьИсключение "Некорректый тип переданного объекта ""СписокЗначений""";
	КонецЕсли;
	
	Возврат result;
КонецФункции

Функция tRecord() Экспорт
	Возврат "record";
КонецФункции

Функция tRecordset() Экспорт
	Возврат "recordset";
КонецФункции

Функция tBinary() Экспорт
	Возврат "binary";
КонецФункции

Функция tUUID() Экспорт
	Возврат "uuid";
КонецФункции

Функция tRPCFile() Экспорт
	Возврат "rpcfile";
КонецФункции

Функция tObject() Экспорт
	Возврат "object";
КонецФункции

Функция tArray(ValueType) Экспорт
	Если __Types()[ValueType] = Неопределено Тогда
		ВызватьИсключение "Некорректный тип ""ValueType"": " + ValueType;
	КонецЕсли;
	
	Возврат Новый Структура("n,t", "array", ValueType);
КонецФункции

Функция strInteger()
	Возврат "Число целое";	
КонецФункции

Функция strReal()
	Возврат "Число вещественное";
КонецФункции

Функция strMoney()
	Возврат "Деньги";
КонецФункции

Функция strBoolean()
	Возврат "Логическое";
КонецФункции

Функция strString()
	Возврат "Строка";
КонецФункции

Функция strDate()
	Возврат "Дата";
КонецФункции

Функция strTime()
	Возврат "Время";	
КонецФункции

Функция strDateTime()
	Возврат "Дата и время";
КонецФункции

Функция strTimeInterval()
	Возврат "Временной интервал";	
КонецФункции

Функция strXML()
	Возврат "XML-файл";
КонецФункции

Функция strLink()
	Возврат "Связь";
КонецФункции

Функция strIdentity()
	Возврат "Идентификатор";
КонецФункции

Функция strEnum()
	Возврат "Перечисляемое";
КонецФункции

Функция strFlags()
	Возврат "Флаги";
КонецФункции

Функция strRecord()
	Возврат "Запись";
КонецФункции

Функция strRecordset()
	Возврат "Выборка";
КонецФункции

Функция strBinary()
	Возврат "Двоичное";
КонецФункции

Функция strUUID()
	Возврат "UUID";
КонецФункции

Функция strRPCFile()
	Возврат "Файл-rpc";
КонецФункции

Функция strObject()
	Возврат "JSON-объект";
КонецФункции

Функция strArray()
	Возврат "Массив";
КонецФункции

#КонецОбласти

#Область Record_СлужебныеПроцедурыИФункции

Функция ТипПоУмолчанию(Значение)
	ТипЗначения = ТипЗнч(Значение);
	Если ТипЗначения = Тип("Число") Тогда
		Возврат "integer";
	ИначеЕсли ТипЗначения = Тип("Дата") Тогда
		Возврат "date";
	ИначеЕсли ТипЗначения = Тип("Булево") Тогда
		Возврат "boolean";
	ИначеЕсли ТипЗначения = Тип("Структура") Тогда
		Возврат "object";
	ИначеЕсли ТипЗначения = Тип("Соответствие") Тогда
		Если IsRecord(Значение) Тогда
			Возврат "record";
		КонецЕсли;
		
		Возврат "object";
	ИначеЕсли ТипЗначения = Тип("ДвоичныеДанные") Тогда
		Возврат "binary";
	ИначеЕсли ТипЗначения = Тип("Строка") Тогда
		Возврат "string";
	ИначеЕсли ТипЗначения = Тип("Массив") Тогда
		Возврат Новый Структура("n,t", "array", ТипПоУмолчанию(Значение[0]));
	Иначе
		Возврат Неопределено;
	КонецЕсли;
КонецФункции

Функция IsRecord(Obj)
	Если ТипЗнч(Obj) <> Тип("Соответствие") Тогда
		Возврат Ложь;
	КонецЕсли;
	Если Obj["type"] <> "record" Тогда
		Возврат Ложь;	
	КонецЕсли;
	
	Values = Obj["Values"];
	Columns = Obj["Columns"];
	
	Если Не (ТипЗнч(Values) = Тип("Соответствие") И ТипЗнч(Columns) = Тип("Соответствие")) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Values.Количество() <> Columns.Количество() Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для Каждого Field Из Values Цикл
		Value = Field.Значение;
		Type = Columns[Field.Ключ];
		Если Не CheckValue(Value, Type) Тогда
			Возврат Ложь;
		КонецЕсли;
	КонецЦикла;
	
	Возврат Истина;
КонецФункции

Функция IsRecordset(Arr)
	Если ТипЗнч(Arr) <> Тип("Массив") Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Не Arr.Количество() Тогда
		Возврат Истина;
	КонецЕсли;
	
	mainRecord = Arr[0];
	Если Не IsRecord(mainRecord) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Для i=1 По Arr.Количество()-1 Цикл
		record = Arr[i];
		Если Не IsRecord(record) Тогда
			Возврат Ложь;
		КонецЕсли;
		
		Columns = record["Columns"];
		
		Для Каждого Column Из mainRecord["Columns"] Цикл
			Если Column.Значение <> Columns[Column.Ключ] Тогда
				Возврат Ложь;
			КонецЕсли;
		КонецЦикла;
	КонецЦикла;
	
	Возврат Истина;
КонецФункции

Функция CheckValue(Value, Type)
	Если Type = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;
	
	Если Type = "record" Тогда
		Если Не IsRecord(Value) Тогда
			Возврат Ложь;
		КонецЕсли;
	ИначеЕсли Type = "recordset" Тогда
		Если Не IsRecordset(Value) Тогда
			Возврат Ложь;
		КонецЕсли;
	Иначе
		IsCorrectType(Type);	
	КонецЕсли;
	
	Возврат Истина;
КонецФункции

Процедура IsCorrectType(Type)
	Если ТипЗнч(Type) = Тип("Структура") Или ТипЗнч(Type) = Тип("Соответствие") Тогда
		IsCorrectComplexType(Type);
	ИначеЕсли ТипЗнч(Type) = Тип("Строка") Тогда
		IsCorrectSimpleType(Type);
	Иначе
		ВызватьИсключение "Передано некорректное описание типов";
	КонецЕсли;
КонецПроцедуры

Процедура IsCorrectComplexType(Type)
	Types = __Types();
	type_ = Новый Структура("n,t,s,s1");
	ЗаполнитьЗначенияСвойств(type_, Type);
	
	Если Types.Получить(type_["n"]) = Неопределено Тогда
		ВызватьИсключение "Неподдерживаемый тип: " + Type;
	КонецЕсли;
	
	Если type_["n"] = tEnum(Новый Массив)["n"] Тогда
		Если type_["s"] = Неопределено ИЛИ type_["s1"] = Неопределено Тогда
			ВызватьИсключение "не указаны значения перечисления Enum";
		КонецЕсли;
	ИначеЕсли type_["n"] = tArray(Неопределено)["n"] Тогда
		Если Types.Получить(type_["t"]) = Неопределено Тогда
			ВызватьИсключение "Неподдерживаемый тип массива: " + type_["t"];
		КонецЕсли;
	Иначе
	 	ВызватьИсключение "Некорректно указан тип: " + type_["n"];
	КонецЕсли;
КонецПроцедуры

Процедура IsCorrectSimpleType(Type)
	Types = __Types();
	Если Types.Получить(Type) = Неопределено Тогда
		ВызватьИсключение "Неподдерживаемый тип: " + Type;
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

