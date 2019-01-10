#Использовать reflector

Перем ОбъектИнтерфейс; // Объект.ИнтерфейсОбъекта - ссылка на класс <ИнтерфейсОбъекта>

#Область Экспортные_методы

// Возвращает подготовленный ИнтерфейсОбъекта
//
//  Возвращаемое значение:
//   Объект.ИнтерфейсОбъекта - ссылка на класс <ИнтерфейсОбъекта>
//
Функция Интерфейс() Экспорт
	Возврат ОбъектИнтерфейс;
КонецФункции

// Выполняет проверку объекта на реализацию интерфейса
//
// Параметры:
//   ОбъектПроверки - Произвольный - произвольный объект для проверки
//   ВыдатьИсключение - Булево - признак необходимости выдать исключение
//
//  Возвращаемое значение:
//   Булево - признак реализации интерфейса
//
Функция Реализует(ОбъектПроверки, ВыдатьИсключение = Ложь) Экспорт

	Рефлектор = Новый РефлекторОбъекта(ОбъектПроверки);
	Возврат Рефлектор.РеализуетИнтерфейс(ОбъектИнтерфейс, ВыдатьИсключение);

КонецФункции

#КонецОбласти

#Область Вспомогательные_процедуры_и_функции

Функция ПолучитьДоступныйИнтерфейсПлагинов()

	ДоступныйИнтерфейсПлагинов = Новый ИнтерфейсОбъекта();
	
	МенеджерПодписок = Новый МенеджерПодписок;

	ДоступныйИнтерфейсПлагинов.ИзОбъектаИсключая(МенеджерПодписок, "УстановитьПодписчиков, ВыполнитьПодпискуНаСобытие, ПрисвоитьЗначенияПараметраПроцедуры, ПриСозданииОбъекта");

	Возврат ДоступныйИнтерфейсПлагинов;

КонецФункции

Процедура ПриСозданииОбъекта()
	ОбъектИнтерфейс = ПолучитьДоступныйИнтерфейсПлагинов();
КонецПроцедуры

#КонецОбласти
