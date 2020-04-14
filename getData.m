function [date, confirmed, deaths, recovered] = getData(country)

    a = jsondecode(urlread('https://pomber.github.io/covid19/timeseries.json'));
    
    series = getfield(a,country);

    %date = {series.date};
    confirmed = [series.confirmed];
    deaths = [series.deaths];
    recovered = [series.recovered];
    
    date = cell2mat(cellfun(@(x) datenum(x),{a.Brazil.date},'UniformOutput',false));
    date = date-date(1);
    
    disp(a.Brazil(end).date)
end
