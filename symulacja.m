

mapa=zeros(16);
sensor_gora=zeros(16);
sensor_prawo=zeros(16);
sensor_dol=zeros(16);
sensor_lewo=zeros(16);
dsensor_gora=zeros(16);
dsensor_prawo=zeros(16);
dsensor_dol=zeros(16);
dsensor_lewo=zeros(16);

sensor_gora(16,:)=1;
sensor_prawo(:,16)=1;
sensor_dol(1,:)=1;
sensor_lewo(:,1)=1;
dsensor_gora(16,:)=1;
dsensor_prawo(:,16)=1;
dsensor_dol(1,:)=1;
dsensor_lewo(:,1)=1;

czy_byl=zeros(16);
czy_byl(1,1)=1;

iter=0;

droga=zeros(256,2);
droga(1,1)=1;
droga(1,2)=1;

kierunek=1;

temp = menu('Jaki labirynt chcesz wykorzystaæ?','W³aœny (rysuj labirynt)','Labirynt 1','Labirynt 2');
switch temp
    case 1
        [dsensor_gora,dsensor_prawo,dsensor_dol,dsensor_lewo] = wypelniaj(dsensor_gora,dsensor_prawo,dsensor_dol,dsensor_lewo);
    case 2
        load('labirynt_1.mat');
    case 3
        load('labirynt_2.mat');
end

