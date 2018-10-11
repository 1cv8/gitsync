#Использовать logos
#Использовать tempfiles

Перем ЛогПриложения;
Перем ОбщиеПараметры;
Перем ОбщийКаталогДанныхПриложения;
Перем СохрКаталогПриложения;

Процедура Инициализация()
	ОбщиеПараметры = Новый Структура();

	ОбщиеПараметры.Вставить("Плагины", Новый Массив);
	ОбщиеПараметры.Вставить("ВерсияПлатформы", "8.3");
	ОбщиеПараметры.Вставить("ПутьКПлатформе", "");
	ОбщиеПараметры.Вставить("ДоменПочты", "localhost");
	ОбщиеПараметры.Вставить("ПутьКГит", "");

КонецПроцедуры

Процедура УстановитьВерсиюПлатформы(Знач ВерсияПлатформы) Экспорт
	ОбщиеПараметры.Вставить("ВерсияПлатформы", ВерсияПлатформы);
КонецПроцедуры

Процедура УстановитьПутьКГит(Знач ПутьКГит) Экспорт
	ОбщиеПараметры.Вставить("ПутьКГит", ПутьКГит);
КонецПроцедуры

Процедура УстановитьПутьКПлатформе(Знач ПутьКПлатформе) Экспорт
	ОбщиеПараметры.Вставить("ПутьКПлатформе", ПутьКПлатформе);
КонецПроцедуры

Процедура УстановитьКаталогПлагинов(Знач ПутьККаталогуПлагинов) Экспорт
	
	ЛогПриложения.Отладка("Устанавливаю каталог плагинов <%1>", ПутьККаталогуПлагинов);
	
	Если ЗначениеЗаполнено(ПутьККаталогуПлагинов) Тогда
	
		ОбщиеПараметры.УправлениеПлагинами.УстановитьКаталогПлагинов(ПутьККаталогуПлагинов);
	
	КонецЕсли;
	
КонецПроцедуры

Процедура УстановитьДоменПочты(Знач ДоменПочты) Экспорт
	ОбщиеПараметры.Вставить("ДоменПочты", ДоменПочты);
КонецПроцедуры

Функция ПредустановленныеПлагины() Экспорт
	
	МассивИменПлагинов = Новый Массив;
	МассивИменПлагинов.Добавить("gitsync-plugins");

	Возврат МассивИменПлагинов;

КонецФункции

Функция ПолучитьЛокальныйКаталогДанныхПриложения()

	Если ЗначениеЗаполнено(ОбщийКаталогДанныхПриложения) Тогда
		Возврат ОбщийКаталогДанныхПриложения;
	КонецЕсли;

	СистемнаяИнформация = Новый СистемнаяИнформация;
	ОбщийКаталогДанныхПриложений = СистемнаяИнформация.ПолучитьПутьПапки(СпециальнаяПапка.ЛокальныйКаталогДанныхПриложений);

	ОбщийКаталогДанныхПриложения = ОбъединитьПути(ОбщийКаталогДанныхПриложений, ИмяПриложения());
	Возврат ОбщийКаталогДанныхПриложения;

КонецФункции

Функция КаталогПлагинов() Экспорт
	Возврат ОбъединитьПути(ПолучитьЛокальныйКаталогДанныхПриложения(), "plugins");
КонецФункции

Функция ФайлВключенныхПлагинов() Экспорт
	Возврат ОбъединитьПути(ПолучитьЛокальныйКаталогДанныхПриложения(), "gitsync-plugins.json");
КонецФункции

Функция ИмяФайлаНастройкиПакетнойСинхронизации() Экспорт
	Возврат "config.yaml";
КонецФункции

Процедура ВыполнитьПодпискуПриРегистрацииКомандыПриложения(Команда) Экспорт

	ОбработчикПодписок = ОбщиеПараметры.УправлениеПлагинами.НовыйМенеджерПодписок();
	ОбработчикПодписок.ПриРегистрацииКомандыПриложения(Команда.ПолучитьИмяКоманды(), Команда);

КонецПроцедуры

Процедура ПодготовитьПлагины() Экспорт
	
	МенеджерПлагинов = Новый УправлениеПлагинами;
	МенеджерПлагинов.УстановитьКаталогПлагинов(КаталогПлагинов());
	МенеджерПлагинов.УстановитьФайлВключенныхПлагинов(ФайлВключенныхПлагинов());
	МенеджерПлагинов.ЗагрузитьПлагины();

	ОбщиеПараметры.Вставить("УправлениеПлагинами", МенеджерПлагинов);

КонецПроцедуры

Процедура УстановитьВременныйКаталог(Знач Каталог) Экспорт
		
	Если ЗначениеЗаполнено(Каталог) Тогда
		
		БазовыйКаталог  = Каталог;
		ФайлБазовыйКаталог = Новый Файл(БазовыйКаталог);
		Если Не (ФайлБазовыйКаталог.Существует()) Тогда
			
			СоздатьКаталог(ФайлБазовыйКаталог.ПолноеИмя);
			
		КонецЕсли;
		
		ВременныеФайлы.БазовыйКаталог = ФайлБазовыйКаталог.ПолноеИмя;
		
	КонецЕсли;

КонецПроцедуры

Функция КаталогПриложения() Экспорт
	
	Если Не СохрКаталогПриложения = Неопределено Тогда
		Возврат СохрКаталогПриложения;
	КонецЕсли;

	ПутьККаталогу = ОбъединитьПути(ТекущийСценарий().Каталог, "..", "..", "..");

	ФайлКаталога = Новый Файл(ПутьККаталогу);
	СохрКаталогПриложения = ФайлКаталога.ПолноеИмя;
	Возврат СохрКаталогПриложения;
КонецФункции

Функция УровеньЛога() Экспорт
	Возврат ЛогПриложения.Уровень();
КонецФункции

Процедура УстановитьРежимОтладкиПриНеобходимости(Знач РежимОтладки) Экспорт
	
	Если РежимОтладки Тогда
		
		ЛогПриложения.УстановитьУровень(УровниЛога.Отладка);
		ОбщиеПараметры.УправлениеПлагинами.УстановитьРежимОтладки();

	КонецЕсли;
	
КонецПроцедуры 

Функция Параметры() Экспорт
	Возврат ОбщиеПараметры;
КонецФункции

Функция Лог() Экспорт
	
	Если ЛогПриложения = Неопределено Тогда
		ЛогПриложения = Логирование.ПолучитьЛог(ИмяЛогаПриложения());
		
	КонецЕсли;

	Возврат ЛогПриложения;

КонецФункции

Функция ИмяЛогаПриложения() Экспорт
	Возврат "oscript.app."+ИмяПриложения();
КонецФункции

Функция ИмяПриложения() Экспорт

	Возврат "gitsync";
		
КонецФункции

Функция Версия() Экспорт
	
	Возврат "3.0.0-beta1";
			
КонецФункции

Инициализация();
