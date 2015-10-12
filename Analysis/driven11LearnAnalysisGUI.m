%% CREATE FIGURE WINDOW
function driven11LearnAnalysisGUI
hf = figure;
set(hf,'Visible','off','Toolbar','figure','Color',[.8 .8 .8],...
  'Position',[100 100 1000 600]);
initialRun
movegui(hf,'center')
set(hf,'Visible','on')

%% INITIAL RUN
function initialRun
hf = gcf;
handles.hf = hf;

%% Create title and equation
axes('Parent',hf,'Units','normalized','Position',[.02 .79 .45 .19]);
lcolor = jet(5);
hc = zeros(5,1);
for nc = 1:5
  hc(nc) = plot(NaN,NaN,'-','Color',lcolor(6-nc,:),'LineWidth',2);
  hold on
end
hl = legend(hc,'Stable node','Stable spiral','Unstable node',...
  'Unstable spiral','Saddle point','Location','NorthEast');
lpos = get(hl,'Position');
lpos(1:2) = [.345 .56];
set(hl,'Position',lpos)
hold off
axis off
text('String',['Oscillator Driven by a Sinusoid ' ...
  'via Plastic Coupling'],...
  'Position',[.0 1],'Units','normalized',...
  'HorizontalAlignment','left','VerticalAlignment','top',...
	'FontSize',13,'FontWeight','bold')
text('Interpreter','latex',...
	'String',{['$$\frac{dz}{dt} = z\left(\alpha + ' ...
  '\textrm{i}\omega + \beta_1 |z|^2\right) + cx$$'],...
  ['$$\frac{dc}{dt} = c\left(\lambda + \mu_1 |c|^2\right) + ' ...
  '\kappa z \bar{x}$$']},...
	'Position',[.02 .7],'Units','normalized',...
  'HorizontalAlignment','left','VerticalAlignment','top',...
	'FontSize',13)

%% Create Legend button
handles.legendButton = uicontrol('Parent',hf,'Style','pushbutton',...
  'String','Legend','FontSize',10,'Units','normalized',...
  'Position',[.42 .88 .07 .05]);

%% Make text boxes for parameter input and Draw button
hp1 = uipanel('Parent',hf,'Title','Parameters','FontSize',11,...
  'BackgroundColor',[.8 .8 .8],'Units','normalized',...
  'Position',[.02 .56 .32 .2]);
nc = 5; % # of columns
rb = 15; % ratio of box length relative to (half) space
wb = 1/nc*rb/(rb+2); % normalized width of boxes
ws = 1/(nc*(rb+2)); % normalized width of (half) space
wu = wb + 2*ws;
handles.alpha = uicontrol('Parent',hp1,'Style','edit','String','0',...
  'FontSize',11,'Units','normalized','Position',[ws .55 wb .25]);
handles.beta1 = uicontrol('Parent',hp1,'Style','edit','String','-1',...
  'FontSize',11,'Units','normalized','Position',[ws+wu .55 wb .25]);
handles.lambda = uicontrol('Parent',hp1,'Style','edit','String','-1',...
  'FontSize',11,'Units','normalized','Position',[ws+wu*2 .55 wb .25]);
handles.mu1 = uicontrol('Parent',hp1,'Style','edit','String','0',...
  'FontSize',11,'Units','normalized','Position',[ws+wu*3 .55 wb .25]);
handles.kappa = uicontrol('Parent',hp1,'Style','edit','String','1',...
  'FontSize',11,'Units','normalized','Position',[ws+wu*4 .55 wb .25]);
handles.F = uicontrol('Parent',hp1,'Style','edit','String','.8',...
  'FontSize',11,'Units','normalized','Position',[ws .05 wb .25]);
handles.df = uicontrol('Parent',hp1,'Style','edit','String','.5',...
  'FontSize',11,'Units','normalized','Position',[ws+wu .05 wb .25]);

handles.drawButton = uicontrol('Parent',hp1,'Style','pushbutton',...
  'String','Draw','FontSize',11,'Units','normalized',...
  'Position',[.65 .05 .325 .3]);

%% Labels for text boxes
axes('Parent',hp1,'Units','normalized','Position',[0 0 1 1])
axis off
text(wu/2,.85,'$$\alpha$$','Interpreter','Latex',...
  'HorizontalAlignment','center','VerticalAlignment','baseline',...
  'Units','normalized','FontSize',15)
text(wu*3/2,.85,'$$\beta_1$$','Interpreter','Latex',...
  'HorizontalAlignment','center','VerticalAlignment','baseline',...
  'Units','normalized','FontSize',15)
text(wu*5/2,.85,'$$\lambda$$','Interpreter','Latex',...
  'HorizontalAlignment','center','VerticalAlignment','baseline',...
  'Units','normalized','FontSize',15)
