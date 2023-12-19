opengl('save', 'software')
% opengl software
clc;clear all; close all;
format compact;
% skip_operations = input('\nChoice To Perform:\n      1. BMP Image To B-Mode Full MAT Conversion\n      2. Convert Binary Reduced MAT To Contourlet MAT\n      3. Convert Contourlet MAT To Contourlet Binary MAT\n      4. Convert Contourlet MAT To Contourlet Parameter Image MAT\n      5. Convert Contourlet Parameter Image MAT To Contourlet Parameter Binary Image MAT\n      6. Create Multiplied MAT of Contourlet Sub-band MAT & Parameter Image MAT\n      7. Convert Binary Reduced MAT To Curvelet MAT\n      8. Convert Curvelet MAT To Curvelet Binary MAT\n      9. Convert Curvelet MAT To Curvelet Parameter Image MAT\n      10. Convert Curvelet Parameter Image MAT To Curvelet Parameter Binary Image MAT\n      11. Create Multiplied MAT of Curvelet Sub-band MAT & Parameter Image MAT\nEnter Your Choices in Matrix Form:  '); 
skip_operations = [1];
pwd;
CurrentFolder=pwd;

for image_serial=1      %  1 ~ 250
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
    disp('1. Now Denoising BMP/B-Mode Image')

%---------------------Denoise and Save the filtered B-Mode Image------------------------%
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Denoise']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Denoise\'];
    j=medfilt2(pid,[5,5]);
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

    %------------------------Save grayImage & its MAT-------------------------------%
    disp('1. Now Saving B-Mode Denoised MAT to GrayImage MAT')
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\GrayImage']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\GrayImage\'];

    thresholdLevel=graythresh(B_Mode_Denoised);
    grayImage = imbinarize(B_Mode_Denoised,thresholdLevel);
    figure(3)
    imagesc(grayImage);
    imshow(grayImage);
    imagesc(grayImage);
%     title('Gray of B-Mode full Image')
    set(gcf,'PaperPositionMode','auto')
    A=gcf;
    saveas(A,[save2folder '\' [patient_ID,'-Gray-full']], 'jpg');
    saveas(A,[save2folder '\' [patient_ID,'-Gray-full']], 'fig');
    clear A
    grayImage_patient_ID = [CurrentFolder,'\MAT files\DATA_Set_1\',patient_ID,'-GrayImage'];
    save(grayImage_patient_ID,'grayImage')

    %-----------------------Save binaryImage & its MAT---------------------------------%
    disp('1. Now Saving GrayImage MAT to BinaryImage MAT')
    mkdir([CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Binary']);
    save2folder=[CurrentFolder,'\Patient Outputs\DATA_Set_1\',patient_ID,'\Binary\'];

    binaryImage = bwareafilt(~grayImage, 1);
    binaryImage = imfill(binaryImage, 'holes');
    figure(4)
    imagesc(binaryImage);
    imshow(binaryImage);
    imagesc(binaryImage);
%     title('Binary of B-Mode full Image')
    set(gcf,'PaperPositionMode','auto')
    A=gcf;
    saveas(A,[save2folder '\' [patient_ID,'-Binary-full']], 'jpg');
    saveas(A,[save2folder '\' [patient_ID,'-Binary-full']], 'fig');
    clear A
    binaryImage_patient_ID = [CurrentFolder,'\MAT files\DATA_Set_1\',patient_ID,'-Binary'];
    save(binaryImage_patient_ID,'binaryImage')
%     close all
    
end

%% ------------------------------------------------------------------------------- %%



end
%% ---------------------------------------X--------------------------------------- %%







