%Path optimalization project
%Rozwi¹¿ labirynt
program;
%Wyrysuj rozwi¹zany labirynt wraz z przejazdem w stylu TAXI
 n=5;
    rysuj_N(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,1,1,n);
    title(['Liczba przejazdow testowych potrzebnych do wyliczenia drogi: ', num2str(iter)])
    for i=2:255
        if droga(i,1)~=0||droga(i,2)~=0
            plot([droga(i-1,2)*10-5  droga(i,2)*10-5],[droga(i-1,1)*10-5 droga(i,1)*10-5],'g','LineWidth',2);
        end
    end
 
%opis tablicy trasa -1- prosto; -2- w prawo; -3- w lewo