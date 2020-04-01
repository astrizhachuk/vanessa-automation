﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

&НаКлиенте
// контекст фреймворка Vanessa-Behavior
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Behavior.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавляюИнформациюВЛог(Парам01)","ЯДобавляюИнформациюВЛог","И я добавляю информацию в лог ""Текст""","Делает запись строки в текстовый лог, который определен в настройке ""Лог выполнения сценариев"".","Прочее.Лог");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Процедура выполняется перед началом каждого сценария
Процедура ПередНачаломСценария() Экспорт
	
КонецПроцедуры

&НаКлиенте
// Процедура выполняется перед окончанием каждого сценария
Процедура ПередОкончаниемСценария() Экспорт
	
КонецПроцедуры



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я добавляю информацию в лог "Текст"
//@ЯДобавляюИнформациюВЛог(Парам01)
Процедура ЯДобавляюИнформациюВЛог(Знач ПараметрТекст) Экспорт
	ПолучилосьВычислить = Ложь;
	Попытка
		Значение = XMLСтрока(Ванесса.ВычислитьВнутреннееВыражение(ПараметрТекст));
		ПолучилосьВычислить = Истина;
	Исключение
		Значение = ПараметрТекст;
	КонецПопытки;
	
	Если НЕ ПолучилосьВычислить Тогда
		Попытка
			ТекстИсключения = Неопределено;
			Текст = Ванесса.ЗаменитьСлужебныеСимволыВВыраженииДляВычисления(
				Ванесса.ЗначениеПараметраТекущегоСценария(0));
			Значение = XMLСтрока(Ванесса.ВычислитьВнутреннееВыражение(Текст, ТекстИсключения));
		Исключение
			Значение = ПараметрТекст;
		КонецПопытки;
	КонецЕсли;	 
	
	
	Ванесса.ЗаписатьСтрокуВТекстовыйЛог(Значение);
КонецПроцедуры
