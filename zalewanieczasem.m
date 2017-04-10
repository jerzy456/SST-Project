function [mapa] = zalewanieczasem (sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa)

skret=3;

for i=1:16
    for j=1:16
        mapa(i,j)=-1;
    end
end
mapa(8,8)=0;
mapa(8,9)=0;
mapa(9,8)=0;
mapa(9,9)=0;

kierunek=zeros(16);

kierunek(8,8)=8;
kierunek(8,9)=8;
kierunek(9,9)=8;
kierunek(9,8)=8;

if sensor_dol(8,8)==0
    kierunek(7,8)=3;
    mapa(7,8)=1;
end
if sensor_dol(8,9)==0
    kierunek(7,9)=3;
    mapa(7,9)=1;
end
if sensor_prawo(8,9)==0
    kierunek(8,10)=2;
    mapa(8,10)=1;
end
if sensor_prawo(9,9)==0
    kierunek(9,10)=2;
    mapa(9,10)=1;
end
if sensor_gora(9,8)==0
    kierunek(10,8)=1;
    mapa(10,8)=1;
end
if sensor_gora(9,9)==0
    kierunek(10,9)=1;
    mapa(10,9)=1;
end
if sensor_lewo(9,8)==0
    kierunek(9,7)=4;
    mapa(9,7)=1;
end
if sensor_lewo(8,8)==0
    kierunek(8,7)=4;
    mapa(8,7)=1;
end



for t=1:256
    p=0;
    for i=1:16
        for j=1:16
            if i~=16
                if (kierunek(i,j)==0 && sensor_gora(i,j)==0 && kierunek(i+1,j)~=0)||...
                        (sensor_gora(i,j)==0 && (mapa(i,j)-mapa(i+1,j))>1 && (mapa(i,j)-mapa(i+1,j))~=skret && kierunek(i,j)~=0 && kierunek(i+1,j)~=0)
                    if kierunek(i+1,j)==3
                        mapa(i,j)=mapa(i+1,j)+1;
                        kierunek(i,j)=3;
                    else
                        mapa(i,j)=mapa(i+1,j)+skret;
                        kierunek(i,j)=3;
                    end
                    p=1;
                end
            end
            if j~=16
                if (kierunek(i,j)==0 && sensor_prawo(i,j)==0 && kierunek(i,j+1)~=0)||...
                        (sensor_prawo(i,j)==0 && (mapa(i,j)-mapa(i,j+1))>1 && (mapa(i,j)-mapa(i,j+1))~=skret && kierunek(i,j)~=0 && kierunek(i,j+1)~=0)
                    if kierunek(i,j+1)==4
                        mapa(i,j)=mapa(i,j+1)+1;
                        kierunek(i,j)=4;
                    else
                        mapa(i,j)=mapa(i,j+1)+skret;
                        kierunek(i,j)=4;
                    end
                    p=1;
                end
            end
            if i~=1
                if (kierunek(i,j)==0 && sensor_dol(i,j)==0 && kierunek(i-1,j)~=0)||...
                        (sensor_dol(i,j)==0 && (mapa(i,j)-mapa(i-1,j))>1 && (mapa(i,j)-mapa(i-1,j))~=skret && kierunek(i,j)~=0 && kierunek(i-1,j)~=0)
                    if kierunek(i-1,j)==1
                        mapa(i,j)=mapa(i-1,j)+1;
                        kierunek(i,j)=1;
                    else
                        mapa(i,j)=mapa(i-1,j)+skret;
                        kierunek(i,j)=1;
                    end
                    p=1;
                end
            end
            if j~=1
                if (kierunek(i,j)==0 && sensor_lewo(i,j)==0 && kierunek(i,j-1)~=0)||...
                        (sensor_lewo(i,j)==0 && (mapa(i,j)-mapa(i,j-1))>1 && (mapa(i,j)-mapa(i,j-1))~=skret && kierunek(i,j)~=0 && kierunek(i,j-1)~=0)
                    if kierunek(i,j-1)==2
                        mapa(i,j)=mapa(i,j-1)+1;
                        kierunek(i,j)=2;
                    else
                        mapa(i,j)=mapa(i,j-1)+skret;
                        kierunek(i,j)=2;
                    end
                    p=1;
                end
            end
        end
    end
    if p==0
        break;
    end
end
end