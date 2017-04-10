function [d,a,b] = gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d)
a=0;
b=0;
if i~=16
    if mapa(i+1,j)<mapa(i,j) && sensor_gora(i,j)==0
        a=i+1;
        b=j;
    end
end
if j~=16
    if mapa(i,j+1)<mapa(i,j) && sensor_prawo(i,j)==0
        a=i;
        b=j+1;
    end
end
if i~=1
    if mapa(i-1,j)<mapa(i,j) && sensor_dol(i,j)==0
        a=i-1;
        b=j;
    end
end
if j~=1
    if mapa(i,j-1)<mapa(i,j) && sensor_lewo(i,j)==0
        a=i;
        b=j-1;
    end
end
if a==0||b==0
    d=0;
elseif czy_byl(a,b)==0
    d=0;
end
end