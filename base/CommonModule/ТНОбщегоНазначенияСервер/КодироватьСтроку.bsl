
Функция КодироватьСтрокуВURL(СтрокаДляКодирования)
	
	ЗакодированныеДанные = Base64Строка(ПолучитьДвоичныеДанныеИзСтроки(СтрокаДляКодирования));
	ЗакодированныеДанные = КодироватьСтроку(ЗакодированныеДанные, СпособКодированияСтроки.КодировкаURL);
	
	Возврат ЗакодированныеДанные;
	
КонецФункции

