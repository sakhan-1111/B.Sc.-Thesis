opengl('save', 'software')
% opengl software
clc;clear all; close all;
format compact;
% skip_operations = input('\nChoice To Perform:\n      1. BMP Image To B-Mode Full MAT Conversion\n      2. Convert Binary Reduced MAT To Contourlet MAT\n      3. Convert Contourlet MAT To Contourlet Binary MAT\n      4. Convert Contourlet MAT To Contourlet Parameter Image MAT\n      5. Convert Contourlet Parameter Image MAT To Contourlet Parameter Binary Image MAT\n      6. Create Multiplied MAT of Contourlet Sub-band MAT & Parameter Image MAT\n      7. Convert Binary Reduced MAT To Curvelet MAT\n      8. Convert Curvelet MAT To Curvelet Binary MAT\n      9. Convert Curvelet MAT To Curvelet Parameter Image MAT\n      10. Convert Curvelet Parameter Image MAT To Curvelet Parameter Binary Image MAT\n      11. Create Multiplied MAT of Curvelet Sub-band MAT & Parameter Image MAT\nEnter Your Choices in Matrix Form:  '); 
skip_operations = [1];
pwd;
CurrentFolder=pwd;

for image_serial=250      %  1 ~ 250
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
	
%% ------------ Select Lesion Region From MAT If Needed--------------- %%
   disp('1. Now Select Lesion Region From MAT Image')

    f=2
    while f==2
        f = input('Is Manual Selection Needed?:\n    1.Yes\n    2.No\n  Enter your choice:  ');
        if f==1
                s=2
                while s==2
                figure(2)
                imagesc(pid);
                imshow(pid);
                imagesc(pid);
                title('B-Mode Image')

                hold on
                imfreehand
                pause

                s = input('Exactly Done?:\n    1.Yes\n    2.No\n  Enter your choice:  ');
                if s==1
                    clear g1
                    g1=input('Enter The Region of Lesion: ');
                    break
                end
                % close all
                end
				
	%----Filtering of Redundant Coordinates and Convert Float to Integer------%

                Region_Lesion=g1;
                v=round(Region_Lesion);
                maximum=max(v);
                minimum=min(v);
                width=maximum(1)-minimum(1);
                height=maximum(2)-minimum(2);
                size_ellipse=size(v);
                f=round(Region_Lesion);
                ep=size(Region_Lesion);

                match_1=f(1,1);match_2=f(1,2);match_3=[f(1,1) f(1,2)];
                for i=1:ep(1)
                    if f(i,1)~=match_1 || f(i,2)~=match_2
                        match_3(i,1)=f(i,1);
                        match_3(i,2)=f(i,2);
                        match_1=f(i,1);
                        match_2=f(i,2);
                    end
                end
                match_3;
                ep=size(match_3);
                match_4=[];match_5=[];
                for i=1:ep(1)
                    if match_3(i,1)~=0 || match_3(i,2)~=0
                        match_4=[match_4 match_3(i,1)];
                        match_5=[match_5 match_3(i,2)];
                    end
                end
                match_4;
                match_5;
                ep=size(match_4);match_6=[];
                for i=1:ep(2)
                    match_6(i,1)=match_4(1,i);
                    match_6(i,2)=match_5(1,i);
                end
                match_6;
                ep=size(match_6);

                match_7=[];match_8=[];match_9=[];match_10=[];

                for j=1:ep(1)
                    count_1=0;count_2=0;
                    for i=1:ep(1)
                        if match_6(j,1)==match_6(i,1) & match_6(j,2)==match_6(i,2)
                          count_1=count_1+1;
                        end
                    end
                    for i=1:length(match_7)
                        if match_6(j,1)==match_7(1,i) & match_6(j,2)==match_8(1,i)
                          count_2=count_2+1;
                        end
                    end
                        if count_1==1 & count_2==0
                          match_7=[match_7 match_6(j,1)];
                          match_8=[match_8 match_6(j,2)];
                        elseif count_1>1 & count_2==0
                          match_7=[match_7 match_6(j,1)];
                          match_8=[match_8 match_6(j,2)];
                        elseif count_1>1 & count_2>0
                          match_9=[match_9 match_6(j,1)];
                          match_10=[match_10 match_6(j,2)];
                        end

                end
                x_co_ordinate_Lesion=match_7;
                y_co_ordinate_Lesion=match_8;
                match_9;
                match_10;
                clear ep
                ep=size(match_7);match_11_Lesion=[];
                for i=1:ep(2)
                    match_11_Lesion(i,1)=match_7(1,i);
                    match_11_Lesion(i,2)=match_8(1,i);
                end
                match_11_Lesion;
				
%----------------------Save Filtered Lesion Regions in xls file------------------------%
disp('1. Now Saving Filtered Lesion Regions in xls file')
xlswrite([dre,fne],{'Filtered Lesion Regions'},'Sheet1','A1');
xlswrite([dre,fne],{[patient_ID,'-X']},'Sheet1','A2');
xlswrite([dre,fne],{[patient_ID,'-Y']},'Sheet1','B2');
xlswrite([dre,fne],match_11_Lesion,'Sheet1','A4');

