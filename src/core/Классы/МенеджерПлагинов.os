#Использовать delegate
#Использовать logos

Перем МассивЗагруженныхПлагинов;
Перем УстановленныеПлагины Экспорт;

Перем ПлагиныОбработчики;
Перем Отказ;
Перем СтандартнаяОбработка;
Перем РефлекторПроверкиКоманд;
Перем ДополнительныеПараметрыПлагинов;
Перем Лог;

#Область Экспортные процедуры и функции

Процедура УстановитьАктивныеПлагины(Знач МассивПлагинов) Экспорт

	Если МассивПлагинов.Количество() = 0 Тогда
		
		Для каждого КлючЗначение Из УстановленныеПлагины Цикл

			Лог.Отладка("Установленный плагин выбран "+КлючЗначение.Ключ +" для запуска");
			МассивЗагруженныхПлагинов.Добавить(КлючЗначение.Ключ);
	
		КонецЦикла;

	Иначе
		МассивЗагруженныхПлагинов = МассивПлагинов;
	КонецЕсли;

КонецПроцедуры

Процедура АктивизироватьПлагины(СтандартныйОбработчик) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(СтандартныйОбработчик);

	ВыполнитьПодключенныеПлагины("ПриАктивизацииПлагина", ПараметрыВыполнения);

КонецПроцедуры

Функция ЗагрузитьПлагины() Экспорт

	// Ищем установленные плагины

	ВсеПлагины = РаботаСПлагинами.ПолучитьУстановленныеПлагины();

	ВключенныеПлагины = РаботаСПлагинами.ПолучитьВключенныеПлагины();

	Для каждого КлючЗначение Из ВключенныеПлагины Цикл

		ИмяПлагина = КлючЗначение.Ключ;

		ОписаниеПлагина = ВсеПлагины[ИмяПлагина];
		
		Если ОписаниеПлагина = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		Попытка
			ЗагруженныйПлагин = Новый (ОписаниеПлагина.Класс); //: ИнформацияОСценарии
			УстановитьПлагин(ИмяПлагина, ЗагруженныйПлагин);
		Исключение
			Лог.КритичнаяОшибка("Не удалось загрузить плагин <%1> по причине: %2", ИмяПлагина, ОписаниеОшибки());
		КонецПопытки;

	КонецЦикла;

КонецФункции

#КонецОбласти

#Область Подписка на получение параметров выполнения

Процедура ПриПолученииПараметров(ПараметрыКоманды, ДополнительныеПараметры) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ПараметрыКоманды);
	ПараметрыВыполнения.Добавить(ДополнительныеПараметры);

	ВыполнитьПодключенныеПлагины("ПриПолученииПараметров", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ПараметрыКоманды, ДополнительныеПараметры);

КонецПроцедуры

#КонецОбласти

#Область Подписки на регистрацию команд приложения

Процедура ПослеРегистрацииКомандПриложения(Парсер) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Парсер);

	ВыполнитьПодключенныеПлагины("ПослеРегистрацииКомандПриложения", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Парсер);

КонецПроцедуры

Процедура ПриРегистрацииКомандыПриложения(ИмяКоманды, КлассРеализации, Парсер) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ИмяКоманды);
	ПараметрыВыполнения.Добавить(КлассРеализации);
	ПараметрыВыполнения.Добавить(Парсер);

	ВыполнитьУстановленныеПлагины("ПриРегистрацииКомандыПриложения", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ИмяКоманды, КлассРеализации, Парсер);

КонецПроцедуры

Процедура ПередВыполнениемКоманды(Команда) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Команда);
	
	ВыполнитьПодключенныеПлагины("ПередВыполнениемКоманды", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Команда);

КонецПроцедуры

Процедура ПриВыполненииКоманды(Команда, ДополнительныеПараметры) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Команда);
	
	ВыполнитьПодключенныеПлагины("ПриВыполненииКоманды", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Команда);

КонецПроцедуры

