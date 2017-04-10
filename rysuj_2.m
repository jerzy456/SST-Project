function [a] = rysuj_2(dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo)
fig=figure(1);
set(fig,'Position',[300 60 1000 900]);
a = axes('Parent',fig);
title('Aby zakoñczyæ rysowanie kliknij poza labiryntem')
hold on

for i=0:16
    for j=0:16
        if (i~=8||j~=8)
            plot(i,j,'+','LineWidth',1);
        end
    end
end

for i=1:16
    for j=1:16
        if dsensor_gora(j,i)==1
            plot([i-1  i],[j j],'LineWidth',2);
        end
        if dsensor_prawo(j,i)==1
            plot([i i],[j-1 j],'LineWidth',2);
        end
        if dsensor_dol(j,i)==1
            plot([i-1  i],[j-1 j-1],'LineWidth',2);
        end
        if dsensor_lewo(j,i)==1
            plot([i-1  i-1],[j j-1],'LineWidth',2);
        end
    end
end

text(8-0.5,8,'meta','FontSize',14);
plot(1-0.5,1-0.5,'bo','LineWidth',4);

ax=axis;
dx=ax(2)-ax(1); xs=(ax(1)+ax(2))/2;
dy=ax(4)-ax(3); ys=(ax(3)+ax(4))/2;
d=0.6*max(dx,dy);
axis([xs-d, xs+d, ys-d, ys+d]);
end