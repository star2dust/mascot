% 函数功能：将秒转化为小时，分钟，秒
% 例如：'08:20:00'  = second_change(30000)
function Output = second_change(num)

    hour = floor(num/3600);              % floor: 向下取整
    minute = floor(mod(num,3600)/60);  % mod： 求余数
    second = num - 3600*hour - 60*minute;
    
    if hour < 10
        hour = ['0',mat2str(hour)];      % mat2str：将double转化为字符串
    else
        hour = mat2str(hour);
    end
    
    if minute < 10
        minute = ['0',mat2str(minute)];
    else
        minute = mat2str(minute);
    end
    
    if second < 10
        second = ['0',mat2str(floor(second))];
    else
        second = mat2str(floor(second));
    end
    
    Output = [hour,':',minute,':',second];
    
end