Процедура ПослеВыполненияКоманды(Команда) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Команда);
	
	ВыполнитьПодключенныеПлагины("ПослеВыполненияКоманды", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Команда);

КонецПроцедуры


#КонецОбласти

#Область Подписки на начало и окончания выполнения

Процедура ПередНачаломВыполнения(ПутьКХранилищу, КаталогРабочейКопии, URLРепозитория, ИмяВетки) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(URLРепозитория);
	ПараметрыВыполнения.Добавить(ИмяВетки);

	ВыполнитьПодключенныеПлагины("ПередНачаломВыполнения", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ПутьКХранилищу, КаталогРабочейКопии, URLРепозитория, ИмяВетки);

КонецПроцедуры

Процедура ПослеОкончанияВыполнения(ПутьКХранилищу, КаталогРабочейКопии, URLРепозитория, ИмяВетки) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(URLРепозитория);
	ПараметрыВыполнения.Добавить(ИмяВетки);

	ВыполнитьПодключенныеПлагины("ПослеОкончанияВыполнения", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ПутьКХранилищу, КаталогРабочейКопии, URLРепозитория, ИмяВетки);

КонецПроцедуры

#КонецОбласти

#Область Подписки на получение таблицы версий

Процедура ПриПолученииТаблицыВерсий(ТаблицаВерсий, ПутьКХранилищу, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаВерсий);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодключенныеПлагины("ПриПолученииТаблицыВерсий", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаВерсий, ПутьКХранилищу, СтандартнаяОбработка);


КонецПроцедуры

Процедура ПослеПолученияТаблицыВерсий(ТаблицаВерсий, ПутьКХранилищу) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаВерсий);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);

	ВыполнитьПодключенныеПлагины("ПослеПолученияТаблицыВерсий", ПараметрыВыполнения);


	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаВерсий, ПутьКХранилищу);

КонецПроцедуры

#КонецОбласти

#Область Подписки на получение таблицы пользователей

Процедура ПриПолученииТаблицыПользователей(ТаблицаПользователей, ПутьКХранилищу, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаПользователей);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодключенныеПлагины("ПриПолученииТаблицыПользователей", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаПользователей, ПутьКХранилищу, СтандартнаяОбработка);


КонецПроцедуры

Процедура ПослеПолученияТаблицыПользователей(ТаблицаПользователей, ПутьКХранилищу) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаПользователей);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);

	ВыполнитьПодключенныеПлагины("ПослеПолученияТаблицыПользователей", ПараметрыВыполнения);


	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаПользователей, ПутьКХранилищу);

КонецПроцедуры

#КонецОбласти

#Область Подписки на обработки строки версии

Процедура ПередНачаломЦиклаОбработкиВерсий(ТаблицаИсторииХранилища, ТекущаяВерсия, СледующаяВерсия, МаксимальнаяВерсияДляРазбора) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ТаблицаИсторииХранилища);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);
	ПараметрыВыполнения.Добавить(СледующаяВерсия);
	ПараметрыВыполнения.Добавить(МаксимальнаяВерсияДляРазбора);

	ВыполнитьПодключенныеПлагины("ПередНачаломЦиклаОбработкиВерсий", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ТаблицаИсторииХранилища, ТекущаяВерсия, СледующаяВерсия, МаксимальнаяВерсияДляРазбора);

КонецПроцедуры

Процедура ПередОбработкойВерсииХранилища(СтрокаВерсии, ТекущаяВерсия) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(СтрокаВерсии);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);

	ВыполнитьПодключенныеПлагины("ПередОбработкойВерсииХранилища", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, СтрокаВерсии, ТекущаяВерсия);

КонецПроцедуры

Процедура ПриОбработкеВерсииХранилища(СтрокаВерсии, ТекущаяВерсия) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(СтрокаВерсии);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);

	ВыполнитьПодключенныеПлагины("ПриОбработкеВерсииХранилища", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, СтрокаВерсии, ТекущаяВерсия);

КонецПроцедуры

