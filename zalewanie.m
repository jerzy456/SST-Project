function [mapa] = zalewanie (sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa)

for i=1:16
    for j=1:16
        mapa(i,j)=-1;
    end
end
mapa(8,8)=0;
mapa(8,9)=0;
mapa(9,8)=0;
mapa(9,9)=0;

p=1;
while p
    p=0;
    for j=1:8
        k=17-j;
        for i=1:8
            [mapa]=zalewanieBlokow(mapa, i, j, sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
            [mapa]=zalewanieBlokow(mapa, i, k, sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
            l=17-i;
            [mapa]=zalewanieBlokow(mapa, l, j, sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
            [mapa]=zalewanieBlokow(mapa, l, k, sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
            if mapa(i,j)==-1||mapa(i,k)==-1||mapa(l,j)==-1||mapa(l,k)==-1
                p=1;
            end
        end
    end
end
end