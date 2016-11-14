

str = fileread('V:\Jobs\oboe_log_production.txt');
date_str = regexp(str,'\d{4}-\d{2}-\d{2}','match');
date_num = sort(datenum(date_str));
h = plot(date_num,1:numel(date_num),'linewidth',3);
datetick
ylabel('Number of tasks')
title('Tasks')
saveas(h,'V:\Public\jobs.png')


str = fileread('V:\Jobs\oboe_users_production.txt');
items = regexp(str,'(?<ip>\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}),(?<date>\d{4}-\d{2}-\d{2})','names');

for i = 1:numel(items)
    date_str{i} = items(i).date;
end
[date_num,order] = sort(datenum(date_str));
h = plot(date_num,1:numel(date_num),'linewidth',3);
datetick
ylabel('Number of users')
title('Users')
saveas(h,'V:\Public\users.png')

for i = 1:numel(items)
    ip_str{i} = items(i).ip;
end
ip_str = ip_str(order);
for i = 1:numel(ip_str)
    try
%         trace_str = urlread('http://en.utrace.de','get',{'query',ip_str{i}});
%         pos = regexp(trace_str,'LatLng\((?<Lat>[\d\.-]+)[,\s]+(?<Lon>[\d\.-]+)','names','once');
        trace_str = urlread('http://api.hostip.info/get_html.php','get',{'ip',ip_str{i},'position','true'});
        Lat{i} = pos.Lat;
        Lon{i} = pos.Lon;
    catch
        pause
    end
end

mylat = str2num(char(Lat));
mylon = str2num(char(Lon));
save users date_num mylat mylon


h = worldmap('World');
load coast
plotm(lat, long)
load users
plotm(mylat,mylon,'ro','markersize',4,'MarkerFaceColor','r','MarkerEdgeColor','k')
saveas(h,'V:\Public\map.png')
