let
    Source = List.Dates(#date(2023,1,1), 365, #duration(1,0,0,0)),
    #"Converted to Table" = Table.FromList(Source, Splitter.SplitByNothing(), {"Date"}, null, ExtraValues.Error),    
    #"Changed Type" = Table.TransformColumnTypes(#"Converted to Table", {{"Date", type date}}),
    #"Inserted Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date]), Int64.Type),    
    #"Inserted Month" = Table.AddColumn(#"Inserted Year", "Month", each Date.Month([Date]), Int64.Type),    
    #"Inserted Month Name" = Table.AddColumn(#"Inserted Month", "Month Name", each Date.MonthName([Date]), type text),    
    #"Inserted Day of Week" = Table.AddColumn(#"Inserted Month Name", "Day of Week", each Date.DayOfWeek([Date]), Int64.Type)
in
    #"Inserted Day of Week"