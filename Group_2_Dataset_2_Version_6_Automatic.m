opengl('save', 'software')
% opengl software
clc;clear all; close all;
format compact;
% skip_operations = input('\nChoice To Perform:\n      1. BMP Image To B-Mode Full MAT Conversion\n      2. Convert Binary Reduced MAT To Contourlet MAT\n      3. Convert Contourlet MAT To Contourlet Binary MAT\n      4. Convert Contourlet MAT To Contourlet Parameter Image MAT\n      5. Convert Contourlet Parameter Image MAT To Contourlet Parameter Binary Image MAT\n      6. Create Multiplied MAT of Contourlet Sub-band MAT & Parameter Image MAT\n      7. Convert Binary Reduced MAT To Curvelet MAT\n      8. Convert Curvelet MAT To Curvelet Binary MAT\n      9. Convert Curvelet MAT To Curvelet Parameter Image MAT\n      10. Convert Curvelet Parameter Image MAT To Curvelet Parameter Binary Image MAT\n      11. Create Multiplied MAT of Curvelet Sub-band MAT & Parameter Image MAT\nEnter Your Choices in Matrix Form:  '); 
skip_operations = [1];
pwd;
CurrentFolder=pwd;

for image_serial=163    % 1 ~ 163
    Now_Consider = ['{ Patient No. = us',num2str(image_serial),' }']
    fne = ['us',num2str(image_serial),'.xlsx'];
    dre = [CurrentFolder,'\Patient Outputs\DATA_Set_2\xlsx_files\'];
    if image_serial>=1 && image_serial<=100
        pid=imread([CurrentFolder,'\Imamul_Dataset\DATA_Set_2\BUS\BUS\original\us',num2str(image_serial),'.png']);
    elseif image_serial>=101 && image_serial<=250    
        pid=imread([CurrentFolder,'\Imamul_Dataset\DATA_Set_2\BUS\BUS\original\us',num2str(image_serial),'.png']);
    end
    patient_ID=['us',num2str(image_serial)];
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_2\',patient_ID,'\Original\']);
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_2\xlsx_files']);
    mkdir([CurrentFolder,'\MAT files\DATA_Set_2']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_2\',patient_ID,'\Original\'];

%% ----------------- 1. BMP Image To MAT Conversion---------------------- %%
for i=1:length(skip_operations)
    if skip_operations(i)==1
        skip1=0; % 
        break;
    else
        skip1=1;
    end
end
if skip1==0

    figure(1)
    image(pid)
%     title('Original Image Read')
    set(gcf,'PaperPositionMode','auto')
    A=gcf;
    saveas(A,[save2folder '\' [patient_ID,'-Original']], 'jpg');
    saveas(A,[save2folder '\' [patient_ID,'-Original']], 'fig');
    clear A
	
%---------------------Denoise and Save the filtered B-Mode (Reduced) Image------------------------%
    disp('1. Now Denoising BMP/B-Mode Image')
	mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_2\',patient_ID,'\Denoise']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_2\',patient_ID,'\Denoise\'];
%     net = denoisingNetwork('DnCNN'); %pre trained CNN
%     j = denoiseImage(pid, net); 
%     j=wdenoise2(pid,6); % Wavelet
%     j=imgaussfilt(pid,1); % Gaussian
%     j = wiener2(pid,[3,3]); %weiner
%     j = ordfilt2(pid,25,true(5)); %order-statistic filtering
%     j=medfilt2(pid,[5,5]);

if image_serial==134
      H = fspecial('log',10); 
      j= imfilter(pid,H,'replicate');
end
if image_serial==3 || image_serial==12 || image_serial==17 || image_serial==20 || image_serial==23 || image_serial==33 || image_serial==35 || image_serial==38 || image_serial==42 || image_serial==83 || image_serial==97 || image_serial==113 || image_serial==116 || image_serial==117 || image_serial==123 || image_serial==129
      H = fspecial('log',20); 
      j= imfilter(pid,H,'replicate');
end
if image_serial==2 || image_serial==4 || image_serial==9 || image_serial==10 || image_serial==15 || image_serial==48 || image_serial==90 || image_serial==99 || image_serial==106 || image_serial==110 || image_serial==120 || image_serial==121 || image_serial==127 || image_serial==130
      H = fspecial('log',30); 
      j= imfilter(pid,H,'replicate');
end
if image_serial==1 || image_serial==5 || image_serial==13 || image_serial==24 || image_serial==34 || image_serial==37 || image_serial==40 || image_serial==43 || image_serial==47 || image_serial==60 || image_serial==64 || image_serial==71 || image_serial==80 || image_serial==81 || image_serial==87 || image_serial==91 || image_serial==93 || image_serial==94 || image_serial==98 || image_serial==100 || image_serial==101 || image_serial==103 || image_serial==109 || image_serial==111 || image_serial==112 || image_serial==115 || image_serial==126 || image_serial==146 || image_serial==157 || image_serial==160
      H = fspecial('log',40); 
      j= imfilter(pid,H,'replicate');
end
if image_serial==6 || image_serial==7 || image_serial==19 || image_serial==21 || image_serial==26 || image_serial==44 || image_serial==46 || image_serial==50 || image_serial==52 || image_serial==72 || image_serial==79 || image_serial==89 || image_serial==92 || image_serial==96 || image_serial==114 || image_serial==118 || image_serial==122 || image_serial==128 || image_serial==131 || image_serial==145 || image_serial==153 || image_serial==162
      H = fspecial('log',50);
      j= imfilter(pid,H,'replicate');
end
if image_serial==11 || image_serial==16 || image_serial==22 || image_serial==39 || image_serial==51 || image_serial==58 || image_serial==61 || image_serial==65 || image_serial==67 || image_serial==77 || image_serial==82 || image_serial==105 || image_serial==107 || image_serial==119 || image_serial==124 || image_serial==125 || image_serial==133 || image_serial==139 || image_serial==149 || image_serial==151
      H = fspecial('log',60); 
      j= imfilter(pid,H,'replicate');
end
if image_serial==25 || image_serial==63 || image_serial==69 || image_serial==132 || image_serial==136
      H = fspecial('log',70);
      j= imfilter(pid,H,'replicate');
end
if image_serial==8 || image_serial==32 || image_serial==36 || image_serial==53 || image_serial==55 || image_serial==62 || image_serial==76 || image_serial==95 || image_serial==104 || image_serial==138 || image_serial==140 || image_serial==154 || image_serial==156
      H = fspecial('log',80);
      j= imfilter(pid,H,'replicate');
end
if image_serial==56 || image_serial==86
      H = fspecial('log',90);
      j= imfilter(pid,H,'replicate');
end
if image_serial==27 || image_serial==31 || image_serial==49 || image_serial==54 || image_serial==57 || image_serial==68 || image_serial==70 || image_serial==75 || image_serial==78 || image_serial==84 || image_serial==85 || image_serial==88 || image_serial==102 || image_serial==108 || image_serial==137 || image_serial==144 || image_serial==152 || image_serial==159 || image_serial==161 || image_serial==163
      H = fspecial('log',100);
      j= imfilter(pid,H,'replicate');
end
if image_serial==41 || image_serial==59 || image_serial==66 || image_serial==135 || image_serial==141 || image_serial==142 || image_serial==148 || image_serial==155 || image_serial==158
      H = fspecial('log',150);
      j= imfilter(pid,H,'replicate');
end
if image_serial==14 || image_serial==18 || (image_serial>=28 && image_serial<=30) || image_serial==45 || image_serial==74 || image_serial==143 || image_serial==147
      H = fspecial('log',200);
      j= imfilter(pid,H,'replicate');
end
if image_serial==73 || image_serial==150
      H = fspecial('log',250);
      j= imfilter(pid,H,'replicate');
end

    figure(2)
    imshow(j)  
    set(gcf,'PaperPositionMode','auto')
    A=gcf;
    saveas(A,[save2folder '\' [patient_ID,'-Denoised']], 'jpg');
    saveas(A,[save2folder '\' [patient_ID,'-Denoised']], 'fig'); 
    clear A
%---------------------------Save B-Mode MAT----------------------------------%
    B_Mode_Denoised=j;
    B_Mode_patient_ID = [CurrentFolder,'\MAT files\DATA_Set_2\',patient_ID,'-B-Mode-Denoised'];
    save(B_Mode_patient_ID,'B_Mode_Denoised')

%-----------------------Save binaryImage & its MAT---------------------------------%
    disp('1. Now Saving GrayImage MAT to BinaryImage MAT')
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_2\',patient_ID,'\Binary']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_2\',patient_ID,'\Binary\'];

    binaryImage = bwareafilt(~B_Mode_Denoised, 1);
    binaryImage = imfill(binaryImage, 'holes');
    figure(3)
    imagesc(binaryImage);
    imshow(binaryImage);
    imagesc(binaryImage);
%     title('Binary of B-Mode full Image')
    set(gcf,'PaperPositionMode','auto')
    A=gcf;
    saveas(A,[save2folder '\' [patient_ID,'-Binary-reduced']], 'jpg');
    saveas(A,[save2folder '\' [patient_ID,'-Binary-reduced']], 'fig');
    clear A
    binaryImage_patient_ID = [CurrentFolder,'\MAT files\DATA_Set_2\',patient_ID,'-Binary'];
    save(binaryImage_patient_ID,'binaryImage')
%     close all
%---------------- Save Lesion Rotund Area From Binary MAT------------------%
	disp('1. Now Saving Auto Lesion Rotund Area in xls file from Binary MAT')
	load (binaryImage_patient_ID)
	binaryImage_y=[]; binaryImage_x=[];
	ss=size(binaryImage);
	ss1=ss(1);
	ss2=ss(2);
		for jj=1:ss1
			for kj=1:ss2
				if binaryImage(jj,kj)==1
					binaryImage_y=[binaryImage_y jj]; %  These coefficient index values will be used for features B-Mode/Binary
                    binaryImage_x=[binaryImage_x kj]; %  These coefficient index values will be used for features B-Mode/Binary 
                end
            end
        end
        for i=1:length(binaryImage_y)
            Binary_Auto_Rotund_Lesion(i,1)=binaryImage_x(1,i);
            Binary_Auto_Rotund_Lesion(i,2)=binaryImage_y(1,i);
        end
	Binary_Auto_Rotund_Lesion;
    xlswrite([dre,fne],{'Binary Lesion Rotund Auto'},'Sheet1',['A1']);
    xlswrite([dre,fne],{[patient_ID,'-X']},'Sheet1','A2');
    xlswrite([dre,fne],{[patient_ID,'-Y']},'Sheet1','B2');
    xlswrite([dre,fne],Binary_Auto_Rotund_Lesion,'Sheet1','A4');    
end

%% ------------------------------------------------------------------------------- %%



end
%% ---------------------------------------X--------------------------------------- %%
