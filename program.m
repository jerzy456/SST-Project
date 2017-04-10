
mapa=zeros(16);
sensor_gora=zeros(16);
sensor_prawo=zeros(16);
sensor_dol=zeros(16);
sensor_lewo=zeros(16);
czy_byl=zeros(16);
czy_byl(1,1)=1;
sensor_gora(16,:)=1;
sensor_prawo(:,16)=1;
sensor_dol(1,:)=1;
sensor_lewo(:,1)=1;
iter=0;
droga=zeros(256,2);
droga(1,1)=1;
droga(1,2)=1;
kierunek=1;
while (1)
    iter=iter+1;
    i=1;%pozycja robota-wiersz
    j=1;%pozycja robota-kolumna
    %uzupe³nij brakuj¹ce informacje, ze wzglêdu na wspó³dzielone œciany
    [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
    
    %wstepne rozlanie wody do zupelnie pustego labiryntu, wyznacza kierunek
    %pierwszego ruchu
    %mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
    mapa=zalewanie(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
    %mapa macierz wag komórek
    while mapa(i,j)~=0
        %odczyt z sensorów
        [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
        %wnioskuj informacje o innych komórkach
        [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
        %okreœlenie czy trzeba zalewaæ wod¹, czy mo¿na jechaæ do komórki o
        %ni¿szym potencjale na podstawie poprzednich zalewañ
        [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
        %l czy trzeba zalaæ czy mo¿na jechaæ
        if l==1
            %ustaw akcje robota
            [akcja,kierunek] = gdzie_pojechac(kierunek,a,b,i,j);
            i=a;
            j=b;
        else
            %zalej i ustaw akcje robota
            %mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
            mapa=zalewanie(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
            [~,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
            [akcja,kierunek] = gdzie_pojechac(kierunek,a,b,i,j);
            i=a;
            j=b;
        end
        %akualizuj stan komórki na "zwiedzona"
        czy_byl(i,j)=1;
    end
    
    %kolejny przejazd przestawienie na start
    i=1;
    j=1;
    d=1;
    k=2;
    kierunek=1;
    while mapa(i,j)~=0
        [d,a,b]=gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d);
        if d==0
            %robot chce przejechaæ do komórki nie zeskanowanej
            %wróc do przejaazdu skanuj¹cego
            break;
        end
        i=a;
        j=b;
        droga(k,1)=i;
        droga(k,2)=j;
        k=k+1;
    end
    %robot chce przejechaæ przez komórki, w których by³ znaczy znaleŸliœmy
    %najkrótsz¹ drogê przejazdu
    if d==1
        break;
    end
end

[trasa]=sciezka(droga);

%To tylko rysuje mapê i trasê, niepotrzebne w robocie
rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,1,1);
title(['Liczba przejazdow testowych potrzebnych do wyliczenia drogi: ', num2str(iter)])
for i=2:255
    if droga(i,1)~=0||droga(i,2)~=0
        plot([droga(i-1,2)*10-5  droga(i,2)*10-5],[droga(i-1,1)*10-5 droga(i,1)*10-5],'g','LineWidth',2);
    end
end