text(wu*7/2,.85,'$$\mu_1$$','Interpreter','Latex',...
  'HorizontalAlignment','center','VerticalAlignment','baseline',...
  'Units','normalized','FontSize',15)
text(wu*9/2,.85,'$$\kappa$$','Interpreter','Latex',...
  'HorizontalAlignment','center','VerticalAlignment','baseline',...
  'Units','normalized','FontSize',15)
text(wu/2,.35,'$$F$$','Interpreter','Latex',...
  'HorizontalAlignment','center','VerticalAlignment','baseline',...
  'Units','normalized','FontSize',15)
text(wu*3/2,.35,'$$\Omega/2\pi$$','Interpreter','Latex',...
  'HorizontalAlignment','center','VerticalAlignment','baseline',...
  'Units','normalized','FontSize',15)

%% Create axes
handles.ax1a = axes('Parent',hf,'Units','normalized',...
  'Position',[.12 .07 .09 .4],'XTick',[],'YTick',[],'box','on');
xlabel('{\itr}*','FontSize',11)
ylabel('{\itF}','FontSize',11)
text(-.5,.5,'Constant Frequency Difference (\Omega)','FontSize',11,...
  'FontWeight','bold','HorizontalAlignment','center',...
  'VerticalAlignment','middle','Units','normalized','Rotation',90)

handles.ax1b = axes('Parent',hf,'Units','normalized',...
  'Position',[.26 .07 .09 .4],'XTick',[],'YTick',[],'box','on');
xlabel('{\itA}*','FontSize',11)

handles.ax1c = axes('Parent',hf,'Units','normalized',...
  'Position',[.4 .07 .09 .4],'XTick',[],'YTick',[],'box','on');
xlabel('{\it\psi}*','FontSize',11)

handles.ax2a = axes('Parent',hf,'Units','normalized',...
  'Position',[.57 .85 .41 .10],'XTick',[],'YTick',[],'box','on');
ylabel('{\itr}*','FontSize',11)
title('Constant Forcing Amplitude ({\itF})','FontSize',11,...
  'FontWeight','bold')

handles.ax2b = axes('Parent',hf,'Units','normalized',...
  'Position',[.57 .7 .41 .10],'XTick',[],'YTick',[],'box','on');
ylabel('{\itA}*','FontSize',11)

handles.ax2c = axes('Parent',hf,'Units','normalized',...
  'Position',[.57 .55 .41 .10],'XTick',[],'YTick',[],'box','on');
%xlabel('\Omega/2\pi','FontSize',11)
ylabel('{\it\psi}*','FontSize',11)

handles.ax3 = axes('Parent',hf,'Units','normalized',...
  'Position',[.57 .07 .41 .4],'XTick',[],'YTick',[],'box','on');
xlabel('\Omega/2\pi','FontSize',11)
%ylabel('{\itF}','FontSize',11)
title('Stability Region','FontSize',11,'FontWeight','bold')

%% Define callback functions
set(handles.drawButton,'Callback',{@drawAnalysis,handles})
set(handles.legendButton,'Callback',@showLegend)

%% DRAW ANALYSIS
function drawAnalysis(~,~,handles)
%% Get parameters
a = str2double(get(handles.alpha,'String'));
b1 = str2double(get(handles.beta1,'String'));
l = str2double(get(handles.lambda,'String'));
m1 = str2double(get(handles.mu1,'String'));
ka = str2double(get(handles.kappa,'String'));
F = str2double(get(handles.F,'String'));
W = str2double(get(handles.df,'String'))*2*pi;
lcolor = jet(5);

%% Prepare vectors of forcing and Omega
if F <= 0
  axes(handles.ax3)
  cla
  set(handles.ax3,'XTick',[],'YTick',[],'box','on')
  text(.5,.5,'{\itF} must be greater than 0','FontSize',15,...
    'HorizontalAlignment','center','VerticalAlignment','middle',...
    'Units','normalized')
  return
end

FF = (.01:.005:1)*ceil(2.5*F)/2;
WW = (-1:.01:1)*ceil(2.5*abs(W+eps)/(2*pi))*pi;

%% Constant Omega plot
axes(handles.ax1a)
cla
set(gca,'XTick',[],'YTick',[],'box','on')
text(.5,.5,'Calculating...','FontSize',15,...
  'HorizontalAlignment','center','VerticalAlignment','middle',...
  'Units','normalized','Rotation',90)
text(-.5,.5,'Constant Frequency Difference (\Omega)','FontSize',11,...
  'FontWeight','bold','HorizontalAlignment','center',...
  'VerticalAlignment','middle','Units','normalized','Rotation',90)
