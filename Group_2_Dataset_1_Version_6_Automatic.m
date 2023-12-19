opengl('save', 'software')
% opengl software
clc;clear all; close all;
format compact;
% skip_operations = input('\nChoice To Perform:\n      1. BMP Image To B-Mode Full MAT Conversion\n      2. Convert Binary Reduced MAT To Contourlet MAT\n      3. Convert Contourlet MAT To Contourlet Binary MAT\n      4. Convert Contourlet MAT To Contourlet Parameter Image MAT\n      5. Convert Contourlet Parameter Image MAT To Contourlet Parameter Binary Image MAT\n      6. Create Multiplied MAT of Contourlet Sub-band MAT & Parameter Image MAT\n      7. Convert Binary Reduced MAT To Curvelet MAT\n      8. Convert Curvelet MAT To Curvelet Binary MAT\n      9. Convert Curvelet MAT To Curvelet Parameter Image MAT\n      10. Convert Curvelet Parameter Image MAT To Curvelet Parameter Binary Image MAT\n      11. Create Multiplied MAT of Curvelet Sub-band MAT & Parameter Image MAT\nEnter Your Choices in Matrix Form:  '); 
skip_operations = [1];
pwd;
CurrentFolder=pwd;

for image_serial=1     %  1 ~ 250
    Now_Consider = ['{ Patient No. = us',num2str(image_serial),' }']
    fne = ['us',num2str(image_serial),'.xlsx'];
    dre = [CurrentFolder,'\Patient Outputs\DATA_Set_1\xlsx_files\'];
    if image_serial>=1 && image_serial<=100
        pid=imread([CurrentFolder,'\Imamul_Dataset\DATA_Set_1\us-dataset\originals\benign\us',num2str(image_serial),'.bmp']);
    elseif image_serial>=101 && image_serial<=250    
        pid=imread([CurrentFolder,'\Imamul_Dataset\DATA_Set_1\us-dataset\originals\malignant\us',num2str(image_serial),'.bmp']);
    end
    patient_ID=['us',num2str(image_serial)];
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Original\']);
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\xlsx_files']);
    mkdir([CurrentFolder,'\MAT files\DATA_Set_1']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Original\'];

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
	mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Denoise']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Denoise\'];
%     net = denoisingNetwork('DnCNN'); %pre trained CNN
%     j = denoiseImage(pid, net); 

%     j=wdenoise2(pid,6); % Wavelet

%     j=imgaussfilt(pid,1); % Gaussian
%     j = wiener2(pid,[3,3]); %weiner
%     j = ordfilt2(pid,25,true(5)); %order-statistic filtering
%     j=medfilt2(pid,[5,5]);
if image_serial==30 || image_serial==34 || image_serial==39 || image_serial==48 || image_serial==66 || image_serial== 176
      H = fspecial('log',10); 
      j= imfilter(pid,H,'replicate');
end
if (image_serial>=22 && image_serial<=25) || (image_serial>=27 && image_serial<=29) || (image_serial>=36 && image_serial<=38) || (image_serial>=40 && image_serial<=47) || image_serial==49 || image_serial==50 || image_serial==54 || image_serial==55 || (image_serial>=67 && image_serial<=70) || (image_serial>=72 && image_serial<=74) || image_serial==76 || image_serial==77 || (image_serial>=86 && image_serial<=88) || image_serial==92 || (image_serial>=94 && image_serial<=100) || image_serial==115 || (image_serial>=136 && image_serial<=140) || image_serial==171 || (image_serial>=173 && image_serial<=175) || image_serial==177 || image_serial==179 || image_serial==180 || (image_serial>=186 && image_serial<=189) || (image_serial>=221 && image_serial<=225)
      H = fspecial('log',20); 
      j= imfilter(pid,H,'replicate');
end
if image_serial==20 || (image_serial>=31 && image_serial<=33) || image_serial==35 || (image_serial>=51 && image_serial<=53) || (image_serial>=56 && image_serial<=65) || image_serial==71 || image_serial==75 || (image_serial>=78 && image_serial<=85) || (image_serial>=89 && image_serial<=91) || image_serial==93 || (image_serial>=102 && image_serial<=114) || (image_serial>=121 && image_serial<=130) || (image_serial>=141 && image_serial<=162) || (image_serial>=166 && image_serial<=170) || image_serial==172 || image_serial==178 || (image_serial>=181 && image_serial<=185) || (image_serial>=190 && image_serial<=220) || (image_serial>=226 && image_serial<=229) || (image_serial>=231 && image_serial<=250)
      H = fspecial('log',50); 
      j= imfilter(pid,H,'replicate');
end
if image_serial==101 || (image_serial>=116 && image_serial<=120) || (image_serial>=131 && image_serial<=135) || (image_serial>=163 && image_serial<=165) || image_serial==230
      H = fspecial('log',100); 
      j= imfilter(pid,H,'replicate');
end
if (image_serial>=16 && image_serial<=19)
      H = fspecial('log',200);
      j= imfilter(pid,H,'replicate');
end
if (image_serial>=6 && image_serial<=15) || image_serial==21
      H = fspecial('log',300); 
      j= imfilter(pid,H,'replicate');
end
if (image_serial>=1 && image_serial<=5) || image_serial==26
      H = fspecial('log',500); 
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
    B_Mode_patient_ID = [CurrentFolder,'\MAT files\DATA_Set_1\',patient_ID,'-B-Mode-Denoised'];
    save(B_Mode_patient_ID,'B_Mode_Denoised')

%-----------------------Save binaryImage & its MAT---------------------------------%
    disp('1. Now Saving GrayImage MAT to BinaryImage MAT')
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Binary']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Binary\'];

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
    binaryImage_patient_ID = [CurrentFolder,'\MAT files\DATA_Set_1\',patient_ID,'-Binary'];
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
