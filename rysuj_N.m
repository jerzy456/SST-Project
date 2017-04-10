function [] = rysuj_N(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,x,y,n)

close;
fig=figure(n);
set(fig,'Position',[300 60 1000 900]);
hold on;
%Rysuj plusiki na labiryncie
for i=0:16
    for j=0:16
        plot(i*10,j*10,'+','LineWidth',1);
    end
end
%
for i=1:16
    for j=1:16
        if sensor_gora(j,i)==1
            plot([i*10-10  i*10],[j*10 j*10],'LineWidth',2);
        end
        if sensor_prawo(j,i)==1
            plot([i*10 i*10],[j*10-10 j*10],'LineWidth',2);
        end
        if sensor_dol(j,i)==1
            plot([i*10-10  i*10],[j*10-10 j*10-10],'LineWidth',2);
        end
        if sensor_lewo(j,i)==1
            plot([i*10-10  i*10-10],[j*10 j*10-10],'LineWidth',2);
        end
        text(j*10-6,i*10-5,num2str(mapa(i,j)));
    end
end

plot(y*10-5,x*10-5,'bo','LineWidth',4);

ax=axis;
dx=ax(2)-ax(1); xs=(ax(1)+ax(2))/2;
dy=ax(4)-ax(3); ys=(ax(3)+ax(4))/2;
d=0.6*max(dx,dy);
axis([xs-d, xs+d, ys-d, ys+d]);
end