Процедура ПослеОбработкиВерсииХранилища(СтрокаВерсии, ТекущаяВерсия) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(СтрокаВерсии);
	ПараметрыВыполнения.Добавить(ТекущаяВерсия);

	ВыполнитьПодключенныеПлагины("ПослеОбработкиВерсииХранилища", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, СтрокаВерсии, ТекущаяВерсия);

КонецПроцедуры

#КонецОбласти

#Область Подписки на выполнение коммита

Процедура ПередКоммитом(КаталогРабочейКопии, Комментарий, Автор, Дата) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(Комментарий);
	ПараметрыВыполнения.Добавить(Автор);
	ПараметрыВыполнения.Добавить(Дата);

	ВыполнитьПодключенныеПлагины("ПередКоммитом", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, Комментарий, Автор, Дата);

КонецПроцедуры

Процедура ПриКоммите(ГитРепозиторий,
						Комментарий,
						ПроиндексироватьОтслеживаемыеФайлы,
						ИмяФайлаКомментария,
						авторДляГит,
						ДатаДляГит,
						Коммитер,
						ДатаКоммитера) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ГитРепозиторий);
	ПараметрыВыполнения.Добавить(Комментарий);
	ПараметрыВыполнения.Добавить(ПроиндексироватьОтслеживаемыеФайлы);
	ПараметрыВыполнения.Добавить(авторДляГит);
	ПараметрыВыполнения.Добавить(ДатаДляГит);
	ПараметрыВыполнения.Добавить(Коммитер);
	ПараметрыВыполнения.Добавить(ДатаКоммитера);

	ВыполнитьПодключенныеПлагины("ПриКоммите", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ГитРепозиторий, Комментарий, ПроиндексироватьОтслеживаемыеФайлы, авторДляГит, ДатаДляГит, Коммитер, ДатаКоммитера);


КонецПроцедуры

Процедура ПослеКоммита(ГитРепозиторий, КаталогРабочейКопии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ГитРепозиторий);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);

	ВыполнитьПодключенныеПлагины("ПослеКоммита", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ГитРепозиторий, КаталогРабочейКопии);

КонецПроцедуры

#КонецОбласти

#Область Подписки на начало и окончания выгрузки версии конфигурации

Процедура ПередНачаломВыгрузкиВерсииХранилищаКонфигурации(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, Формат) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(Формат);

	ВыполнитьПодключенныеПлагины("ПередНачаломВыгрузкиВерсииХранилищаКонфигурации", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, Формат);

КонецПроцедуры

Процедура ПослеОкончанияВыгрузкиВерсииХранилищаКонфигурации(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, Формат) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(Формат);

	ВыполнитьПодключенныеПлагины("ПослеОкончанияВыгрузкиВерсииХранилищаКонфигурации", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, Формат);

КонецПроцедуры

#КонецОбласти

#Область Подписки на загрузку версии конфигурации из хранилища

Процедура ПередЗагрузкойВерсииХранилищаКонфигурации(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, Формат) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(Формат);

	ВыполнитьПодключенныеПлагины("ПередЗагрузкойВерсииХранилищаКонфигурации", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, Формат);

КонецПроцедуры

