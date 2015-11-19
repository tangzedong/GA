addpath(genpath('testfncNdim'))
dirs = dir(fullfile(pwd(), 'testfncNdim'));
count = 1;
for i = 1:length(dirs)
    disp(i);
    [~,name,ext] = fileparts(dirs(i).name);
    if strcmp(ext,'.m')~=1
        continue;
    end
    
    testfun(count).funname = name;
    testfun(count).dims = n;
    testfun(count).fncLS=@(fnc, x0, option)fminunc(fnc, x0, option);
    testfun(count).opt = zeros(1,n);
    testfun(count).fnc=eval(['@(x)',name,'(x,M,testfun(',num2str(count),').opt);']);
    testfun(count).Lb=-50*ones(1,n);
    testfun(count).Ub=50*ones(1,n);
    count = count + 1;
    fp = fopen([name,'.conf'],'r');
    if fp == -1
        continue;
    end
    while ~feof(fp)
        strline = fgetl(fp);
        parts = strsplit(strline,'=');
        if length(parts)>=2
            field = strtrim(parts{1});
            value = strtrim(parts{2});
        else
            error('Incorrupt argument in conf file!');
        end
        switch field
            case 'dims'
                testfun(count).dims = str2double(value);
            case 'opt'
                testfun(count).opt = eval([value,';']);
            case 'Lb'
                testfun(count).Lb=str2double(value)*ones(1,n);
            case 'Ub'
                testfun(count).Ub=str2double(value)*ones(1,n);
            otherwise
        end
    end
    fclose(fp);
end
