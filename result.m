clc
close all
clear
%%
reports = dir('reports');
reports = reports(3:end);
ilabels = {'TID-1','TID-3','TID-5','TID-7','TID-8','TID-17','TID-19','TID-23',...
    'Baboon','Grass','USC-SIPI-1','USC-SIPI-2','USC-SIPI-3','USC-SIPI-4',...
    'USC-SIPI-5','USC-SIPI-6'}; % image labels
imgs = [1 3 5 7 8 17 19 23 25:32]; % reference images
sigma = [3 5 10 15 20 25 30]; % noise standard deviation 
filters = {'DCTF','BM3D'};
%%
% Prediction of IPHVS (improvement of PSNR-HVS-M metric)
load('data/PSNRHVSM_BM3D');
load('data/PSNRHVSM_DCTF');
load('data/PSNRHVSM_noisy');
load('data/M_awgn'); % P_0.5sigma
IPHVS_BM3D = PSNRHVSM_BM3D - PSNRHVSM_noisy;
IPHVS_DCTF = PSNRHVSM_DCTF - PSNRHVSM_noisy;

fexp = @(b,x) b(1)*exp(b(2)*x);
mdl_DCTF = fitnlm(M_awgn(:),IPHVS_DCTF(:),fexp,[0 0]);
mdl_BM3D = fitnlm(M_awgn(:),IPHVS_BM3D(:),fexp,[0 0]);
% For more details see the following papers:
%		
%		1) S. Abramov, S. Krivenko, A. Roenko, V. Lukin, I. Djurovió, M. Chobanu, "Prediction of filtering efficiency 
%		for DCT-based image denoising", 2013 2nd Mediterranean Conference on Embedded Computing (MECO),
%		pp. 97-100, June 2013. 
%		2) O. Rubel, V. Lukin, "An Improved Prediction of DCT-Based Filters Efficiency Using Regression Analysis"
%		in Information and Telecommunication Sciences, Kiev, Ukraine:, vol. 5, no. 1, pp. 30-41, 2014.
%		3) O. Rubel, V. Lukin, S. Abramov, B. Vozel, O. Pogrebnyak and K. Egiazarian, "Is Texture Denoising Efficiency
%		Predictable?", International Journal of Pattern Recognition and Artificial Intelligence, 
%		vol. 32, no. 01, p. 32, 2017.

PSNRHVSM = zeros(numel(sigma),numel(imgs),numel(filters));
PSNRHVSM(:,:,1) = IPHVS_DCTF(:,imgs);
PSNRHVSM(:,:,2) = IPHVS_BM3D(:,imgs);
M_awgn = M_awgn(:,imgs); % P_0.5sigma

%%
V = zeros(numel(sigma),numel(imgs),numel(filters),numel(reports));
for i = 1:length(reports)
    fileid = fopen(['reports/' reports(i).name],'r');
    R = textscan(fileid,'%d\t%d\t%d\t%d\t%d');
    for j = 1:numel(R{1})
        V(R{3}(j),R{4}(j),R{2}(j),i) = R{5}(j);
    end
    fclose(fileid);
end
M = mean(V,4); % Probabilities of voting for denoising
NSD = var(V,0,4); % variance of probabilities
%%
M_dctf = M(:,:,1); % Probabilities of voting for denoising for DCT filter
figure;
plot(sigma,M_dctf,'--o');
xlabel('\sigma');
ylabel('Probability of voting for denoising');
title('DCTF');
%%	
M_bm3d = M(:,:,2); % Probabilities of voting for denoising for BM3D filter
figure;
plot(sigma,M_bm3d,'--o');
xlabel('\sigma');
ylabel('Probability of voting for denoising');
title('BM3D');
%%
for i = 1:numel(sigma)
    figure;
    S = permute(M(i,:,:),[2 3 1]);
    bar(S);
    xlim([0 numel(imgs)+1])
    ylim([0 1.25])
    
    text(1:numel(imgs),ones(1,numel(imgs))*1.2,ilabels,...
        'rotation',-90,'horizontalalignment','left');
    legend(filters{:},'Location','NorthOutside','Orientation','Horizontal');
    title(['Sigma = ' num2str(sigma(i))]);
    xlabel('Test image');
    ylabel('Probability of voting for denoising');
    
    figure;
    S = permute(NSD(i,:,:),[2 3 1]);
    bar(S);
    xlim([0 numel(imgs)+1])
    ylim([0 1])
    
    text(1:numel(imgs),ones(1,numel(imgs))*0.95,ilabels,...
       'rotation',-90,'horizontalalignment','left');
    title(['Sigma = ' num2str(sigma(i))]);
    xlabel('Test image');
    ylabel('Variance of probability of voting for denoising');
    
    figure;
%     set(gcf,'Units','centimeters','Position',[15 10 15 6]);
%     subplot(1,2,1);
    P = permute(PSNRHVSM(i,:,:),[2 3 1]);
    bar(P);
    xlim([0 numel(imgs)+1])
    ylim([floor(min(P(:))) ceil(max(P(:)))+2])
    text(1:numel(imgs),ones(1,numel(imgs))*(ceil(max(P(:)))+1.9),ilabels,...
        'rotation',-90,'horizontalalignment','left');
    title(['Sigma = ' num2str(sigma(i))]);
    xlabel('Test image');
    ylabel('Real IPHVS');
    
    figure;
%     subplot(1,2,2);
    Pred(:,1) = feval(mdl_DCTF,M_awgn(i,:));
    Pred(:,2) = feval(mdl_BM3D,M_awgn(i,:));
    bar(Pred);
    xlim([0 numel(imgs)+1])
    ylim([floor(min(P(:))) ceil(max(P(:)))+2])
    text(1:numel(imgs),ones(1,numel(imgs))*(ceil(max(P(:)))+1.9),ilabels,...
        'rotation',-90,'horizontalalignment','left');
    title(['Sigma = ' num2str(sigma(i))]);
    xlabel('Test image');
    ylabel('Predicted IPHVS');
end
%%
for i = 1:numel(imgs)
    figure;
    imshow(imread(['images/ref/' num2str(imgs(i)) '.bmp']));
    title(ilabels{i});
    figure;
    plot(sigma,M_dctf(:,i),'--o');
    hold on
    plot(sigma,M_bm3d(:,i),'--*');
    hold off
    legend('DCTF','BM3D');
    xlabel('Noise STD');
    ylabel('Probability of voting for denoising');
end
