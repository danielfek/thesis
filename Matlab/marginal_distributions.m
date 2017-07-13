%% I.2 Marginal Distributions of disp. income, consumption expenditures, and net nworth
% Krueger et al. (2016b), pp. 8)
% Variable of interest: MD
clear;
%% Data
[data,~,alldata]=xlsread('income.xlsx','Compact Set');
[Cdata,~,allC]=xlsread('consump.xlsx','Aggregate');
[Y_W,~,allY]=xlsread('income.xlsx','aggregate');
t=[NaN (2004:2:2010)];
%%% Data partition
%%% Disposable income
y_2004=data(5999:12075,5);y_2006=data(12076:18337,5);y_2008=data(18338:24843,5);y_2010=data(24844:31439,5);
%%% Consumption Expenditures
c_2004=data(5999:12075,4);c_2006=data(12076:18337,4);c_2008=data(18338:24843,4);c_2010=data(24844:31439,4);
%%% Wealth without equity
nwo_2004=data(5999:12075,6);nwo_2006=data(12076:18337,6);nwo_2008=data(18338:24843,6);nwo_2010=data(24844:31439,6);
%%% Wealth with equity
nww_2004=data(5999:12075,7);nww_2006=data(12076:18337,7);nww_2008=data(18338:24843,7);nww_2010=data(24844:31439,7);

%% Quintiles critical values
%%% Disp. Income
qu_y04=quantile(y_2004(:,1),[0.2 0.4 0.6 0.8]);qu_y06=quantile(y_2006(:,1),[0.2 0.4 0.6 0.8]);
qu_y08=quantile(y_2008(:,1),[0.2 0.4 0.6 0.8]);qu_y10=quantile(y_2010(:,1),[0.2 0.4 0.6 0.8]);
%%% Consumption
qu_c04=quantile(c_2004(:,1),[0.2 0.4 0.6 0.8]);qu_c06=quantile(c_2006(:,1),[0.2 0.4 0.6 0.8]);
qu_c08=quantile(c_2008(:,1),[0.2 0.4 0.6 0.8]);qu_c10=quantile(c_2010(:,1),[0.2 0.4 0.6 0.8]);
%%% Wealth without equity
qu_nwo04=quantile(nwo_2004(:,1),[0.2 0.4 0.6 0.8]);qu_nwo06=quantile(nwo_2006(:,1),[0.2 0.4 0.6 0.8]);
qu_nwo08=quantile(nwo_2008(:,1),[0.2 0.4 0.6 0.8]);qu_nwo10=quantile(nwo_2010(:,1),[0.2 0.4 0.6 0.8]);
%%% Wealth with equity
qu_nww04=quantile(nww_2004(:,1),[0.2 0.4 0.6 0.8]);qu_nww06=quantile(nww_2006(:,1),[0.2 0.4 0.6 0.8]);
qu_nww08=quantile(nww_2008(:,1),[0.2 0.4 0.6 0.8]);qu_nww10=quantile(nww_2010(:,1),[0.2 0.4 0.6 0.8]);

%% DISPOSABLE INCOME
%% YEAR 2004
%%% Partition into Quintiles
qy_04=NaN(size(y_2004,1),5);

for ii=1:size(y_2004,1);
        if (y_2004(ii,end)<=qu_y04(1,1));
            qy_04(ii,1)=y_2004(ii,1);
        else
            qy_04(ii,1)=0;
        end
end
for i=2:size(qu_y04,2);
    for ii=1:size(y_2004,1);
    if (y_2004(ii,1)<=qu_y04(1,i))&&(y_2004(ii,1)>qu_y04(1,i-1))
        qy_04(ii,i)=y_2004(ii,end);
    else
        qy_04(ii,i)=0;
    end
    end
end

for ii=1:size(y_2004,1);
        if (y_2004(ii,1)>qu_y04(1,4))
        qy_04(ii,end)=y_2004(ii,1);
        else
            qy_04(ii,end)=0;
        end
end
YQ04=(sum(qy_04(:,:))./(sum(y_2004(:,1))))';    % marginal distribution of disp. income 2004

%% YEAR 2006
%%% Partition into Quintiles
qy_06=NaN(size(y_2006,1),5);

for ii=1:size(y_2006,1);
        if (y_2006(ii,end)<=qu_y06(1,1));
            qy_06(ii,1)=y_2006(ii,1);
        else
            qy_06(ii,1)=0;
        end
end
for i=2:size(qu_y06,2);
    for ii=1:size(y_2006,1);
    if (y_2006(ii,1)<=qu_y06(1,i))&&(y_2006(ii,1)>qu_y06(1,i-1))
        qy_06(ii,i)=y_2006(ii,end);
    else
        qy_06(ii,i)=0;
    end
    end