Процедура ПриЗагрузкеВерсииХранилищаВКонфигурацию(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодключенныеПлагины("ПриЗагрузкеВерсииХранилищаВКонфигурацию", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, СтандартнаяОбработка);

КонецПроцедуры

Процедура ПослеЗагрузкиВерсииХранилищаВКонфигурацию(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);

	ВыполнитьПодключенныеПлагины("ПослеЗагрузкиВерсииХранилищаВКонфигурацию", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии);

КонецПроцедуры


#КонецОбласти

#Область Подписки на выгрузку конфигурации в исходники

Процедура ПередВыгрузкойКонфигурациюВИсходники(Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии, Формат) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(Формат);

	ВыполнитьПодключенныеПлагины("ПередВыгрузкойКонфигурациюВИсходники", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии, Формат);

КонецПроцедуры

Процедура ПриВыгрузкеКонфигурациюВИсходники(Конфигуратор, КаталогВыгрузки, Формат, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(Формат);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодключенныеПлагины("ПриВыгрузкеКонфигурациюВИсходники", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогВыгрузки, Формат, СтандартнаяОбработка);


КонецПроцедуры

Процедура ПослеВыгрузкиКонфигурациюВИсходники(Конфигуратор, КаталогВыгрузки, Формат) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(Формат);

	ВыполнитьПодключенныеПлагины("ПослеВыгрузкиКонфигурациюВИсходники", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогВыгрузки, Формат);

КонецПроцедуры

#КонецОбласти

#Область Подписки на очистку каталога рабочей версии

Процедура ПередОчисткойКаталогаРабочейКопии(Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии, Формат) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(Формат);

	ВыполнитьПодключенныеПлагины("ПередОчисткойКаталогаРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии, Формат);

КонецПроцедуры

Процедура ПриОчисткеКаталогаРабочейКопии(КаталогРабочейКопии, СоответствиеИменФайловДляПропуска, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(СоответствиеИменФайловДляПропуска);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодключенныеПлагины("ПриОчисткеКаталогаРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, СоответствиеИменФайловДляПропуска, СтандартнаяОбработка);

КонецПроцедуры

Процедура ПослеОчисткиКаталогаРабочейКопии(КаталогРабочейКопии, СоответствиеИменФайловДляПропуска) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(СоответствиеИменФайловДляПропуска);

	ВыполнитьПодключенныеПлагины("ПослеОчисткиКаталогаРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, СоответствиеИменФайловДляПропуска);

КонецПроцедуры

#КонецОбласти

#Область Подписки на перемещение в каталог рабочей копии

Процедура ПередПеремещениемВКаталогРабочейКопии(Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии, Формат) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(Конфигуратор);
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ПутьКХранилищу);
	ПараметрыВыполнения.Добавить(НомерВерсии);
	ПараметрыВыполнения.Добавить(Формат);

	ВыполнитьПодключенныеПлагины("ПередПеремещениемВКаталогРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии, Формат);

КонецПроцедуры

Процедура ПриПеремещенииВКаталогРабочейКопии(КаталогРабочейКопии, КаталогВыгрузки, ТаблицаПереименования, ПутьКФайлуПереименования, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ТаблицаПереименования);
	ПараметрыВыполнения.Добавить(ПутьКФайлуПереименования);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодключенныеПлагины("ПриПеремещенииВКаталогРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, КаталогВыгрузки, ТаблицаПереименования, ПутьКФайлуПереименования, СтандартнаяОбработка);


КонецПроцедуры

Процедура ПослеПеремещенияВКаталогРабочейКопии(КаталогРабочейКопии, КаталогВыгрузки, ТаблицаПереименования, ПутьКФайлуПереименования) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(КаталогРабочейКопии);
	ПараметрыВыполнения.Добавить(КаталогВыгрузки);
	ПараметрыВыполнения.Добавить(ТаблицаПереименования);
	ПараметрыВыполнения.Добавить(ПутьКФайлуПереименования);

	ВыполнитьПодключенныеПлагины("ПослеПеремещенияВКаталогРабочейКопии", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, КаталогРабочейКопии, КаталогВыгрузки, ТаблицаПереименования, ПутьКФайлуПереименования);

КонецПроцедуры

#КонецОбласти

#Область Подписка на распаковку файлов form.bin

Процедура ПриРаспаковкеКонтейнераМетаданных(ФайлРаспаковки, КаталогРаспаковки, СтандартнаяОбработка) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ФайлРаспаковки);
	ПараметрыВыполнения.Добавить(КаталогРаспаковки);
	ПараметрыВыполнения.Добавить(СтандартнаяОбработка);

	ВыполнитьПодключенныеПлагины("ПриРаспаковкеКонтейнераМетаданных", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ФайлРаспаковки, КаталогРаспаковки, СтандартнаяОбработка);

КонецПроцедуры

Процедура ПослеРаспаковкиКонтейнераМетаданных(ФайлРаспаковки, КаталогРаспаковки) Экспорт

	ПараметрыВыполнения = Новый Массив;
	ПараметрыВыполнения.Добавить(ФайлРаспаковки);
	ПараметрыВыполнения.Добавить(КаталогРаспаковки);

	ВыполнитьПодключенныеПлагины("ПослеРаспаковкиКонтейнераМетаданных", ПараметрыВыполнения);

	ПрисвоитьЗначенияПараметраПроцедуры(ПараметрыВыполнения, ФайлРаспаковки, КаталогРаспаковки);

КонецПроцедуры

#КонецОбласти

#Область Вспомогательные процедуры и функции

Процедура ВыполнитьУстановленныеПлагины(Знач ИмяПроцедурыВыполнения, ПараметрыПроцедуры, ВыполнитьВсеУстановленные = Ложь) Экспорт

	ВыполнитьПодключенныеПлагины(ИмяПроцедурыВыполнения, ПараметрыПроцедуры, Истина);

КонецПроцедуры

Процедура ВыполнитьПодключенныеПлагины(Знач ИмяПроцедурыВыполнения, ПараметрыПроцедуры, ВыполнитьВсеУстановленные = Ложь) Экспорт

	ПодключенныеПлагиныПроцедуры = ПлагиныОбработчики[ИмяПроцедурыВыполнения].ПодключенныеПлагины;

	Для Каждого Плагин Из ПодключенныеПлагиныПроцедуры Цикл

		Если НЕ ВыполнитьВсеУстановленные
			И МассивЗагруженныхПлагинов.Найти(Плагин.Ключ) = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		Лог.Отладка("[%1] выполняю плагин: %2, количество параметров: %3", ИмяПроцедурыВыполнения, Плагин.Ключ, ПараметрыПроцедуры.Количество());

		Делагат = Плагин.Значение;
		Делагат.Исполнить(ПараметрыПроцедуры);

	КонецЦикла;

КонецПроцедуры

Функция КопироватьМассив(Знач ВходящийМассив)
	ИтоговыйМассив = Новый Массив;

	Для каждого элМассива Из ВходящийМассив Цикл
		ИтоговыйМассив.Добавить(элМассива);
	КонецЦикла;

	Возврат ИтоговыйМассив;
КонецФункции // КопироватьМассив(Знач ВходящийМассив)


Процедура УстановитьПлагин(Знач ИмяПлагина, ЗагруженныйПлагин)

	ИнформацияОПлагине = ЗагруженныйПлагин.ОписаниеПлагина();

	РеализованныеМетоды = НайтиРеализованныеМетодыВПлагине(ЗагруженныйПлагин);

	Для Каждого ИмяМетода Из РеализованныеМетоды Цикл
		ДелегатПлагина = НовыйДелегатПлагина(ЗагруженныйПлагин, ИмяМетода);
		ПлагиныОбработчики[ИмяМетода].ПодключенныеПлагины.Вставить(ИмяПлагина, ДелегатПлагина);
	КонецЦикла;

	ДополнительныеПараметрыПлагинов.Вставить(ИмяПлагина, Новый Структура);
	УстановленныеПлагины.Вставить(ИмяПлагина, ИнформацияОПлагине);

КонецПроцедуры

Функция НовыйДелегатПлагина(ОбъектОбработчик, Знач ИмяМетода) Экспорт

	Возврат Делегаты.Создать(ОбъектОбработчик, ИмяМетода);

КонецФункции // НовыйДелегатПлагина(ОбъектОбработчик, ИмяМетода) Экспорт

Функция НайтиРеализованныеМетодыВПлагине(Знач Обработчик)

	РеализованныеМетоды = Новый Массив;
	ДоступныеОбработчики = ДоступныеОбработчики();

	Для Каждого ТиповойОбработчик Из ДоступныеОбработчики Цикл

		Если Не ПроверитьМетодКласса(Обработчик, ТиповойОбработчик.ИмяПроцедуры, ТиповойОбработчик.КоличествоПараметров) Тогда
			Продолжить;
		КонецЕсли;

		РеализованныеМетоды.Добавить(ТиповойОбработчик.ИмяПроцедуры);

	КонецЦикла;

	Возврат РеализованныеМетоды;
КонецФункции // НайтиРеализованныеМетодыВПлагине()

Процедура ПрисвоитьЗначенияПараметраПроцедуры(НовыеЗначения,
												Перем0 = Неопределено,
												Перем1 = Неопределено,
												Перем2 = Неопределено,
												Перем3 = Неопределено,
												Перем4 = Неопределено,
												Перем5 = Неопределено,
												Перем6 = Неопределено,
												Перем7 = Неопределено,
												Перем8 = Неопределено,
												Перем9 = Неопределено)
	Количество = НовыеЗначения.Количество();

	Для Индекс = 0 По Количество-1 Цикл

		Если Индекс = 0 Тогда
			Перем0 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 1 Тогда
			Перем1 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 2 Тогда
			Перем2 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 3 Тогда
			Перем3 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 4 Тогда
			Перем4 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 5 Тогда
			Перем5 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 6 Тогда
			Перем6 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 7 Тогда
			Перем7 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 8 Тогда
			Перем8 = НовыеЗначения[Индекс];
		ИначеЕсли Индекс = 9 Тогда
			Перем9 = НовыеЗначения[Индекс];
		КонецЕсли;

	КонецЦикла;

КонецПроцедуры


Функция НовыйОбработчик(Знач ИмяПроцедуры, Знач КоличествоПараметров, Знач ДополнительныеПараметры = Неопределено )

	Возврат Новый ФиксированнаяСтруктура("ИмяПроцедуры, КоличествоПараметров, ДополнительныеПараметры",ИмяПроцедуры, КоличествоПараметров, ДополнительныеПараметры);

КонецФункции // НовыйОбработи()

Функция ДоступныеОбработчики()

	МассивОбработчиков = новый Массив;

	// Вызывается в процедуре АктивизироватьПлагины
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриАктивизацииПлагина", 1)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриПолученииПараметров", 2)); //

	// Подписки на регистрацию команд приложения
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеРегистрацииКомандПриложения", 1)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриРегистрацииКомандыПриложения", 3)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриВыполненииКоманды", 2)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередВыполнениемКоманды", 3)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеВыполненияКоманды", 3)); //

	// Подписки на начало и окончания выполнения
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередНачаломВыполнения", 4)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеОкончанияВыполнения", 4));

	// Подписки на получение таблицы версий
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриПолученииТаблицыВерсий", 3));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеПолученияТаблицыВерсий", 2));

	// Подписки на получение таблицы пользователей
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриПолученииТаблицыПользователей", 3));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеПолученияТаблицыПользователей", 2));

	// Подписки на обработки строки версии
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередНачаломЦиклаОбработкиВерсий", 4));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередОбработкойВерсииХранилища", 2));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриОбработкеВерсииХранилища", 2));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеОбработкиВерсииХранилища", 3));

	// Подписки на выполнение коммита
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередКоммитом", 4));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриКоммите", 7));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеКоммита", 2));

	// Подписки на начало и окончания выгрузки версии конфигурации
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередНачаломВыгрузкиВерсииХранилищаКонфигурации", 5)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеОкончанияВыгрузкиВерсииХранилищаКонфигурации", 5));

	// Подписки на загрузку версии конфигурации из хранилища
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередЗагрузкойВерсииХранилищаКонфигурации", 5)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриЗагрузкеВерсииХранилищаВКонфигурацию", 5));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеЗагрузкиВерсииХранилищаВКонфигурацию", 4)); //

	// Подписки на выгрузку конфигурации в исходники
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередВыгрузкойКонфигурациюВИсходники", 6)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриВыгрузкеКонфигурациюВИсходники", 4));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеВыгрузкиКонфигурациюВИсходники", 3)); //

	// Подписки на очистку каталога рабочей версии
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередОчисткойКаталогаРабочейКопии", 6)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриОчисткеКаталогаРабочейКопии", 3));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеОчисткиКаталогаРабочейКопии", 2)); //

	// Подписки на перемещение в каталог рабочей копии
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередПеремещениемВКаталогРабочейКопии", 6)); //
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриПеремещенииВКаталогРабочейКопии", 5));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеПеремещенияВКаталогРабочейКопии", 4)); //

	// Подписка на распаковку файлов form.bin
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриРаспаковкеКонтейнераМетаданных", 3));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеРаспаковкиКонтейнераМетаданных", 2)); //


	// Работа с выгрузкой в исходники
	МассивОбработчиков.Добавить(НовыйОбработчик("ПередВыполнениемВыгрузки", 6));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПриВыполненииВыгрузки", 7));
	МассивОбработчиков.Добавить(НовыйОбработчик("ПослеВыполненияВыгрузки", 6));

	Возврат Новый ФиксированныйМассив(МассивОбработчиков);

