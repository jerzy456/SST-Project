function [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = obrobkaSensorow_2(sensor_gora, sensor_prawo, sensor_dol, sensor_lewo)

for i=1:16
   for j=1:16
       if i~=16
           if sensor_gora(i,j)==1
               sensor_dol(i+1,j)=1;
           end
           if sensor_gora(i,j)==0
               sensor_dol(i+1,j)=0;
           end
       end
       if j~=16
           if sensor_prawo(i,j)==1
               sensor_lewo(i,j+1)=1;
           end
           if sensor_prawo(i,j)==0
               sensor_lewo(i,j+1)=0;
           end
       end
       if i~=1
           if sensor_dol(i,j)==1
               sensor_gora(i-1,j)=1;
           end
           if sensor_dol(i,j)==0
               sensor_gora(i-1,j)=0;
           end
       end
       if j~=1
           if sensor_lewo(i,j)==1
               sensor_prawo(i,j-1)=1;
           end
           if sensor_lewo(i,j)==0
               sensor_prawo(i,j-1)=0;
           end
       end
   end
end

end