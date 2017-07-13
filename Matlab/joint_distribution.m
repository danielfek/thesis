%% I.3 Joint distribution of wealth, earnings, disposable income, and consumption expenditures
% Relevant variable at the end: JD04_var-JD10_var
clear;
%% WEALTH WITHOUT EQUITY
%% Data
[data,~,alldata]=xlsread('income.xlsx','Compact Set');
[Cdata,~,allC]=xlsread('consump.xlsx','Aggregate');
[Y_W,~,allY]=xlsread('income.xlsx','aggregate');

%% Variables
% x variables contain Year, Family ID, Age Head, Consumption Expenditures,
% Families taxable income (Disposable Income + tax liabilities), 
% Wealth without equity
x_2004=data(5999:12075,1:6);
x_2006=data(12076:18337,1:6);
x_2008=data(18338:24843,1:6);
x_2010=data(24844:31439,1:6);

%% Net Worth quinitiles' critical values
qu_x04=quantile(x_2004(:,end),[0.2 0.4 0.6 0.8]);qu_x06=quantile(x_2006(:,end),[0.2 0.4 0.6 0.8]);
qu_x08=quantile(x_2008(:,end),[0.2 0.4 0.6 0.8]);qu_x10=quantile(x_2010(:,end),[0.2 0.4 0.6 0.8]);

%% YEAR 2004
%%% Partition into NW-Quintiles
qx_04=[x_2004(:,1:5) NaN(size(x_2004,1),5)];

for ii=1:size(x_2004,1);
        if (x_2004(ii,end)<=qu_x04(1,1));
            qx_04(ii,6)=x_2004(ii,end);
        else
            qx_04(ii,6)=0;
        end
end
for i=2:size(qu_x04,2);
    for ii=1:size(x_2004,1);
    if (x_2004(ii,end)<=qu_x04(1,i))&&(x_2004(ii,end)>qu_x04(1,i-1))
        qx_04(ii,5+i)=x_2004(ii,end);
    else
        qx_04(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2004,1);
        if (x_2004(ii,end)>qu_x04(1,4))
        qx_04(ii,end)=x_2004(ii,end);
        else
            qx_04(ii,end)=0;
        end
end
NWQ04=sum(qx_04(:,6:end))./(sum(x_2004(:,6)));        % Marginal Distribution of Net Worth 2004

%% Indicator which household is in which quintile

Nx_04=[x_2004(:,1:5) NaN(size(x_2004,1),5)];
for ii=1:size(x_2004,1);
        if (x_2004(ii,end)<=qu_x04(1,1))&& (x_2004(ii,end)>=min(x_2004(:,end)));
        Nx_04(ii,6)=1;
        else Nx_04(ii,6)=0;
        end
end
for i=2:size(qu_x04,2);
    for ii=1:size(x_2004,1);
    if (x_2004(ii,end)<=qu_x04(1,i))&&(x_2004(ii,end)>qu_x04(1,i-1))
        Nx_04(ii,5+i)=1;
    else
        Nx_04(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2004,1);
        if (x_2004(ii,end)>qu_x04(1,4))
        Nx_04(ii,end)=1;
        else
            Nx_04(ii,end)=0;
        end
end
N_04=sum(Nx_04(:,6:end));            % Number of households in every quintile

%% JOINT DISTRIBUTIONS
% Mit der Hilfe von Nx_04 wissen wir, in welchem Net Worth Quintile der 
% Haushalt ist und deswegen können wir nun für jedes NW-Quintile den Anteil 
% des Konsums, Disp. Income, Expenditure Rate und Age Head bestimmen

%% Disposable Income
dispi04_in_qu=NaN(size(qx_04,1),5);
for ia=6:10;
for iia=1:size(qx_04,1);
    if Nx_04(iia,ia)==0;
        dispi04_in_qu(iia,ia-5)=0;
    else
        dispi04_in_qu(iia,ia-5)=x_2004(iia,5);
    end
end
end
DISPI_NWQ04=sum(dispi04_in_qu)./(sum(x_2004(:,5)));       % Earnings share per Net Worth Quintile

%% Consumption Expenditures
cons04_in_qu=NaN(size(qx_04,1),5);
for ia=6:10;
for iia=1:size(qx_04,1);
    if Nx_04(iia,ia)==0;
        cons04_in_qu(iia,ia-5)=0;
    else
        cons04_in_qu(iia,ia-5)=x_2004(iia,4);
    end
end
end
CON_NWQ04=sum(cons04_in_qu)./(sum(x_2004(:,4)));        % Consumption share per Net Worth quintile

