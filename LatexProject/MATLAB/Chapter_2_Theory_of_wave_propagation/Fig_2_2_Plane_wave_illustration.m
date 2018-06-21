clear
close all

c = 343.1;      % Speed of sound [m/s]
f = 1000;       % Plane wave frequency
w = 2*pi*f;     % Angular frequency
k = w/c;        % Acoustic wave number
lambda = c/f;

kx1 = k*1/sqrt(2);
kz1 = 0;
kx2 = k*1.01;
kz2 = 0;

ky1 = sqrt( k^2 - kx1^2 - kz1^2 );
ky2 = sqrt( k^2 - kx2^2 - kz2^2 );

dx = 0.01;
x = (-3.1*lambda:dx:3.1*lambda)';
y = x+3.1*lambda;
[X,Y] = meshgrid(x,y);

field_prop = exp( 1i*( kx1*X + ky1*Y  ) );
field_evan = exp( 1i*( kx2*X + ky2*Y  ) );
%%
ftsize = 11/0.9;
f = figure('Units','points','Position',[200,200,500,230]);
set(f,'defaulttextinterpreter','latex')
set(gcf,'Units','normalized');

subplot(1,2,1)
p1 = pcolor(x,y,real(field_prop));
set(gca, 'Units','normalized','Position',[ 0.09 0.11 0.37 .9 ]);
caxis([-1.5,1.5])
shading interp
xlabel( '$x \rightarrow$ [m]' , 'FontSize', ftsize );
ylabel( '$y \rightarrow$ [m]' , 'FontSize', ftsize );
axis equal tight
hold on
contour( x, y, real(field_prop),[0 0], '-k');

c = [-.25 .75];
xo = [0,kx1]/k;
yo = [0,ky1]/k;

headWidth = 5;
headLength = 5;
LineLength = 0.5;
ah = annotation('arrow',...
    'headStyle','cback2','HeadLength',headLength,'HeadWidth',headWidth);
set(ah,'parent',gca);
set(ah,'position',[c(1) c(2) kx1/k  ky1/k ]);
ah = annotation('arrow',...
    'headStyle','cback2','HeadLength',headLength,'HeadWidth',headWidth);
set(ah,'parent',gca);
set(ah,'position',[c(1) c(2) kx1/k 0]);
ah = annotation('arrow',...
    'headStyle','cback2','HeadLength',headLength,'HeadWidth',headWidth);
set(ah,'parent',gca);
set(ah,'position',[c(1) c(2) 0 ky1/k]);
plot(c(1),c(2), 'ko', 'MarkerSize',2,'LineWidth',2);
text( 0.28, 1.45 , 0.5 ,'$\mathbf{k}$' , 'Interpreter', 'LaTex' , 'FontSize', ftsize );
text( 0.35, 0.85 , 0.5 ,'$k_x$' , 'Interpreter', 'LaTex' , 'FontSize', ftsize );
text( -0.2, 1.4 , 0.52 ,'$k_y$' , 'Interpreter', 'LaTex' , 'FontSize', ftsize );
text(  -0.1, 0.85 , 0.52 ,'$\varphi$' , 'Interpreter', 'LaTex' , 'FontSize', ftsize );

t = (-0.75:0.01:0.75)';
plot(c(1)-t,c(2)+t,'--k');
fi = (0:0.1:45)*pi/180;
plot( 0.3*cos(fi)+c(1), 0.3*sin(fi)+c(2) , 'k' );
set(gca,'FontName','Times New Roman');

ax1 = gca;
x0 = (-3:1.5:3);
ax1.XTick = lambda*x0;
ax1.YTick = lambda*(x0+3);
set(gca,'TickLabelInterpreter', 'tex');
xtik_n = cell(5,1);
xtik_n{1} = '-3\lambda'; xtik_n{2} = '-1.5\lambda'; xtik_n{3} = '0'; xtik_n{4} = '1.5\lambda'; xtik_n{5} = '3\lambda';
ytik_n = cell(5,1);
ytik_n{1} = '0'; ytik_n{2} = '1.5\lambda'; ytik_n{3} = '3\lambda'; ytik_n{4} = '4.5\lambda'; ytik_n{5} = '6\lambda';
ax1.YTickLabel = ytik_n;
ax1.XTickLabel = xtik_n;


subplot(1,2,2)
p2 = pcolor(x,y,real(field_evan));
set(gca, 'Units','normalized','Position',[ 0.61 0.11 0.37 .9 ]);
caxis(.5*[-1,1])
shading interp
xlabel( '$x \rightarrow [\mathrm{m}]$' , 'Interpreter', 'LaTex' , 'FontSize', ftsize );
ylabel( '$y \rightarrow [\mathrm{m}]$' , 'Interpreter', 'LaTex' , 'FontSize', ftsize );
axis equal tight
hold on
pcolor_ax =(gca);
cRange = caxis;
[C,~]= contour( x, y, real(field_evan),[0 0], '-k');
ax1 = gca;
ax1.YTickLabel = ytik_n;
ax1.XTickLabel = xtik_n;


set(gca,'FontName','Times New Roman');
allAxesInFigure = findall(f,'type','axes');
set(allAxesInFigure,'FontSize',ftsize);

set(gcf,'PaperPositionMode','auto');
print( '-r300', fullfile( '../..','Figures/Basic_acoustics','plane_wave_illustration' ) ,'-dpng')