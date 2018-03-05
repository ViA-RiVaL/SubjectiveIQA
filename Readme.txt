SubjectiveIQA database 2017, version 1.0

SubjectiveIQA database is intended for analysis of visual quality of different types 
of images subject to denoising. 109 experiments with observers have been carried out 
to assess visual quality of denoised images. Two denoising techniques, namely 
the DCT filter* and the BM3D** filter, are considered. 

Permission to use, copy, or modify this database and its documentation
for educational and research purposes only and without fee is hereby
granted, provided that this copyright notice and the original authors'
names appear on all copies and supporting documentation.

In case of publishing results obtained by means of SubjectiveIQA Database, please refer 
to the following paper:

A. Rubel, O. Rubel and V. Lukin, "Analysis of visual quality for denoised images," 
2017 14th International Conference The Experience of Designing and Application 
of CAD Systems in Microelectronics (CADSM), Lviv, 2017, pp. 92-96.
doi: 10.1109/CADSM.2017.7916093

SubjectiveIQA database contains 16 reference images, 112 distorted images 
(16 reference images x 7 noise levels) and 224 denoised images (each distorted image 
has been denoised by both DCT* and BM3D** filters). 
All images are saved in Bitmap format (.bmp) without any compression.
File names are organized in such a manner that they indicate noise standard deviation 
(NSD) X and a number of the reference image Y: 
"NSD_X_Y.bmp", "DCTF_NSD_X_Y.bmp", "BM3D_NSD_X_Y.bmp", where X = {3,5,10,15,20,25,30}. 

Each report file is organized in the following way:
 - the first column is an image number (total number of denoised images is 224);
 - the second column denotes type of used filter (1 - DCT filter* and 2 - BM3D filter**);
 - the third column shows the noise standard deviation (NSD = 3,5,10,15,20,25,30);
 - the fourth column is a number of reference image (total number of reference images is 16***);
 - the fifth column shows which image has a better visual quality (1 - denoised image, 0 - noisy ones).

*
V. Lukin, R. Oktem, N. Ponomarenko and K. Egiazarian, "Image Filtering Based on Discrete Cosine Transform", 
Telecommunications and Radio Engineering, vol. 66, no. 18, pp. 1685-1701, 2007.

**
K. Dabov, A. Foi, V. Katkovnik, K. Egiazarian, “Image denoising by sparse 3-D transform-domain
collaborative filtering”, IEEE Trans. on Image Processing, Vol. 16, Issue 8, pp. 2080-2095, 2007.
web page: https://www.cs.tut.fi/~foi/GCF-BM3D/

***
16 reference (noisy-free) images have been taken from the databases TID2013 (http://ponomarenko.info/tid2013.htm)
and USC-SIPI (http://sipi.usc.edu/database/).

------------------------------------------------------------------------------------------------------------------
Descriptions :
-data: 
		M_awgn.mat - P_0.5sigma - statistical parameter. P_0.5sigma is a mean probability that absolute values of 
		DCT coefficients in 8x8 pixel blocks do not exceed a threshold 0.5sigma, where sigma denotes standard 
		deviation of the noise. For more details see the following papers:
		
		1) S. Abramov, S. Krivenko, A. Roenko, V. Lukin, I. Djurovió, M. Chobanu, "Prediction of filtering efficiency 
		for DCT-based image denoising", 2013 2nd Mediterranean Conference on Embedded Computing (MECO),
		pp. 97-100, June 2013. 
		2) O. Rubel, V. Lukin, "An Improved Prediction of DCT-Based Filters Efficiency Using Regression Analysis"
		in Information and Telecommunication Sciences, Kiev, Ukraine:, vol. 5, no. 1, pp. 30-41, 2014. 
		3) O. Rubel, V. Lukin, S. Abramov, B. Vozel, O. Pogrebnyak and K. Egiazarian, "Is Texture Denoising Efficiency
		Predictable?", International Journal of Pattern Recognition and Artificial Intelligence, 
		vol. 32, no. 01, p. 32, 2017. 
		
		PSNR_BM3D.mat, PSNR_DCTF.mat, PSNR_noisy.mat - PSNR results for denoised and noisy images.

		PSNRHVSM_BM3D.mat, PSNRHVSM_DCTF.mat, PSNRHVSM_noisy.mat - PSNR-HVS-M**** results for denoised and noisy images.

Results:
		run result.m 	
		
		
		

		
****
web page: http://www.ponomarenko.info/psnrhvsm.htm
For more details, please refer to the following papers:
	4) N. Ponomarenko, F. Silvestri, K. Egiazarian, M. Carli, J. Astola, V. Lukin, "On between-coefficient contrast
	masking of DCT basis functions", Proceedings of the Third Int. Workshop on Video Processing and Quality Metrics,
	vol. 3, p. 4, 2007.
	5) K. Egiazarian, J. Astola, N. Ponomarenko, V. Lukin, F. Battisti, M. Carli, "New full-reference quality metrics
	based on HVS", Proceedings of the Second International Workshop on Video Processing and Quality Metrics for Consumer
	Electronics, VPQM 2006, Scottsdale, Arizona, USA, 22-24 January 2006, 4 p.
	