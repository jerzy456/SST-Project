function [mapa] = zalewanieBlokow(mapa,i,j,sensor_gora, sensor_prawo,sensor_dol,sensor_lewo)
if i~=16
    if sensor_gora(i,j)==0 && mapa(i+1,j)==-1 && mapa(i,j)~=-1  %Sensor 1 - przod, 2-prawo, 3-tyl, 4-lewo
        mapa(i+1,j)=mapa(i,j)+1;
    end
end
if j~=16
    if sensor_prawo(i,j)==0 && mapa(i,j+1)==-1 && mapa(i,j)~=-1
        mapa(i,j+1)=mapa(i,j)+1;
    end
end
if i~=1
    if sensor_dol(i,j)==0 && mapa(i-1,j)==-1 && mapa(i,j)~=-1
        mapa(i-1,j)=mapa(i,j)+1;
    end
end
if j~=1
    if sensor_lewo(i,j)==0 && mapa(i,j-1)==-1 && mapa(i,j)~=-1
        mapa(i,j-1)=mapa(i,j)+1;
    end
end
end