axes(handles.ax1b)
cla
set(gca,'XTick',[],'YTick',[],'box','on')
text(.5,.5,'Calculating...','FontSize',15,...
  'HorizontalAlignment','center','VerticalAlignment','middle',...
  'Units','normalized','Rotation',90)
axes(handles.ax1c)
cla
set(gca,'XTick',[],'YTick',[],'box','on')
text(.5,.5,'Calculating...','FontSize',15,...
  'HorizontalAlignment','center','VerticalAlignment','middle',...
  'Units','normalized','Rotation',90)
drawnow

rstar = cell(size(FF));
Astar = cell(size(FF));
psistar = cell(size(FF));
stabtype = cell(size(FF));
rmax = 0; Amax = 0;
for n = 1:length(FF)
  [rstar{n},Astar{n},psistar{n},~,stabtype{n}] = ...
    rStarDriven11Learn(a,b1,l,m1,ka,FF(n),W,1);
  stabtype{n} = ceil(stabtype{n});
  rmax = max([rmax max(rstar{n})]);
  Amax = max([Amax max(Astar{n})]);
end

axes(handles.ax1a)
for n = 1:length(FF)
  for nr = 1:length(rstar{n})
    plot(rstar{n}(nr),FF(n),'.',...
      'Color',lcolor(stabtype{n}(nr)+1,:),'MarkerSize',10);
    hold on
  end
end
if rmax == 0
  rmax = 1;
end
plot([0 rmax*1.1],[1 1]*F,'r--','LineWidth',2)
set(gca,'XLim',[0 rmax*1.1],'YLim',[min(FF) max(FF)])
xlabel('{\itr}*','FontSize',11)
ylabel('{\itF}','FontSize',11)
text(-.7,.5,'Constant Frequency Difference (\Omega)','FontSize',11,...
  'FontWeight','bold','HorizontalAlignment','center',...
  'VerticalAlignment','middle','Units','normalized','Rotation',90)
grid on
hold off
set(gca,'XDir','Reverse')

axes(handles.ax1b)
for n = 1:length(FF)
  for nr = 1:length(Astar{n})
    plot(Astar{n}(nr),FF(n),'.',...
      'Color',lcolor(stabtype{n}(nr)+1,:),'MarkerSize',10);
    hold on
  end
end
if Amax == 0
  Amax = 1;
end
plot([0 Amax*1.1],[1 1]*F,'r--','LineWidth',2)
set(gca,'XLim',[0 Amax*1.1],'YLim',[min(FF) max(FF)])
xlabel('{\itA}*','FontSize',11)
grid on
hold off
set(gca,'XDir','Reverse')

axes(handles.ax1c)
for n = 1:length(FF)
  for nr = 1:length(psistar{n})
    plot(real(psistar{n}(nr)),FF(n),'.',...
      'Color',lcolor(stabtype{n}(nr)+1,:),'MarkerSize',10);
    hold on
  end
end
plot([-1 1]*pi,[1 1]*F,'r--','LineWidth',2)
set(gca,'XLim',[-1 1]*pi,'XTick',[-pi,-pi/2,0,pi/2,pi],...
  'XTickLabel',{'-pi';'-pi/2';'0';'pi/2';'pi'},'YLim',[min(FF) max(FF)])
xlabel('{\it\psi}*','FontSize',11)
grid on
hold off
set(gca,'XDir','Reverse')

%% Constant Forcing plot
axes(handles.ax2a)
cla
set(gca,'XTick',[],'YTick',[],'box','on')
text(.5,.5,'Calculating...','FontSize',15,...
  'HorizontalAlignment','center','VerticalAlignment','middle',...
  'Units','normalized')
axes(handles.ax2b)
cla
set(gca,'XTick',[],'YTick',[],'box','on')
text(.5,.5,'Calculating...','FontSize',15,...
  'HorizontalAlignment','center','VerticalAlignment','middle',...
  'Units','normalized')
axes(handles.ax2c)
cla
set(gca,'XTick',[],'YTick',[],'box','on')
text(.5,.5,'Calculating...','FontSize',15,...
  'HorizontalAlignment','center','VerticalAlignment','middle',...
  'Units','normalized')
drawnow

rstar = cell(size(WW));
Astar = cell(size(WW));
psistar = cell(size(WW));
stabtype = cell(size(WW));
rmax = 0; Amax = 0;

for n = 1:length(WW)
  [rstar{n},Astar{n},psistar{n},~,stabtype{n}] = ...
    rStarDriven11Learn(a,b1,l,m1,ka,F,WW(n),1);
  stabtype{n} = ceil(stabtype{n});
  rmax = max([rmax max(rstar{n})]);
  Amax = max([Amax max(Astar{n})]);
end

