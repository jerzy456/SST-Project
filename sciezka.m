function [sciezka] = sciezka(tablica)

polnoc=1;
wschod=2;
poludnie=3;
zachod=4;

k=polnoc;
i=1;

while tablica(i,1)~=0
    switch k
        case polnoc
            if tablica(i+1,2)>tablica(i,2)
                k=wschod;
                sciezka(i)=2;
                i=i+1;
                
            elseif tablica(i+1,2)<tablica(i,2)
                k=zachod;
                sciezka(i)=3;
                i=i+1;
            else
                sciezka(i)=1;
                i=i+1;
            end
            
        case wschod
            if tablica(i+1,1)>tablica(i,1)
                k=polnoc;
                sciezka(i)=3;
                i=i+1;
            elseif tablica(i+1,1)<tablica(i,1)
                k=poludnie;
                sciezka(i)=2;
                i=i+1;
            else
                sciezka(i)=1;
                i=i+1;
            end
            
            
        case poludnie
            if tablica(i+1,2)>tablica(i,2)
                k=wschod;
                sciezka(i)=3;
                i=i+1;
            elseif tablica(i+1,2)<tablica(i,2)
                k=zachod;
                sciezka(i)=2;
                i=i+1;
            else
                sciezka(i)=1;
                i=i+1;
            end
            
            
        case zachod
            if tablica(i+1,1)>tablica(i,1)
                k=polnoc;
                sciezka(i)=2;
                i=i+1;
            elseif tablica(i+1,1)<tablica(i,1)
                k=poludnie;
                sciezka(i)=3;
                i=i+1;
            else
                sciezka(i)=1;
                i=i+1;
            end
    end
    
end
end