# Nipple-Detection
Implementation of the paper "Automatic nipple detection in breast thermograms" in MATLAB. This implementation was an assignment of the "Artificial Vision and Pattern Recognition" course of the MESIIA master.  Universitat Rovira i Virgili


## Introduction

This document aims to present the implementation of the algorithm presented in the paper “Automatic nipple detection in breast thermograms” [1] alongside its results over a set of 6 images. This implementation constituted the deliverable of the first graded assignment of the Artificial Vision and Pattern Recognition (AVPR) course.
To test the performance of the implemented algorithm a set of 6 breast thermograms was provided.

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

<p float="left" align="center">
  <img src="https://github.com/DeVillax/Nipple-Detection/blob/main/Images/original.jpg" width="400" />
  <img src="https://github.com/DeVillax/Nipple-Detection/blob/main/Images/segmented.jpg" width="400" /> 
</p>

<p float="left" align="center">
  <img src="https://github.com/DeVillax/Nipple-Detection/blob/main/Images/candidates.jpg" width="400" />
  <img src="https://github.com/DeVillax/Nipple-Detection/blob/main/Images/result.jpg" width="400" /> 
</p>

## References

[1] 	Mohamed Abdel-Nasser, Adel Saleh, Antonio Moreno, and Domenec Puig. 2016. Automatic nipple detection in breast thermograms. Expert Syst. Appl. 64, C (December 2016), 365–374. DOI:https://doi.org/10.1016/j.eswa.2016.08.026



