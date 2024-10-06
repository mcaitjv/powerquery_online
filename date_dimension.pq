let
    StartDate = #date(2023, 1, 1),
    NumberOfDays = 365,
    Source = List.Dates(StartDate, NumberOfDays, #duration(1, 0, 0, 0)),
    ConvertedToTable = Table.FromList(Source, Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),
    ChangedType = Table.TransformColumnTypes(ConvertedToTable, {{"Date", type date}}),
    InsertedYear = Table.AddColumn(ChangedType, "Year", each Date.Year([Date]), Int64.Type),
    InsertedMonth = Table.AddColumn(InsertedYear, "Month", each Date.Month([Date]), Int64.Type),
    InsertedMonthName = Table.AddColumn(InsertedMonth, "Month Name", each Date.MonthName([Date]), type text),
    InsertedDayOfWeek = Table.AddColumn(InsertedMonthName, "Day of Week", each Date.DayOfWeek([Date]), Int64.Type)
in
    InsertedDayOfWeek