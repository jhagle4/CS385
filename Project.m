function Project(filename, option, morph)

%% Canny implementation begins
% Load image 
%filename = 'Fig-11-b.jpg'; 
s = imread(filename);
figure, imshow(s)
b = rgb2gray(s);

if (morph == 2 || morph == 3)
   se = strel('disk', 5);
   b = imdilate(b, se);
   b = imerode(b,se);

   figure, imshow(b); 
end

if option == 1
        b = anisodiff(b, 100, 20, .25, 2);
        b = uint8(b);
        %a = sum(sum(b)) - sum(sum(s));
        figure, imshow(b);
end

if (option == 2)
%Leung-Malik (LM) Filter Bank

    LF = makeLMfilters;
    i = 48;
    lr(:,:,i)=conv2(b,LF(:,:,i),'valid');
    b = uint8(lr(:,:,i));

    figure, imshow(b);
end


if (option == 3) 
%Schmid (S) Filter Bank

    SF = makeSfilters;
    i = 11;
    sr(:,:,i)=conv2(b,SF(:,:,i),'valid');
    b = uint8(sr(:,:,i));

    figure, imshow(b);
end

%% Matlab implementation just for reference (no comparison required)
sigma  = 2; 
threshLow = 0.1;
threshHigh = 0.3;
BW = edge(b,'canny',[threshLow ,threshHigh],sigma);
figure, imshow(BW);

%%

%{
for i = 1:5
    se = strel('disk', 10);
    BW = imdilate(BW, se);
    BW = imerode(BW,se);
end
%}

if (option == 4 || morph == 1 || morph == 3)
    se = strel('disk', 25);
    BW = imdilate(BW, se);
    BW = imerode(BW,se);

    figure, imshow(BW);
end
%}


I = single(BW);
figure, imshow(I);
[f,d] = vl_sift(I) ; %Computes features f using the DOG method and the corresponding descriptors in d

perm = randperm(size(f,2)) ;
sel = perm(1:5) ;

%Plot the scale of the feature in a yellow circle
h1 = vl_plotframe(f) ; 
h2 = vl_plotframe(f) ; set(h1,'color','k','linewidth',3) ; set(h2,'color','y','linewidth',2) ;

%Plot the descriptor in green square
h3 = vl_plotsiftdescriptor(d,f) ; set(h3,'color','g')