end

for ii=1:size(y_2006,1);
        if (y_2006(ii,1)>qu_y06(1,4))
        qy_06(ii,end)=y_2006(ii,1);
        else
            qy_06(ii,end)=0;
        end
end
YQ06=(sum(qy_06(:,:))./(sum(y_2006(:,1))))';    % marginal distribution of disp. income 2006

%% YEAR 2008
%%% Partition into Quintiles
qy_08=NaN(size(y_2008,1),5);

for ii=1:size(y_2008,1);
        if (y_2008(ii,end)<=qu_y08(1,1));
            qy_08(ii,1)=y_2008(ii,1);
        else
            qy_08(ii,1)=0;
        end
end
for i=2:size(qu_y08,2);
    for ii=1:size(y_2008,1);
    if (y_2008(ii,1)<=qu_y08(1,i))&&(y_2008(ii,1)>qu_y08(1,i-1))
        qy_08(ii,i)=y_2008(ii,end);
    else
        qy_08(ii,i)=0;
    end
    end
end

for ii=1:size(y_2008,1);
        if (y_2008(ii,1)>qu_y08(1,4))
        qy_08(ii,end)=y_2008(ii,1);
        else
            qy_08(ii,end)=0;
        end
end
YQ08=(sum(qy_08(:,:))./(sum(y_2008(:,1))))';    % marginal distribution of disp. income 2008

%% YEAR 2010
%%% Partition into Quintiles
qy_10=NaN(size(y_2010,1),5);

for ii=1:size(y_2010,1);
        if (y_2010(ii,end)<=qu_y10(1,1));
            qy_10(ii,1)=y_2010(ii,1);
        else
            qy_10(ii,1)=0;
        end
end
for i=2:size(qu_y10,2);
    for ii=1:size(y_2010,1);
    if (y_2010(ii,1)<=qu_y10(1,i))&&(y_2010(ii,1)>qu_y10(1,i-1))
        qy_10(ii,i)=y_2010(ii,end);
    else
        qy_10(ii,i)=0;
    end
    end
end

for ii=1:size(y_2010,1);
        if (y_2010(ii,1)>qu_y10(1,4))
        qy_10(ii,end)=y_2010(ii,1);
        else
            qy_10(ii,end)=0;
        end
end
YQ10=(sum(qy_10(:,:))./(sum(y_2010(:,1))))';    % marginal distribution of disp. income 2010

