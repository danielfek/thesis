%% I.1) AGGREGATES
clear;close all;
%% Data
[data,~,alldata]=xlsread('income.xlsx','Compact Set');
[Cdata,~,allC]=xlsread('consump.xlsx','Aggregate');
[Y_W,~,allY]=xlsread('income.xlsx','aggregate');
T=(2004:2:2012)';
%% Datareport (Krueger et al. 2016, pp. 7)
%%% Income (2004=1)
Y=[(2004:2:2012)' (Y_W(2:end,2)./Y_W(2,2))];
figure(1)
plot(T,Y(:,2),'-s','LineWidth',1.5)
grid on;ax1=gca;ylim([0.95 1.15]);set(ax1,'XTick',T);set(ax1,'XLim',[2002 2014]);ax1.XTickLabel=(2004:2:2012);
title('Income');xlabel('Year');ylabel('2004=1');
%%% Consumption (2004=1)
C=[(2004:2:2012)' (Cdata(2:end,8)./Cdata(2,8))];
figure(2)
plot(T,C(:,2),'-s','LineWidth',1.5)
grid on;ax2=gca;set(ax2,'XTick',T);set(ax2,'XLim',[T(1,1)-1 T(end,1)+1]);
ax2.XTickLabel={'2004-2005','2006-2007','2008-2009','2010-2011','2012-2013'};title('Consumption Expenditures');
xlabel('Year');ylabel('2004-2005=1');ylim([0.98 1.1]);
%%% Wealth (2004=1)
W_oe=[(2004:2:2012)' (Y_W(2:end,3)./Y_W(2,3))];
W_we=[(2004:2:2012)' (Y_W(2:end,4)./Y_W(2,4))];
figure(3)
plot(T,W_oe(:,2),'-s', T,W_we(:,2),'-s','LineWidth',1.5)
grid on;ax3=gca;set(ax3,'XTick',T);ax3.XTickLabel=(W_oe(:,1));set(ax3,'XLim',[T(1,1)-1 T(end,1)+1]);
title('Wealth with and without equity');xlabel('Year');ylabel('2004=1');
legend('Wealth without equity','Wealth with equity');






