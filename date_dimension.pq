let
<<<<<<< HEAD
    Source = List.Dates(#date(2023,1,1),365, #duration(1,0,0,0)),
=======
    // configurations start
    Today=2024-01-01, // today's date
    FromYear = 2018, // set the start year of the date dimension. dates start from 1st of January of this year
    ToYear=2021, // set the end year of the date dimension. dates end at 31st of December of this year
    StartofFiscalYear=7, // set the month number that is start of the financial year. example; if fiscal year start is July, value is 7
    firstDayofWeek=Day.Monday, // set the week's start day, values: Day.Monday, Day.Sunday....
    // configuration end
    FromDate=#date(FromYear,1,1),
    ToDate=#date(ToYear,12,31),
    Source=List.Dates(
        FromDate,
        Duration.Days(ToDate-FromDate)+1,
        #duration(1,0,0,0)
    ),
>>>>>>> 96886f1b737b42a1354f959e20edc25a06268773
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Renamed Columns" = Table.RenameColumns(#"Converted to Table",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
    #"Inserted Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date]), Int64.Type),
    #"Inserted Month" = Table.AddColumn(#"Inserted Year", "Month", each Date.Month([Date]), Int64.Type),
    #"Inserted Month Name" = Table.AddColumn(#"Inserted Month", "Month Name", each Date.MonthName([Date]), type text),
    #"Inserted Day of Week" = Table.AddColumn(#"Inserted Month Name", "Day of Week", each Date.DayOfWeek([Date]), Int64.Type),
    #"Inserted Day Name" = Table.AddColumn(#"Inserted Day of Week", "Day Name", each Date.DayOfWeekName([Date]), type text),
    #"Added Conditional Column" = Table.AddColumn(#"Inserted Day Name", "Is Weekend?", each if [Day of Week] = 6 then "Yes" else if [Day of Week] = 0 then "Yes" else "No"),
    #"Inserted Start of Month" = Table.AddColumn(#"Added Conditional Column", "Start of Month", each Date.StartOfMonth([Date]), type date),
    #"Added Custom" = Table.AddColumn(#"Inserted Start of Month", "Year Month", each [Year] * 100 + [Month]),
    #"Added Custom1" = Table.AddColumn(#"Added Custom", "Current Month", each let cm = Date.StartOfMonth(DateTime.LocalNow())
in Date.Year(cm) * 100 + Date.Month(cm)),
    #"Inserted Subtraction" = Table.AddColumn(#"Added Custom1", "Subtraction", each [Year Month] - [Current Month], type number),
    #"Added Conditional Column1" = Table.AddColumn(#"Inserted Subtraction", "Month Type", each if [Subtraction] = 0 then "This Month" else if [Subtraction] = 1 then "Next Month" else if [Subtraction] = -1 then "Previous Month" else "Other Month"),
    #"Removed Columns" = Table.RemoveColumns(#"Added Conditional Column1",{"Current Month", "Subtraction"})
in
<<<<<<< HEAD
    #"Removed Columns"
=======
    #"Changed Type5"
>>>>>>> 96886f1b737b42a1354f959e20edc25a06268773
