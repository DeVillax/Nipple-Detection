
original = imread('.\test\IR_0100.png');
figure,imshow(original)
title('original')

seg = body_segmentation(original)
figure,imshow(seg)
title('segmented')

can = nipple_candidates(seg)
figure,imshow(can)
title('candidates')

nipples = nipple_selection(can)
marked = mark_nipples(nipples,original)
figure,imshow(marked)
title('results')

%% Phase I: Human Body segmentation
function segmented = body_segmentation(input_image)

    % First of all we convert the image to grayscale 
    gray_image = rgb2gray(input_image);
    
    % Define the threshold and apply it to create the human body mask
    % (binary image)
    threshold = 50;
    mask = gray_image < threshold;

    % Create the disk structure 3px radius and apply morphological close in
    SE = strel('disk',3);
    closeBW = imclose(mask,SE);

    % Create the disk structure 10px radius and apply morphological dilation  
    SE2 = strel('disk',10);
    dilateBW = imdilate(closeBW,SE2);

    gray_image(dilateBW) = 0;
    segmented = gray_image;
end


%% Phase II: Nipple candidates determination
function candidates = nipple_candidates(input_image)
    % We apply the median filter with a local neighborhood of 15 pixels
    median_img = medfilt2(input_image,[15,15]);
    
    % Substraction of the original image from the convolved one
    diff = imsubtract(median_img,input_image);
    
    % Thresholding the difference image with a constanc C=0.03
    candidates = imbinarize(diff,0.03);
end


%% Phase III: Nipple selection
function nipples = nipple_selection(input_image)
    
    % First, we delete the regions than has less than 20 pixels. For that we
    % can use bwareaopen
    Np = 20;
    BW = bwareaopen(input_image,Np);

    % Selecting regions using the 3rd fact mentioned in the paper
    [height,width] = size(BW);
    Hup = 0.35 * height;
    Hlw = 0.3 * height;

    % We can now crop the image to select only the region of interest
    cropped = imcrop(BW,[0 Hlw width Hup]);

    % For the next step, and following the 4th fact, we determine the center
    % line of the image
    center = width/2;
    
    % Now we can find the connected components (objects) in the cropped image
     
    candidates = regionprops(bwconncomp(bwareaopen(cropped,Np)),'all');
   
    % Now, we need to check where these objects are, either left, or right. To
    % this effect, we can use the centroid of the region to determine this.
    
    left = [];
    right = [];

    struct_size = length(candidates);
    for i=1:struct_size
        % We first get the coordinate X of each candidate's centroid
        x = candidates(i).Centroid(1);

        % We check which side they are on
        if  center < x
            right(end+1) = i;
        elseif center > x
            left(end+1) = i;
        end
    end

    % Based on the paper, now we need to check which one has more roundness.
    % The circularity calculated in the candidates structure helps us out.
    % The circularity value is computed as (4*Area*pi)/(Perimeter2)

    left_roundness = 0;
    left_nipple = 0;
    right_roundness = 0;
    right_nipple = 0;

    for i=1:length(left)
        if candidates(left(i)).Circularity > left_roundness
            left_roundness = candidates(left(i)).Circularity;
            left_nipple = candidates(left(i)).Centroid;
        end
    end

    for i=1:length(right)
        if candidates(right(i)).Circularity > right_roundness
            right_roundness = candidates(right(i)).Circularity;
            right_nipple = candidates(right(i)).Centroid;
        end
    end

    nipples.left = left_nipple
    nipples.right = right_nipple
    nipples.hlw = Hlw
    
end


%% Mark Nipples
function marked = mark_nipples(nipples, original_img)
    % Finally, we just need to print the nipples on the original image. For
    % this, we will need to instert a marker in the image. Insert Marker
    % requires us to download the Comptuer Vision Toolbox

    marked = original_img
    if nipples.left ~= 0
        nipples.left(2) = nipples.left(2)+ nipples.hlw;
        marked = insertMarker(marked,nipples.left,'color','red','size',5);
    end

    if nipples.right ~= 0
        nipples.right(2) = nipples.right(2)+ nipples.hlw;
        marked = insertMarker(marked,nipples.right,'color','red','size',5);
    end
    
end

