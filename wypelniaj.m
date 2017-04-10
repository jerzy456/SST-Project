function [dsensor_gora,dsensor_prawo,dsensor_dol,dsensor_lewo] = wypelniaj(dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo)
% labirynt podzielony jest na romby, w zale¿noœci od obszaru rombu, w który
% klikniemy dorysowuje œcianê
close;
a=rysuj_2(dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
while(1)
    while (1)
        waitforbuttonpress;
        point = get(a,'CurrentPoint');
        xp=point(1,1);
        yp=point(1,2);
        
        for n=0:15
            if xp>n && xp<n+1
                j=n+1;
            end
            if yp>n && yp<n+1
                i=n+1;
            end
        end
        
        if xp<0 ||yp<0||xp>16||yp>16
            break;
        end
        
        if yp<i-0.8 && xp>j-0.85 && xp<j-0.15
            if dsensor_dol(i,j)==0
                dsensor_dol(i,j)=1;
            else
                dsensor_dol(i,j)=0;
            end
        elseif yp>i-0.2 && xp>j-0.85 && xp<j-0.15
            if dsensor_gora(i,j)==0
                dsensor_gora(i,j)=1;
            else
                dsensor_gora(i,j)=0;
            end
        elseif xp<j-0.8 && yp>i-0.85 && yp<i-0.15
            if dsensor_lewo(i,j)==0
                dsensor_lewo(i,j)=1;
            else
                dsensor_lewo(i,j)=0;
            end
        elseif xp>j-0.2 && yp>i-0.85 && yp<i-0.15
            if dsensor_prawo(i,j)==0
                dsensor_prawo(i,j)=1;
            else
                dsensor_prawo(i,j)=0;
            end
        end
        [dsensor_gora,dsensor_prawo,dsensor_dol,dsensor_lewo] = obrobkaSensorow_2(dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
        a=rysuj_2(dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
        
    end
    temp0 = menu('Czy na pewno chcesz zakoñczyæ rysowanie labiryntu','Tak','Nie');
    switch temp0
        case 1
            break;
        case 2
    end
    
end
close;
end