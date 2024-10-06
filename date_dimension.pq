let
    StartDate = #date(2023, 1, 1),
    NumberOfDays = 365,
    DateList = List.Generate(
        () => StartDate,
        (CurrentDate) => CurrentDate <= Date.AddDays(StartDate, NumberOfDays - 1),
        (CurrentDate) => Date.AddDays(CurrentDate, 1)
    ),
    ConvertedToTable = Table.FromList(DateList, Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),
    ChangedType = Table.TransformColumnTypes(ConvertedToTable, {{"Date", type date}})
in
    ChangedType