КонецФункции // ДоступныеОбработчики() Экспорт

Функция ПроверитьМетодКласса(Знач КлассРеализацииКоманды,
							Знач ИмяМетода,
							Знач ТребуемоеКоличествоПараметров = 0,
							Знач ЭтоФункция = Ложь)

	ЕстьМетод = РефлекторПроверкиКоманд.МетодСуществует(КлассРеализацииКоманды, ИмяМетода);

	Если Не ЕстьМетод Тогда
		Возврат Ложь;
	КонецЕсли;

	ТаблицаМетодов = ПолучитьТаблицуМетодов(КлассРеализацииКоманды);
	СтрокаМетода = ТаблицаМетодов.Найти(ИмяМетода, "Имя");
	Если СтрокаМетода = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;

	ПроверкаНаФункцию = ЭтоФункция = СтрокаМетода.ЭтоФункция;
	ПроверкаНаКоличествоПараметров = ТребуемоеКоличествоПараметров = СтрокаМетода.КоличествоПараметров;

	//Сообщить(СтрШаблон("Класс %1 метод %2: %3", КлассРеализацииКоманды, ИмяМетода, ПроверкаНаФункцию
	//		И ПроверкаНаКоличествоПараметров ));

	Возврат ПроверкаНаФункцию
			И ПроверкаНаКоличествоПараметров;