%% Compact report of marginal distribution of disposable income 2004-2010
MDY=[t;(1:5)' YQ04 YQ06 YQ08 YQ10];

%% CONSUMPTION EXPENDITURES
%% YEAR 2004
%%% Partition into Quintiles
qc_04=NaN(size(c_2004,1),5);

for ii=1:size(c_2004,1);
        if (c_2004(ii,end)<=qu_c04(1,1));
            qc_04(ii,1)=c_2004(ii,1);
        else
            qc_04(ii,1)=0;
        end
end
for i=2:size(qu_c04,2);
    for ii=1:size(c_2004,1);
    if (c_2004(ii,1)<=qu_c04(1,i))&&(c_2004(ii,1)>qu_c04(1,i-1))
        qc_04(ii,i)=c_2004(ii,end);
    else
        qc_04(ii,i)=0;
    end
    end
end

for ii=1:size(c_2004,1);
        if (c_2004(ii,1)>qu_c04(1,4))
        qc_04(ii,end)=c_2004(ii,1);
        else
            qc_04(ii,end)=0;
        end
end
CQ04=(sum(qc_04(:,:))./(sum(c_2004(:,1))))';    % marginal distribution of consumption expenditures 2004

%% YEAR 2006
%%% Partition into Quintiles
qc_06=NaN(size(c_2006,1),5);

for ii=1:size(c_2006,1);
        if (c_2006(ii,end)<=qu_c06(1,1));
            qc_06(ii,1)=c_2006(ii,1);
        else
            qc_06(ii,1)=0;
        end
end
for i=2:size(qu_c06,2);
    for ii=1:size(c_2006,1);
    if (c_2006(ii,1)<=qu_c06(1,i))&&(c_2006(ii,1)>qu_c06(1,i-1))
        qc_06(ii,i)=c_2006(ii,end);
    else
        qc_06(ii,i)=0;
    end
    end
end

for ii=1:size(c_2006,1);
        if (c_2006(ii,1)>qu_c06(1,4))
        qc_06(ii,end)=c_2006(ii,1);
        else
            qc_06(ii,end)=0;
        end
end
CQ06=(sum(qc_06(:,:))./(sum(c_2006(:,1))))';    % marginal distribution of consumption expenditures 2006

%% YEAR 2008
%%% Partition into Quintiles
qc_08=NaN(size(c_2008,1),5);

for ii=1:size(c_2008,1);
        if (c_2008(ii,end)<=qu_c08(1,1));
            qc_08(ii,1)=c_2008(ii,1);
        else
            qc_08(ii,1)=0;
        end
end
for i=2:size(qu_c08,2);
    for ii=1:size(c_2008,1);
    if (c_2008(ii,1)<=qu_c08(1,i))&&(c_2008(ii,1)>qu_c08(1,i-1))
        qc_08(ii,i)=c_2008(ii,end);
    else
        qc_08(ii,i)=0;
    end
    end
end

for ii=1:size(c_2008,1);
        if (c_2008(ii,1)>qu_c08(1,4))
        qc_08(ii,end)=c_2008(ii,1);
        else
            qc_08(ii,end)=0;
        end
end
CQ08=(sum(qc_08(:,:))./(sum(c_2008(:,1))))';    % marginal distribution of consumption expenditures 2008

%% YEAR 2010
%%% Partition into Quintiles
qc_10=NaN(size(c_2010,1),5);

for ii=1:size(c_2010,1);
        if (c_2010(ii,end)<=qu_c10(1,1));
            qc_10(ii,1)=c_2010(ii,1);
        else
            qc_10(ii,1)=0;
        end
end
for i=2:size(qu_c10,2);
    for ii=1:size(c_2010,1);
    if (c_2010(ii,1)<=qu_c10(1,i))&&(c_2010(ii,1)>qu_c10(1,i-1))
        qc_10(ii,i)=c_2010(ii,end);
    else
        qc_10(ii,i)=0;
    end
    end
end

for ii=1:size(c_2010,1);
        if (c_2010(ii,1)>qu_c10(1,4))
        qc_10(ii,end)=c_2010(ii,1);
        else
            qc_10(ii,end)=0;
        end
end
CQ10=(sum(qc_10(:,:))./(sum(c_2010(:,1))))';    % marginal distribution of consumption expenditures 2010

%% Compact report of marginal distribution of consumption expenditures 2004-2010
MDC=[t;(1:5)' CQ04 CQ06 CQ08 CQ10];

%% NET WORTH WITHOUT EQUITY
%% YEAR 2004
%%% Partition into Quintiles
qnwo_04=NaN(size(nwo_2004,1),5);

for ii=1:size(nwo_2004,1);
        if (nwo_2004(ii,end)<=qu_nwo04(1,1));
            qnwo_04(ii,1)=nwo_2004(ii,1);
        else
            qnwo_04(ii,1)=0;
        end
end
for i=2:size(qu_nwo04,2);
    for ii=1:size(nwo_2004,1);
    if (nwo_2004(ii,1)<=qu_nwo04(1,i))&&(nwo_2004(ii,1)>qu_nwo04(1,i-1))
        qnwo_04(ii,i)=nwo_2004(ii,end);
    else
        qnwo_04(ii,i)=0;
    end
    end
end

for ii=1:size(nwo_2004,1);
        if (nwo_2004(ii,1)>qu_nwo04(1,4))
        qnwo_04(ii,end)=nwo_2004(ii,1);
        else
            qnwo_04(ii,end)=0;
        end
end
NWOQ04=(sum(qnwo_04(:,:))./(sum(nwo_2004(:,1))))';    % marginal distribution of NW without equity 2004

%% YEAR 2006
%%% Partition into Quintiles
qnwo_06=NaN(size(nwo_2006,1),5);

for ii=1:size(nwo_2006,1);
        if (nwo_2006(ii,end)<=qu_nwo06(1,1));
            qnwo_06(ii,1)=nwo_2006(ii,1);
        else
            qnwo_06(ii,1)=0;
        end
end
for i=2:size(qu_nwo06,2);
    for ii=1:size(nwo_2006,1);
    if (nwo_2006(ii,1)<=qu_nwo06(1,i))&&(nwo_2006(ii,1)>qu_nwo06(1,i-1))
        qnwo_06(ii,i)=nwo_2006(ii,end);
    else
        qnwo_06(ii,i)=0;
    end
    end
end

for ii=1:size(nwo_2006,1);
        if (nwo_2006(ii,1)>qu_nwo06(1,4))
        qnwo_06(ii,end)=nwo_2006(ii,1);
        else
            qnwo_06(ii,end)=0;
        end
end
NWOQ06=(sum(qnwo_06(:,:))./(sum(nwo_2006(:,1))))';    % marginal distribution of NW without equity 2006

%% YEAR 2008
%%% Partition into Quintiles
qnwo_08=NaN(size(nwo_2008,1),5);

for ii=1:size(nwo_2008,1);
        if (nwo_2008(ii,end)<=qu_nwo08(1,1));
            qnwo_08(ii,1)=nwo_2008(ii,1);
        else
            qnwo_08(ii,1)=0;
        end
end
for i=2:size(qu_nwo08,2);
    for ii=1:size(nwo_2008,1);
    if (nwo_2008(ii,1)<=qu_nwo08(1,i))&&(nwo_2008(ii,1)>qu_nwo08(1,i-1))
        qnwo_08(ii,i)=nwo_2008(ii,end);
    else
        qnwo_08(ii,i)=0;
    end
    end
end

for ii=1:size(nwo_2008,1);
        if (nwo_2008(ii,1)>qu_nwo08(1,4))
        qnwo_08(ii,end)=nwo_2008(ii,1);
        else
            qnwo_08(ii,end)=0;
        end
end
NWOQ08=(sum(qnwo_08(:,:))./(sum(nwo_2008(:,1))))';    % marginal distribution of NW without equity 2008

%% YEAR 2010
%%% Partition into Quintiles
qnwo_10=NaN(size(nwo_2010,1),5);

for ii=1:size(nwo_2010,1);
        if (nwo_2010(ii,end)<=qu_nwo10(1,1));
            qnwo_10(ii,1)=nwo_2010(ii,1);
        else
            qnwo_10(ii,1)=0;
        end
end
for i=2:size(qu_nwo10,2);
    for ii=1:size(nwo_2010,1);
    if (nwo_2010(ii,1)<=qu_nwo10(1,i))&&(nwo_2010(ii,1)>qu_nwo10(1,i-1))
        qnwo_10(ii,i)=nwo_2010(ii,end);
    else
        qnwo_10(ii,i)=0;
    end
    end
end

for ii=1:size(nwo_2010,1);
        if (nwo_2010(ii,1)>qu_nwo10(1,4))
        qnwo_10(ii,end)=nwo_2010(ii,1);
        else
            qnwo_10(ii,end)=0;
        end
end
NWOQ10=(sum(qnwo_10(:,:))./(sum(nwo_2010(:,1))))';    % marginal distribution of NW without equity 2010

%% Compact report of marginal distribution of NW without equity 2004-2010
MDNWO=[t;(1:5)' NWOQ04 NWOQ06 NWOQ08 NWOQ10];

%% NET WORTH WITH EQUITY
%% YEAR 2004
%%% Partition into Quintiles
qnww_04=NaN(size(nww_2004,1),5);

for ii=1:size(nww_2004,1);
        if (nww_2004(ii,end)<=qu_nww04(1,1));
            qnww_04(ii,1)=nww_2004(ii,1);
        else
            qnww_04(ii,1)=0;
        end
end
for i=2:size(qu_nww04,2);
    for ii=1:size(nww_2004,1);
    if (nww_2004(ii,1)<=qu_nww04(1,i))&&(nww_2004(ii,1)>qu_nww04(1,i-1))
        qnww_04(ii,i)=nww_2004(ii,end);
    else
        qnww_04(ii,i)=0;
    end
    end
end

for ii=1:size(nww_2004,1);
        if (nww_2004(ii,1)>qu_nww04(1,4))
        qnww_04(ii,end)=nww_2004(ii,1);
        else
            qnww_04(ii,end)=0;
        end
end
NWWQ04=(sum(qnww_04(:,:))./(sum(nww_2004(:,1))))';    % marginal distribution of NW with equity 2004

%% YEAR 2006
%%% Partition into Quintiles
qnww_06=NaN(size(nww_2006,1),5);

for ii=1:size(nww_2006,1);
        if (nww_2006(ii,end)<=qu_nww06(1,1));
            qnww_06(ii,1)=nww_2006(ii,1);
        else
            qnww_06(ii,1)=0;
        end
end
for i=2:size(qu_nww06,2);
    for ii=1:size(nww_2006,1);
    if (nww_2006(ii,1)<=qu_nww06(1,i))&&(nww_2006(ii,1)>qu_nww06(1,i-1))
        qnww_06(ii,i)=nww_2006(ii,end);
    else
        qnww_06(ii,i)=0;
    end
    end
end

for ii=1:size(nww_2006,1);
        if (nww_2006(ii,1)>qu_nww06(1,4))
        qnww_06(ii,end)=nww_2006(ii,1);
        else
            qnww_06(ii,end)=0;
        end
end
NWWQ06=(sum(qnww_06(:,:))./(sum(nww_2006(:,1))))';    % marginal distribution of NW with equity 2006

%% YEAR 2008
%%% Partition into Quintiles
qnww_08=NaN(size(nww_2008,1),5);

for ii=1:size(nww_2008,1);
        if (nww_2008(ii,end)<=qu_nww08(1,1));
            qnww_08(ii,1)=nww_2008(ii,1);
        else
            qnww_08(ii,1)=0;
        end
end
for i=2:size(qu_nww08,2);
    for ii=1:size(nww_2008,1);
    if (nww_2008(ii,1)<=qu_nww08(1,i))&&(nww_2008(ii,1)>qu_nww08(1,i-1))
        qnww_08(ii,i)=nww_2008(ii,end);
    else
        qnww_08(ii,i)=0;
    end
    end
end

for ii=1:size(nww_2008,1);
        if (nww_2008(ii,1)>qu_nww08(1,4))
        qnww_08(ii,end)=nww_2008(ii,1);
        else
            qnww_08(ii,end)=0;
        end
end
NWWQ08=(sum(qnww_08(:,:))./(sum(nww_2008(:,1))))';    % marginal distribution of NW with equity 2008

%% YEAR 2010
%%% Partition into Quintiles
qnww_10=NaN(size(nww_2010,1),5);

for ii=1:size(nww_2010,1);
        if (nww_2010(ii,end)<=qu_nww10(1,1));
            qnww_10(ii,1)=nww_2010(ii,1);
        else
            qnww_10(ii,1)=0;
        end
end
for i=2:size(qu_nww10,2);
    for ii=1:size(nww_2010,1);
    if (nww_2010(ii,1)<=qu_nww10(1,i))&&(nww_2010(ii,1)>qu_nww10(1,i-1))
        qnww_10(ii,i)=nww_2010(ii,end);
    else
        qnww_10(ii,i)=0;
    end
    end
end

for ii=1:size(nww_2010,1);
        if (nww_2010(ii,1)>qu_nww10(1,4))
        qnww_10(ii,end)=nww_2010(ii,1);
        else
            qnww_10(ii,end)=0;
        end
end
NWWQ10=(sum(qnww_10(:,:))./(sum(nww_2010(:,1))))';    % marginal distribution of NW with equity 2010

%% Compact report of marginal distribution of NW with equity 2004-2010
MDNWW=[t;(1:5)' NWWQ04 NWWQ06 NWWQ08 NWWQ10];


%% COMPACT REPORT PER YEAR
%% 2004
MD04=[(1:5)' MDY(2:end,2) MDC(2:end,2) MDNWO(2:end,2) MDNWW(2:end,2)];
varn_MD04={'Year2004','Disp_inc','Cons','NWO','NWW'};
[idh04,idj04]=size(MD04);
MD04_var=mat2cell(MD04,ones(1,idh04),ones(1,idj04));
MD04_var=cat(1,varn_MD04,MD04_var);
%% 2006
MD06=[(1:5)' MDY(2:end,3) MDC(2:end,3) MDNWO(2:end,3) MDNWW(2:end,3)];
varn_MD06={'Year2006','Disp_inc','Cons','NWO','NWW'};
[idh06,idj06]=size(MD06);
MD06_var=mat2cell(MD06,ones(1,idh06),ones(1,idj06));
MD06_var=cat(1,varn_MD06,MD06_var);
%% 2008
MD08=[(1:5)' MDY(2:end,4) MDC(2:end,4) MDNWO(2:end,4) MDNWW(2:end,4)];
varn_MD08={'Year2008','Disp_inc','Cons','NWO','NWW'};
[idh08,idj08]=size(MD08);
MD08_var=mat2cell(MD08,ones(1,idh08),ones(1,idj08));
MD08_var=cat(1,varn_MD08,MD08_var);
%% 2010
MD10=[(1:5)' MDY(2:end,5) MDC(2:end,5) MDNWO(2:end,5) MDNWW(2:end,5)];
varn_MD10={'Year2010','Disp_inc','Cons','NWO','NWW'};
[idh10,idj10]=size(MD10);
MD10_var=mat2cell(MD10,ones(1,idh10),ones(1,idj10));
MD10_var=cat(1,varn_MD10,MD10_var);

%% MARGINAL DISTRIBUTIONS OVER TIME
MD=[MD04_var MD06_var MD08_var MD10_var];