%% Consumption Expenditure Rates
CEXPR_NWQ04=sum(cons04_in_qu)./(sum(dispi04_in_qu));
%% Mean Age
age04_in_qu=NaN(size(qx_04,1),5);
for ia=6:10;
for iia=1:size(qx_04,1);
    if Nx_04(iia,ia)==0;
        age04_in_qu(iia,ia-5)=0;
    else
        age04_in_qu(iia,ia-5)=x_2004(iia,3);
    end
end
end
MAGE_NWQ04=sum(age04_in_qu)./N_04;          % Mean Age per Net Worth Quintile

%% Compact report of joint distribution
JD04=[(1:5)' DISPI_NWQ04' CON_NWQ04' CEXPR_NWQ04' MAGE_NWQ04']; 
varn04={'NW-Quintile','Disp_inc','Con_Exp','Exp_rate','Meanage_head'};
[idx,idy]=size(JD04);
JD04_var=mat2cell(JD04,ones(1,idx),ones(1,idy));
JD04_var=cat(1,varn04,JD04_var);            % with variable names

%% YEAR 2006
%%% Partition into NW-Quintiles
qx_06=[x_2006(:,1:5) NaN(size(x_2006,1),5)];

for ii=1:size(x_2006,1);
        if (x_2006(ii,end)<=qu_x06(1,1));
            qx_06(ii,6)=x_2006(ii,end);
        else
            qx_06(ii,6)=0;
        end
end
for i=2:size(qu_x06,2);
    for ii=1:size(x_2006,1);
    if (x_2006(ii,end)<=qu_x06(1,i))&&(x_2006(ii,end)>qu_x06(1,i-1))
        qx_06(ii,5+i)=x_2006(ii,end);
    else
        qx_06(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2006,1);
        if (x_2006(ii,end)>qu_x06(1,4))
        qx_06(ii,end)=x_2006(ii,end);
        else
            qx_06(ii,end)=0;
        end
end
NWQ06=sum(qx_06(:,6:end))./(sum(x_2006(:,6)));        % Marginal Distribution of Net Worth 2006

%% Indicator which household is in which quintile

Nx_06=[x_2006(:,1:5) NaN(size(x_2006,1),5)];
for ii=1:size(x_2006,1);
        if (x_2006(ii,end)<=qu_x06(1,1))&& (x_2006(ii,end)>=min(x_2006(:,end)));
        Nx_06(ii,6)=1;
        else Nx_06(ii,6)=0;
        end
end
for i=2:size(qu_x06,2);
    for ii=1:size(x_2006,1);
    if (x_2006(ii,end)<=qu_x06(1,i))&&(x_2006(ii,end)>qu_x06(1,i-1))
        Nx_06(ii,5+i)=1;
    else
        Nx_06(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2006,1);
        if (x_2006(ii,end)>qu_x06(1,4))
        Nx_06(ii,end)=1;
        else
            Nx_06(ii,end)=0;
        end
end
N_06=sum(Nx_06(:,6:end));            % Number of households in every quintile

%% JOINT DISTRIBUTIONS
% Mit der Hilfe von Nx_06 wissen wir, in welchem Net Worth Quintile der 
% Haushalt ist und deswegen können wir nun für jedes NW-Quintile den Anteil 
% des Konsums, Disp. Income, Expenditure Rate und Age Head bestimmen

%% Disposable Income
dispi06_in_qu=NaN(size(qx_06,1),5);
for ia=6:10;
for iia=1:size(qx_06,1);
    if Nx_06(iia,ia)==0;
        dispi06_in_qu(iia,ia-5)=0;
    else
        dispi06_in_qu(iia,ia-5)=x_2006(iia,5);
    end
end
end
DISPI_NWQ06=sum(dispi06_in_qu)./(sum(x_2006(:,5)));       % Earnings share per Net Worth Quintile

%% Consumption Expenditures
cons06_in_qu=NaN(size(qx_06,1),5);
for ia=6:10;
for iia=1:size(qx_06,1);
    if Nx_06(iia,ia)==0;
        cons06_in_qu(iia,ia-5)=0;
    else
        cons06_in_qu(iia,ia-5)=x_2006(iia,4);
    end
end
end
CON_NWQ06=sum(cons06_in_qu)./(sum(x_2006(:,4)));        % Consumption share per Net Worth quintile

%% Consumption Expenditure Rates
CEXPR_NWQ06=sum(cons06_in_qu)./(sum(dispi06_in_qu));
%% Mean Age
age06_in_qu=NaN(size(qx_06,1),5);
for ia=6:10;
for iia=1:size(qx_06,1);
    if Nx_06(iia,ia)==0;
        age06_in_qu(iia,ia-5)=0;
    else
        age06_in_qu(iia,ia-5)=x_2006(iia,3);
    end
end
end
MAGE_NWQ06=sum(age06_in_qu)./N_06;          % Mean Age per Net Worth Quintile

%% Compact report of joint distribution
JD06=[(1:5)' DISPI_NWQ06' CON_NWQ06' CEXPR_NWQ06' MAGE_NWQ06']; 
varn06={'NW-Quintile','Disp_inc','Con_Exp','Exp_rate','Meanage_head'};
[idx,idy]=size(JD06);
JD06_var=mat2cell(JD06,ones(1,idx),ones(1,idy));
JD06_var=cat(1,varn06,JD06_var);            % with variable names

%% YEAR 2008
%%% Partition into NW-Quintiles
qx_08=[x_2008(:,1:5) NaN(size(x_2008,1),5)];

for ii=1:size(x_2008,1);
        if (x_2008(ii,end)<=qu_x08(1,1));
            qx_08(ii,6)=x_2008(ii,end);
        else
            qx_08(ii,6)=0;
        end
end
for i=2:size(qu_x08,2);
    for ii=1:size(x_2008,1);
    if (x_2008(ii,end)<=qu_x08(1,i))&&(x_2008(ii,end)>qu_x08(1,i-1))
        qx_08(ii,5+i)=x_2008(ii,end);
    else
        qx_08(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2008,1);
        if (x_2008(ii,end)>qu_x08(1,4))
        qx_08(ii,end)=x_2008(ii,end);
        else
            qx_08(ii,end)=0;
        end
end
NWQ08=sum(qx_08(:,6:end))./(sum(x_2008(:,6)));        % Marginal Distribution of Net Worth 2008

%% Indicator which household is in which quintile

Nx_08=[x_2008(:,1:5) NaN(size(x_2008,1),5)];
for ii=1:size(x_2008,1);
        if (x_2008(ii,end)<=qu_x08(1,1))&& (x_2008(ii,end)>=min(x_2008(:,end)));
        Nx_08(ii,6)=1;
        else Nx_08(ii,6)=0;
        end
end
for i=2:size(qu_x08,2);
    for ii=1:size(x_2008,1);
    if (x_2008(ii,end)<=qu_x08(1,i))&&(x_2008(ii,end)>qu_x08(1,i-1))
        Nx_08(ii,5+i)=1;
    else
        Nx_08(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2008,1);
        if (x_2008(ii,end)>qu_x08(1,4))
        Nx_08(ii,end)=1;
        else
            Nx_08(ii,end)=0;
        end
end
N_08=sum(Nx_08(:,6:end));            % Number of households in every quintile

%% JOINT DISTRIBUTIONS
% Mit der Hilfe von Nx_08 wissen wir, in welchem Net Worth Quintile der 
% Haushalt ist und deswegen können wir nun für jedes NW-Quintile den Anteil 
% des Konsums, Disp. Income, Expenditure Rate und Age Head bestimmen

%% Disposable Income
dispi08_in_qu=NaN(size(qx_08,1),5);
for ia=6:10;
for iia=1:size(qx_08,1);
    if Nx_08(iia,ia)==0;
        dispi08_in_qu(iia,ia-5)=0;
    else
        dispi08_in_qu(iia,ia-5)=x_2008(iia,5);
    end
end
end
DISPI_NWQ08=sum(dispi08_in_qu)./(sum(x_2008(:,5)));       % Earnings share per Net Worth Quintile

%% Consumption Expenditures
cons08_in_qu=NaN(size(qx_08,1),5);
for ia=6:10;
for iia=1:size(qx_08,1);
    if Nx_08(iia,ia)==0;
        cons08_in_qu(iia,ia-5)=0;
    else
        cons08_in_qu(iia,ia-5)=x_2008(iia,4);
    end
end
end
CON_NWQ08=sum(cons08_in_qu)./(sum(x_2008(:,4)));        % Consumption share per Net Worth quintile

%% Consumption Expenditure Rates
CEXPR_NWQ08=sum(cons08_in_qu)./(sum(dispi08_in_qu));
%% Mean Age
age08_in_qu=NaN(size(qx_08,1),5);
for ia=6:10;
for iia=1:size(qx_08,1);
    if Nx_08(iia,ia)==0;
        age08_in_qu(iia,ia-5)=0;
    else
        age08_in_qu(iia,ia-5)=x_2008(iia,3);
    end
end
end
MAGE_NWQ08=sum(age08_in_qu)./N_08;          % Mean Age per Net Worth Quintile

%% Compact report of joint distribution
JD08=[(1:5)' DISPI_NWQ08' CON_NWQ08' CEXPR_NWQ08' MAGE_NWQ08']; 
varn08={'NW-Quintile','Disp_inc','Con_Exp','Exp_rate','Meanage_head'};
[idx,idy]=size(JD08);
JD08_var=mat2cell(JD08,ones(1,idx),ones(1,idy));
JD08_var=cat(1,varn08,JD08_var);            % with variable names

%% YEAR 2010
%%% Partition into NW-Quintiles
qx_10=[x_2010(:,1:5) NaN(size(x_2010,1),5)];

for ii=1:size(x_2010,1);
        if (x_2010(ii,end)<=qu_x10(1,1));
            qx_10(ii,6)=x_2010(ii,end);
        else
            qx_10(ii,6)=0;
        end
end
for i=2:size(qu_x10,2);
    for ii=1:size(x_2010,1);
    if (x_2010(ii,end)<=qu_x10(1,i))&&(x_2010(ii,end)>qu_x10(1,i-1))
        qx_10(ii,5+i)=x_2010(ii,end);
    else
        qx_10(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2010,1);
        if (x_2010(ii,end)>qu_x10(1,4))
        qx_10(ii,end)=x_2010(ii,end);
        else
            qx_10(ii,end)=0;
        end
end
NWQ10=sum(qx_10(:,6:end))./(sum(x_2010(:,6)));        % Marginal Distribution of Net Worth 2010

%% Indicator which household is in which quintile

Nx_10=[x_2010(:,1:5) NaN(size(x_2010,1),5)];
for ii=1:size(x_2010,1);
        if (x_2010(ii,end)<=qu_x10(1,1))&& (x_2010(ii,end)>=min(x_2010(:,end)));
        Nx_10(ii,6)=1;
        else Nx_10(ii,6)=0;
        end
end
for i=2:size(qu_x10,2);
    for ii=1:size(x_2010,1);
    if (x_2010(ii,end)<=qu_x10(1,i))&&(x_2010(ii,end)>qu_x10(1,i-1))
        Nx_10(ii,5+i)=1;
    else
        Nx_10(ii,5+i)=0;
    end
    end
end

for ii=1:size(x_2010,1);
        if (x_2010(ii,end)>qu_x10(1,4))
        Nx_10(ii,end)=1;
        else
            Nx_10(ii,end)=0;
        end
end
N_10=sum(Nx_10(:,6:end));            % Number of households in every quintile

%% JOINT DISTRIBUTIONS
% Mit der Hilfe von Nx_10 wissen wir, in welchem Net Worth Quintile der 
% Haushalt ist und deswegen können wir nun für jedes NW-Quintile den Anteil 
% des Konsums, Disp. Income, Expenditure Rate und Age Head bestimmen

%% Disposable Income
dispi10_in_qu=NaN(size(qx_10,1),5);
for ia=6:10;
for iia=1:size(qx_10,1);
    if Nx_10(iia,ia)==0;
        dispi10_in_qu(iia,ia-5)=0;
    else
        dispi10_in_qu(iia,ia-5)=x_2010(iia,5);
    end
end
end
DISPI_NWQ10=sum(dispi10_in_qu)./(sum(x_2010(:,5)));       % Earnings share per Net Worth Quintile

%% Consumption Expenditures
cons10_in_qu=NaN(size(qx_10,1),5);
for ia=6:10;
for iia=1:size(qx_10,1);
    if Nx_10(iia,ia)==0;
        cons10_in_qu(iia,ia-5)=0;
    else
        cons10_in_qu(iia,ia-5)=x_2010(iia,4);
    end
end
end
CON_NWQ10=sum(cons10_in_qu)./(sum(x_2010(:,4)));        % Consumption share per Net Worth quintile

%% Consumption Expenditure Rates
CEXPR_NWQ10=sum(cons10_in_qu)./(sum(dispi10_in_qu));
%% Mean Age
age10_in_qu=NaN(size(qx_10,1),5);
for ia=6:10;
for iia=1:size(qx_10,1);
    if Nx_10(iia,ia)==0;
        age10_in_qu(iia,ia-5)=0;
    else
        age10_in_qu(iia,ia-5)=x_2010(iia,3);
    end
end
end
MAGE_NWQ10=sum(age10_in_qu)./N_10;          % Mean Age per Net Worth Quintile

%% Compact report of joint distribution
JD10=[(1:5)' DISPI_NWQ10' CON_NWQ10' CEXPR_NWQ10' MAGE_NWQ10']; 
varn10={'NW-Quintile','Disp_inc','Con_Exp','Exp_rate','Meanage_head'};
[idx,idy]=size(JD10);
JD10_var=mat2cell(JD10,ones(1,idx),ones(1,idy));
JD10_var=cat(1,varn10,JD10_var);            % with variable names

