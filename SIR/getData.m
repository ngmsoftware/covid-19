function [date, confirmed, deaths, recovered] = getData(country)

    a = jsondecode(urlread('https://pomber.github.io/covid19/timeseries.json'));
    
    series = getfield(a,country);

    %date = {series.date};
    confirmed = [series.confirmed];
    deaths = [series.deaths];
    recovered = [series.recovered];
    
    date = cell2mat(cellfun(@(x) datenum(x),{a.Brazil.date},'UniformOutput',false));
    date = date-date(1);
    
    
    
%     data = jsondecode(urlread('https://opendata.ecdc.europa.eu/covid19/casedistribution/json/'));    
%     confirmed = [];
%     deaths = [];
%     days = [];    
%     for i=1:length(data.records())
%         if strcmp(data.records(i).countriesAndTerritories,'Brazil')==1
%             confirmed = [confirmed; str2num(data.records(i).cases)];
%             deaths = [deaths; str2num(data.records(i).deaths)];
%             days = [days; datenum(data.records(i).dateRep)];
%         end
%     end
end