КонецФункции // ПроверитьМетодУКласса()

Функция ПолучитьТаблицуМетодов(Знач КлассРеализацииКоманды)

	Возврат РефлекторПроверкиКоманд.ПолучитьТаблицуМетодов(КлассРеализацииКоманды);

КонецФункции

Процедура Инициализация()

	ПараметрыКоманды = Новый Массив;
	РефлекторПроверкиКоманд = Новый Рефлектор;
	СтандартнаяОбработка = Истина;
	Отказ = ложь;
	ИнициализацияПлагиныОбработчики();
	ДополнительныеПараметрыПлагинов = Новый Соответствие;
	МассивЗагруженныхПлагинов = Новый Массив;
	УстановленныеПлагины = Новый Соответствие;

	Лог = Логирование.ПолучитьЛог("oscript.app.gitsync_plugins");
	//Лог.УстановитьУровень(УровниЛога.Отладка);

КонецПроцедуры

Процедура ИнициализацияПлагиныОбработчики()

	ПлагиныОбработчики = Новый Соответствие;
	ДоступныеОбработчики = ДоступныеОбработчики();
	Для Каждого ТиповойОбработчик Из ДоступныеОбработчики Цикл

		ПлагиныОбработчики.Вставить(ТиповойОбработчик.ИмяПроцедуры, Новый Структура("Настройка, ПодключенныеПлагины", ТиповойОбработчик, Новый Соответствие));

	КонецЦикла;

КонецПроцедуры

#КонецОбласти

Инициализация();