temp1 = menu('Czy chcesz œledzic kolejne przejazdy skanuj¹ce labirynt?','Tak','Nie');
switch temp1
    case 1
        temp2 = menu('Jaki algorytm chcesz wykorzystaæ?','zwyk³e rozlewanie wody','Rozlewanie wody uwzglêdiaj¹ce wiêkszy koszt skrêtu');
        switch temp2
            case 1
                temp4 = menu('Czy chcesz œledziæ ka¿dy ruch robota w labiryncie','Tak','Nie');
                switch temp4
                    case 1
                        while (1)
                            iter=iter+1;
                            i=1;%pozycja robota-wiersz
                            j=1;%pozycja robota-kolumna
                            [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                            mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);%wstepne rozlanie wody do zupelnie pustego labiryntu
                            
                            while mapa(i,j)~=0
                                
                                [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                                [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                                [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                
                                if l==1
                                    [akcja,kierunek] = gdzie_pojechac(kierunek,a,b,i,j);
                                    i=a;
                                    j=b;
                                else
                                    mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                                    [~,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                    [akcja,kierunek] = gdzie_pojechac(kierunek,a,b,i,j);
                                    i=a;
                                    j=b;
                                end
                                czy_byl(i,j)=1;
                                rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,i,j);
                                temp5 = menu('Czy wykonaæ kolejny ruch','Tak','Dokoñcz automatycznie');
                                switch temp5
                                    case 1
                                    case 2
                                        while mapa(i,j)~=0
                                            
                                            [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                                            [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                                            [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                            if l==1
                                                i=a;
                                                j=b;
                                            else
                                                mapa=zalewanie(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                                                [~,i,j]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                            end
                                            czy_byl(i,j)=1;
                                        end
                                        break;
                                end
                            end
                            rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,i,j);
                            title(['Przejazd nr ', num2str(iter)])
                            i=1;
                            j=1;
                            d=1;
                            k=2;
                            kierunek=1;
                            while mapa(i,j)~=0
                                [d,a,b]=gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d);
                                if d==0
                                    break;
                                end
                                i=a;
                                j=b;
                                droga(k,1)=i;
                                droga(k,2)=j;
                                k=k+1;
                            end
                            temp6 = menu('Czy wykonaæ kolejny przejazd skanuj¹cy','Tak','Nie');
                            switch temp6
                                case 1
                                case 2
                                    break;
                            end
                        end
                        
                        [trasa]=sciezka(droga);
                        
                        %To tylko rysuje mapê i trasê, niepotrzebne w robocie
                        rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,1,1);
                        title(['Liczba przejazdow testowych: ', num2str(iter)])
                        for i=2:255
                            if droga(i,1)~=0||droga(i,2)~=0
                                plot([droga(i-1,2)*10-5  droga(i,2)*10-5],[droga(i-1,1)*10-5 droga(i,1)*10-5],'g','LineWidth',2);
                            end
                        end
                        %return;
                    case 2
                        while (1)
                            iter=iter+1;
                            i=1;%pozycja robota-wiersz
                            j=1;%pozycja robota-kolumna
                            [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                            mapa=zalewanie(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);%wstepne rozlanie wody do zupelnie pustego labiryntu
                            
                            while mapa(i,j)~=0
                                
                                [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                                [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                                [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                if l==1
                                    i=a;
                                    j=b;
                                else
                                    mapa=zalewanie(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                                    [~,i,j]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                end
                                czy_byl(i,j)=1;
                            end
                            rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,i,j);
                            title(['Przejazd nr ', num2str(iter)])
                            i=1;
                            j=1;
                            d=1;
                            k=2;
                            while mapa(i,j)~=0
                                [d,a,b]=gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d);
                                if d==0
                                    break;
                                end
                                i=a;
                                j=b;
                                droga(k,1)=i;
                                droga(k,2)=j;
                                k=k+1;
                            end
                            temp7 = menu('Czy wykonaæ kolejny przejazd skanuj¹cy','Tak','Nie');
                            switch temp7
                                case 1
                                case 2
                                    break;
                            end
                        end
                        
                        [trasa]=sciezka(droga);
                        
                        %To tylko rysuje mapê i trasê, niepotrzebne w robocie
                        rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,1,1);
                        title(['Liczba przejazdow testowych: ', num2str(iter)])
                        for i=2:255
                            if droga(i,1)~=0||droga(i,2)~=0
                                plot([droga(i-1,2)*10-5  droga(i,2)*10-5],[droga(i-1,1)*10-5 droga(i,1)*10-5],'g','LineWidth',2);
                            end
                        end
                        %return;
                end
            case 2
                temp8 = menu('Czy chcesz œledziæ ka¿dy ruch robota w labiryncie','Tak','Nie');
                switch temp8
                    case 1
                        while (1)
                            iter=iter+1;
                            i=1;%pozycja robota-wiersz
                            j=1;%pozycja robota-kolumna
                            [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                            mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);%wstepne rozlanie wody do zupelnie pustego labiryntu
                            
                            while mapa(i,j)~=0
                                
                                [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo, dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                                [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                                [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                if l==1
                                    i=a;
                                    j=b;
                                else
                                    mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                                    [~,i,j]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                end
                                czy_byl(i,j)=1;
                                rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,i,j);
                                temp9 = menu('Czy wykonaæ kolejny ruch','Tak','Dokoñcz automatycznie');
                                switch temp9
                                    case 1
                                    case 2
                                        while mapa(i,j)~=0
                                            
                                            [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                                            [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                                            [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                            if l==1
                                                i=a;
                                                j=b;
                                            else
                                                mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                                                [~,i,j]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                            end
                                            czy_byl(i,j)=1;
                                        end
                                        break;
                                end
                            end
                            rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,i,j);
                            title(['Przejazd nr ', num2str(iter)])
                            i=1;
                            j=1;
                            d=1;
                            k=2;
                            while mapa(i,j)~=0
                                [d,a,b]=gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d);
                                if d==0
                                    break;
                                end
                                i=a;
                                j=b;
                                droga(k,1)=i;
                                droga(k,2)=j;
                                k=k+1;
                            end
                            temp6 = menu('Czy wykonaæ kolejny przejazd skanuj¹cy','Tak','Nie');
                            switch temp6
                                case 1
                                case 2
                                    break;
                            end
                        end
                        
                        [trasa]=sciezka(droga);
                        
                        %To tylko rysuje mapê i trasê, niepotrzebne w robocie
                        rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,1,1);
                        title(['Liczba przejazdow testowych: ', num2str(iter)])
                        for i=2:255
                            if droga(i,1)~=0||droga(i,2)~=0
                                plot([droga(i-1,2)*10-5  droga(i,2)*10-5],[droga(i-1,1)*10-5 droga(i,1)*10-5],'g','LineWidth',2);
                            end
                        end
                        %return;
                    case 2
                        while (1)
                            iter=iter+1;
                            i=1;%pozycja robota-wiersz
                            j=1;%pozycja robota-kolumna
                            [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                            mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);%wstepne rozlanie wody do zupelnie pustego labiryntu
                            
                            while mapa(i,j)~=0
                                
                                [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                                [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                                [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                if l==-1
                                    i=a;
                                    j=b;
                                else
                                    mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                                    [~,i,j]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                                end
                                czy_byl(i,j)=1;
                            end
                            rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,i,j);
                            title(['Przejazd nr ', num2str(iter)])
                            i=1;
                            j=1;
                            d=1;
                            k=2;
                            while mapa(i,j)~=0
                                [d,a,b]=gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d);
                                if d==0
                                    break;
                                end
                                i=a;
                                j=b;
                                droga(k,1)=i;
                                droga(k,2)=j;
                                k=k+1;
                            end
                            temp10 = menu('Czy wykonaæ kolejny przejazd skanuj¹cy','Tak','Nie');
                            switch temp10
                                case 1
                                case 2
                                    break;
                            end
                        end
                        
                        [trasa]=sciezka(droga);
                        
                        %To tylko rysuje mapê i trasê, niepotrzebne w robocie
                        rysuj(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa,1,1);
                        title(['Liczba przejazdow testowych: ', num2str(iter)])
                        for i=2:255
                            if droga(i,1)~=0||droga(i,2)~=0
                                plot([droga(i-1,2)*10-5  droga(i,2)*10-5],[droga(i-1,1)*10-5 droga(i,1)*10-5],'g','LineWidth',2);
                            end
                        end
                        %return;
                end
        end
    case 2
        temp3 = menu('Jaki algorytm chcesz wykorzystaæ?','zwyk³e rozlewanie wody','Rozlewanie wody uwzglêdiaj¹ce wiêkszy koszt skrêtu');
        switch temp3
            case 1
                while (1)
                    iter=iter+1;
                    i=1;%pozycja robota-wiersz
                    j=1;%pozycja robota-kolumna
                    [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                    mapa=zalewanie(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);%wstepne rozlanie wody do zupelnie pustego labiryntu
                    
                    while mapa(i,j)~=0
                        
                        [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                        [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                        [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                        if l==1
                            i=a;
                            j=b;
                        else
                            mapa=zalewanie(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                            [~,i,j]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                        end
                        czy_byl(i,j)=1;
                    end
                    i=1;
                    j=1;
                    d=1;
                    k=2;
                    while mapa(i,j)~=0
                        [d,a,b]=gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d);
                        if d==0
                                    break;
                        end
                        i=a;
                        j=b;
                        droga(k,1)=i;
                        droga(k,2)=j;
                        k=k+1;
                    end
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
                %return;
            case 2
                while (1)
                    iter=iter+1;
                    i=1;%pozycja robota-wiersz
                    j=1;%pozycja robota-kolumna
                    [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                    mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);%wstepne rozlanie wody do zupelnie pustego labiryntu
                    
                    while mapa(i,j)~=0
                        
                        [sensor_gora, sensor_prawo, sensor_dol, sensor_lewo]=czujniki(i,j,sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);
                        [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo);
                        [l,a,b]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                        if l==1
                            i=a;
                            j=b;
                        else
                            mapa=zalewanieczasem(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo,mapa);
                            [~,i,j]=czy_i_gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo);
                        end
                        czy_byl(i,j)=1;
                    end
                    i=1;
                    j=1;
                    d=1;
                    k=2;
                    while mapa(i,j)~=0
                        [d,a,b]=gdzie_jechac(i,j,mapa,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo,czy_byl,d);
                        if d==0
                            break;
                        end
                        i=a;
                        j=b;
                        droga(k,1)=i;
                        droga(k,2)=j;
                        k=k+1;
                    end
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
%                 %return;
        end
end