%----------------------------Reshaping B-Mode Image--------------------------------%
                for i=1:length(match_11_Lesion)
                    Region_Lesion_x(i)=match_11_Lesion(i,1);
                    Region_Lesion_y(i)=match_11_Lesion(i,2);
                end

                pk2=13;
                MAT_File_Size_B_Mode=size(pid);
                if (min(Region_Lesion_x)-pk2)>0
                    Min_x=min(Region_Lesion_x)-pk2;
                else
                    Min_x=min(Region_Lesion_x)-(min(Region_Lesion_x)-6);
                end
                if (max(Region_Lesion_x)+pk2)<MAT_File_Size_B_Mode(1,2)
                    Max_x=max(Region_Lesion_x)+pk2;
                else
                    Max_x=max(Region_Lesion_x)+((MAT_File_Size_B_Mode(1,2)-max(Region_Lesion_x))-6);
                end
                if (min(Region_Lesion_y)-pk2)>0 
                    Min_y=min(Region_Lesion_y)-pk2;
                else    
                    Min_y=min(Region_Lesion_y)-(min(Region_Lesion_y)-6);
                end
                if (max(Region_Lesion_y)+pk2)<MAT_File_Size_B_Mode(1,1)
                    Max_y=max(Region_Lesion_y)+pk2;
                else
                    Max_y=max(Region_Lesion_y)+((MAT_File_Size_B_Mode(1,1)-max(Region_Lesion_y))-6);
                end

                B_Mode_image_Reload=pid;
				
%--------------------------Reducing B-Mode Image-----------------------------%
                clear MAT_File_Size;
                MAT_File_Size=size(B_Mode_image_Reload);
                    for ss=MAT_File_Size(1,1):-1:Max_y
                        B_Mode_image_Reload(ss,:)=[];
                    end
                    MAT_File_Size=size(B_Mode_image_Reload);
                    for ss=Min_y:-1:1
                        B_Mode_image_Reload(ss,:)=[];
                    end
                    MAT_File_Size=size(B_Mode_image_Reload);
                    for ss=MAT_File_Size(1,2):-1:Max_x
                        B_Mode_image_Reload(:,ss)=[];
                    end
                    MAT_File_Size=size(B_Mode_image_Reload);
                    for ss=Min_x:-1:1
                        B_Mode_image_Reload(:,ss)=[];
                    end
                    MAT_File_Size=size(B_Mode_image_Reload);
                % disp('Binary Image Reload Size')
                sz=size(B_Mode_image_Reload);
                mat_size_1=sz(1);
                mat_size_2=sz(2);	
%---------------------Save B-Mode (Reduced) Image & MAT ------------------------%
                disp('1. Now Saving B-Mode Full MAT to B-Mode Reduced MAT')
                mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\B-Mode']);
                save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\B-Mode\'];

                B_Mode = B_Mode_image_Reload;
                figure(3)
                imagesc(B_Mode);
                imshow(B_Mode);
                imagesc(B_Mode);
%                 title('B-Mode Reduced Image (ROC)')
                set(gcf,'PaperPositionMode','auto')
                A=gcf;
                saveas(A,[save2folder '\' [patient_ID,'-Reduced-B-Mode-ROI']], 'jpg');
                saveas(A,[save2folder '\' [patient_ID,'-Reduced-B-Mode-ROI']], 'fig');
                clear A
                B_Mode_patient_ID = [CurrentFolder,'\MAT files\DATA_Set_1\',patient_ID,'-B-Mode'];
                save(B_Mode_patient_ID,'B_Mode')
				
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
      j= imfilter(B_Mode,H,'replicate');
end
if (image_serial>=22 && image_serial<=25) || (image_serial>=27 && image_serial<=29) || (image_serial>=36 && image_serial<=38) || (image_serial>=40 && image_serial<=47) || image_serial==49 || image_serial==50 || image_serial==54 || image_serial==55 || (image_serial>=67 && image_serial<=70) || (image_serial>=72 && image_serial<=74) || image_serial==76 || image_serial==77 || (image_serial>=86 && image_serial<=88) || image_serial==92 || (image_serial>=94 && image_serial<=100) || image_serial==115 || (image_serial>=136 && image_serial<=140) || image_serial==171 || (image_serial>=173 && image_serial<=175) || image_serial==177 || image_serial==179 || image_serial==180 || (image_serial>=186 && image_serial<=189) || (image_serial>=221 && image_serial<=225)
      H = fspecial('log',20); 
      j= imfilter(B_Mode,H,'replicate');
end
if image_serial==20 || (image_serial>=31 && image_serial<=33) || image_serial==35 || (image_serial>=51 && image_serial<=53) || (image_serial>=56 && image_serial<=65) || image_serial==71 || image_serial==75 || (image_serial>=78 && image_serial<=85) || (image_serial>=89 && image_serial<=91) || image_serial==93 || (image_serial>=102 && image_serial<=114) || (image_serial>=121 && image_serial<=130) || (image_serial>=141 && image_serial<=162) || (image_serial>=166 && image_serial<=170) || image_serial==172 || image_serial==178 || (image_serial>=181 && image_serial<=185) || (image_serial>=190 && image_serial<=220) || (image_serial>=226 && image_serial<=229) || (image_serial>=231 && image_serial<=250)
      H = fspecial('log',50); 
      j= imfilter(B_Mode,H,'replicate');
end
if image_serial==101 || (image_serial>=116 && image_serial<=120) || (image_serial>=131 && image_serial<=135) || (image_serial>=163 && image_serial<=165) || image_serial==230
      H = fspecial('log',100); 
      j= imfilter(B_Mode,H,'replicate');
end
if (image_serial>=16 && image_serial<=19)
      H = fspecial('log',200);
      j= imfilter(B_Mode,H,'replicate');
end
if (image_serial>=6 && image_serial<=15) || image_serial==21
      H = fspecial('log',300); 
      j= imfilter(B_Mode,H,'replicate');
end
if (image_serial>=1 && image_serial<=5) || image_serial==26
      H = fspecial('log',500); 
      j= imfilter(B_Mode,H,'replicate');
end

    figure(4)
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
    figure(5)
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
    
end

%% ------------------------------------------------------------------------------- %%



end
%% ---------------------------------------X--------------------------------------- %%







end
end