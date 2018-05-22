#Использовать "../../core"

Процедура ОписаниеКоманды(Команда) Экспорт
	
	АктивизироватьПлагины   	= Команда.Опция("a all", Ложь, "Отключить все включенные плагины").ВОкружении("GITSYNC_DISABLE_ALL_PLUGINS");
	ИменаПлагинов				= Команда.Аргумент("PLUGIN", "", "Имя установленного плагина").ТМассивСтрок().ВОкружении("GITSYNC_PLUGINS");
	
	Команда.Спек = "(-a | --all) | PLUGIN...";

КонецПроцедуры

Процедура ВыполнитьКоманду(Знач Команда) Экспорт

	ИменаПлагинов = Команда.ЗначениеАргумента("PLUGIN");
	ВсеВключенные = Команда.ЗначениеОпции("--all");

	ОбщиеПараметры = ПараметрыПриложения.Параметры();
	МенеджерПлагинов = ОбщиеПараметры.УправлениеПлагинами;
	
	ВсеПлагины = МенеджерПлагинов.ПолучитьИндексПлагинов();
	ВключенныеПлагины = МенеджерПлагинов.ПрочитатьВключенныеПлагины();

	ПлагиныДляОтключения = Новый Массив;

	Если ВсеВключенные Тогда
		Для каждого Плагин Из ВсеПлагины Цикл
			ПлагиныДляОтключения.Добавить(Плагин.Ключ);
		КонецЦикла;
	Иначе
		ПлагиныДляОтключения = ИменаПлагинов;
	КонецЕсли;
	
	МенеджерПлагинов.ОтключитьПлагины(ИменаПлагинов);

	МенеджерПлагинов.ЗаписатьВключенныеПлагины();

КонецПроцедуры
