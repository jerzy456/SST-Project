function [sensor_gora,sensor_prawo,sensor_dol,sensor_lewo] = czujniki(i,j,sensor_gora,sensor_prawo,sensor_dol,sensor_lewo)

load('labirynt_1.mat');
%oad('labirynt_2.mat');

[dsensor_gora,dsensor_prawo,dsensor_dol,dsensor_lewo] = obrobkaSensorow(dsensor_gora, dsensor_prawo, dsensor_dol, dsensor_lewo);

sensor_gora(i,j)=dsensor_gora(i,j);
sensor_prawo(i,j)=dsensor_prawo(i,j);
sensor_dol(i,j)=dsensor_dol(i,j);
sensor_lewo(i,j)=dsensor_lewo(i,j);


end