axes(handles.ax2a)
for n = 1:length(WW)
  for nr = 1:length(rstar{n})
    plot(WW(n)/(2*pi),rstar{n}(nr),'.',...
      'Color',lcolor(stabtype{n}(nr)+1,:),'MarkerSize',10);
    hold on
  end
end
if rmax == 0
  rmax = 1;
end
plot([1 1]*W/(2*pi),[0 rmax*1.1],'b--','LineWidth',2)
set(gca,'XLim',[min(WW) max(WW)]./(2*pi),'YLim',[0 rmax*1.1])
ylabel('{\itr}*','FontSize',11)
title('Constant Forcing Amplitude ({\itF})','FontSize',11,...
  'FontWeight','bold')
grid on
hold off

axes(handles.ax2b)
for n = 1:length(WW)
  for nr = 1:length(Astar{n})
    plot(WW(n)/(2*pi),Astar{n}(nr),'.',...
      'Color',lcolor(stabtype{n}(nr)+1,:),'MarkerSize',10);
    hold on
  end
end
if Amax == 0
  Amax = 1;
end
plot([1 1]*W/(2*pi),[0 Amax*1.1],'b--','LineWidth',2)
set(gca,'XLim',[min(WW) max(WW)]./(2*pi),'YLim',[0 Amax*1.1])
ylabel('{\itA}*','FontSize',11)
grid on
hold off

axes(handles.ax2c)
for n = 1:length(WW)
  for nr = 1:length(psistar{n})
    plot(WW(n)/(2*pi),real(psistar{n}(nr)),'.',...
      'Color',lcolor(stabtype{n}(nr)+1,:),'MarkerSize',10);
    hold on
  end
end
plot([1 1]*W/(2*pi),[-1 1]*pi,'b--','LineWidth',2)
set(gca,'XLim',[min(WW) max(WW)]./(2*pi),'YLim',[-1 1]*pi,...
  'YTick',[-pi,-pi/2,0,pi/2,pi],...
  'YTickLabel',{'-pi';'-pi/2';'0';'pi/2';'pi'})
ylabel('{\it\psi}*','FontSize',11)
grid on
hold off

%% Draw Stability Region
axes(handles.ax3)
cla
set(gca,'XTick',[],'YTick',[],'box','on')
text(.5,.5,'Calculating...','FontSize',15,...
  'HorizontalAlignment','center','VerticalAlignment','middle',...
  'Units','normalized')
drawnow
STABTYPE = zeros(length(FF),length(WW));
for nf = 1:length(FF)
  for nw = 1:length(WW)
    [~,~,~,stab,type] = rStarDriven11Learn(a,b1,l,m1,ka,FF(nf),WW(nw),1);
    if isempty(stab)
      STABTYPE(nf,nw) = -1;
    elseif sum(stab) < 2
      STABTYPE(nf,nw) = max(type); % show stable type if any
    elseif sum(stab) == 2
      STABTYPE(nf,nw) = 5;
    else
      error('Three or more stable fixed points?')
    end
  end
end
imagesc(WW/(2*pi),FF,STABTYPE)
colormap([1 1 1; jet(5); .5 0 .5])
      % purple for 2 stable pts, white for no fixed pt
caxis([-1 5])
hold on
plot(get(gca,'XLim'),[1 1]*F,'r--','LineWidth',2)
plot([1 1]*W/(2*pi),get(gca,'YLim'),'b--','LineWidth',2)
hold off
set(gca,'YDir','normal')
xlabel('\Omega/2\pi','FontSize',11)
%ylabel('{\itF}','FontSize',11)
title('Stability Region','FontSize',11,'FontWeight','bold')
grid on

%% SHOW LEGEND
function showLegend(~,~)
hf = figure;
fpos = get(hf,'Position');

set(hf,'Position',[fpos(1) fpos(2) 350 220])
axes('Units','normalized','Position',[0 0 1 1]);
axis off
text('Interpreter','latex','String',{'$$z = re^{\textrm{i}\phi}$$,',...
  '$$c = Ae^{\textrm{i}\theta}$$,',...
  ['$$x = Fe^{\textrm{i}\vartheta}$$ '...
  'where $\vartheta = \omega_0t+\vartheta_0$,'],...
  '$$\psi=\theta-\phi+\vartheta$$, and',...
  '$$\Omega = \omega - \omega_0$$'},...
	'Position',[.05 .9],'Units','normalized',...
  'HorizontalAlignment','left','VerticalAlignment','top',...
	'FontSize',15)
text('Interpreter','latex','String',...
  {'*Purple in the Stability Region indicates',...
  'the existence of two stable fixed points'},...
	'Position',[.05 .2],'Units','normalized',...
  'HorizontalAlignment','left','VerticalAlignment','top',...
	'FontSize',13)