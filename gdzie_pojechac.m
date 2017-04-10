function [akcja,kierunek] = gdzie_pojechac(kierunek,a,b,i,j)

polnoc=1;
wschod=2;
poludnie=3;
zachod=4;
switch kierunek
        case polnoc
            if a>i
                akcja=1;
            elseif a<i
                akcja=3; %1-przod, 2-prawo, 3-zawroc,4-lewo
                kierunek=poludnie;
            elseif b>j
                akcja=2;
                kierunek=wschod;
            else
                akcja=4;
                kierunek=zachod;
            end
            
            case wschod
            if a>i
                akcja=4;
                kierunek=polnoc;
            elseif a<i
                akcja=2;  %1-przod, 2-prawo, 3-zawroc,4-lewo
                kierunek=poludnie;
            elseif b>j
                akcja=1;
            else
                akcja=3;
                kierunek=zachod;
            end
            
            case poludnie
            if a>i
                akcja=3;
                kierunek=polnoc;
            elseif a<i
                akcja=1;  %1-przod, 2-prawo, 3-zawroc,4-lewo
            elseif b>j
                akcja=4;
                kierunek=wschod;
            else
                akcja=2;
                kierunek=zachod;
            end
            
            case zachod
            if a>i
                akcja=2;
                kierunek=polnoc;
            elseif a<i
                akcja=4;  %1-przod, 2-prawo, 3-zawroc,4-lewo
                kierunek=poludnie;
            elseif b>j
                akcja=3;
                kierunek=wschod;
            else
                akcja=1;
            end

end
end