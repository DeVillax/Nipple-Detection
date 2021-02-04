# Nipple-Detection
Implementation of the paper "Automatic nipple detection in breast thermograms" in MATLAB. This implementation was an assignment of the "Artificial Vision and Pattern Recognition" course of the MESIIA master.  Universitat Rovira i Virgili


## Introduction

This document aims to present the implementation of the algorithm presented in the paper “Automatic nipple detection in breast thermograms” [1] alongside its results over a set of 6 images. This implementation constituted the deliverable of the first graded assignment of the Artificial Vision and Pattern Recognition (AVPR) course.
To test the performance of the implemented algorithm a set of 6 breast thermograms was provided. For simplicity, the images were renamed as follow:

* IR_0100: (a)
* IR_1365: (b)
* IR_2841: (c)
* IR_3635: (d)
* IR_3759: (e)
* IR_4089: (f)

## Algorithm Implementation

The algorithm presented in the paper [1] is composed of three sequential phases:

1.	Human body segmentation
Thresholding technique was used to segment the human body from a given grayscale image. This technique divides the pixels into either background or foreground region based on their intensity value and produces a binary mask. Morphological operations such as close in and dilation were then applied to the binary mask image. 
Finally, this mask was then applied to the original image, which resulted in the segmented image.

2.	Determination of nipple candidates using an adaptive threshold 
This phase accepts the segmented image obtained in the previous phase and attempts to detect potential nipple candidates using an adaptive threshold applied to each pixel. This phase results in a binary image that includes the location of potential nipple candidates.
To implement this phase, we followed the indications outlined in the paper [1] and used a median operator with a local neighbourhood of 15 pixels and a constant C of 0.03 as a value for the thresholding. 

3.	Nipples selection 
In the last phase, the algorithm must check the nipple candidates obtained in the previous phase and select the correct position of the nipples.  To do this, a series of operations were performed on the candidates such as removing candidates that fall in either the upper or lower bounds of the thermogram with respect to the body, calculate the roundness of each candidate as nipples are approximately circular, etc.


## Results
Once the algorithm was implemented following the indications and parameters outlined in the paper [1], and following the structure of the different phases, we obtain the following results shown in Figure 2.

The performance of the implemented algorithm is overall good as it was able to successfully detect and mark the correct location of the nipples in 4 out of 6 images, namely images (a), (c), (d), and (e). 

On the other hand, the algorithm seems to struggle to detect the nipples in images (b), and (f) as it exhibits incorrect behaviour.  Regarding image (b), if we manually visualize it, we can see that the nipples are not clearly shown in the image, so it is difficult to discern their location even with the human eye. The algorithm does a ‘best effort’ and marks two points in the image although they don’t represent the actual location of the nipples.

If now we shift our focus to image (f), the algorithm detected a point proximate to the left nipple, although it is simple to see that it falls at the areola and not on the nipple itself. Furthermore, the algorithm fails to detect any candidates for the right nipple on the right part of the body.

Regarding the recall and precision, this wouldn’t accurately represent the performance of the implemented algorithm as it was only tested with a small set of 6 samples. To obtain a better recall and precision values that would truly represent the performance of the algorithm, the whole set of images would need to be used.  In our case of 6 samples, the algorithm successfully detected 8 nipples out of 12. 

Finally, in terms of performance, we calculate the average execution time the algorithm takes to operate the set of 6 samples. In this case, we get similar results to the ones presented in the paper of 0.31s [1]

## References

[1] 	Mohamed Abdel-Nasser, Adel Saleh, Antonio Moreno, and Domenec Puig. 2016. Automatic nipple detection in breast thermograms. Expert Syst. Appl. 64, C (December 2016), 365–374. DOI:https://doi.org/10.1016/j.eswa.2016.08.026



