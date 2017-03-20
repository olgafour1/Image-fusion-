function imfusionDWT2( action )

if nargin == 0,
    action = '#initialize';
else
    if action(1) ~= '#',
        error( 'Wrong action #' )
    end
end

if strcmp( action , '#initialize' ),
    %% #initialize
    clc
    clear
    close all
    
    %% figure
    fg = figure( 'Name' , 'Image Fusion with 2D DWT' , ...
        'NumberTitle' , 'off' , ...
        'MenuBar' , 'none' , ...
        'Position' , [ 100 100 600 510 ] , ...
        'resize' , 'off' , ...
        'Tag' , 'fg' );
    
    %% Data
    pLoad = uipanel( fg , 'Title' , 'Load Images' , ...
        'FontWeight' , 'bold' , ...
        'Units' , 'pixel' , ...
        'Position' , [ 10 350 400 150 ]);
    
    % data pushbutton
    total_load = 3;
    height_load = 30;
    width_load = 80;
    left_gap_load = 10;
    bottom_gap_load = 10;
    
    % data im1 pushbutton
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 1 );
    width = width_load;
    height = height_load;
    uicontrol( pLoad , 'Style' , 'pushbutton' , ...
        'String' , 'Load Image 1' , ...
        'Position' , [left bottom width height] , ...
        'CallBack' , 'imfusionDWT2 #loadim1' )
    
    % data im2 pushbutton
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 2 );
    width = width_load;
    height = height_load;
    uicontrol( pLoad , 'Style' , 'pushbutton' , ...
        'String' , 'Load Image 2' , ...
        'Position' , [left bottom width height] , ...
        'CallBack' , 'imfusionDWT2 #loadim2' )
    
    % data text
    total_text = 4;
    height_text = height_load;
    width_text = 300;
    left_gap_text = 10;
    bottom_gap_text = 0;
    
    % data text
    left = left_gap_text + width_load;
    bottom = bottom_gap_text + height_text * ( total_text - 1 ) + 10;
    width = width_text;
    height = height_text;
    uicontrol( pLoad , 'Style' , 'text' , ...
        'String' , 'Loaded Images' , ...
        'FontWeight' , 'bold' , ...
        'Position' , [left bottom width height] ) 
    
    % data im1 text
    left = left_gap_text + width_load;
    bottom = bottom_gap_text + height_text * ( total_text - 2 );
    width = width_text;
    height = height_text;
    uicontrol( pLoad , 'Style' , 'text' , ...
        'String' , 'none' , ...
        'Position' , [left bottom width height] , ...
        'Tag' , 'textim1' )
    
    % data im2 text
    left = left_gap_text + width_load;
    bottom = bottom_gap_text + height_text * ( total_text - 3 );
    width = width_text;
    height = height_text;
    uicontrol( pLoad , 'Style' , 'text' , ...
        'String' , 'none' , ...
        'Position' , [left bottom width height] , ...
        'Tag' , 'textim2' )

    %% DWT Properties
    
    pDWT = uipanel( fg , 'Title' , 'DWT Properties' , ...
        'FontWeight' , 'bold' , ...
        'Units' , 'pixel' , ...
        'Position' , [ 10 160 400 150 ]);
    
    % Wavelet
    total_load = 4;
    height_load = 30;
    width_load = 80;
    left_gap_load = 10;
    bottom_gap_load = 10;
    
    % Wavelet popupmenu
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 1 );
    width = width_load;
    height = height_load;
    choices = { 'haar', 'dmey', ...
        'db1' ,'db2', 'db3' , 'db4' ,'db5' ,'db6' ,'db7' ,'db8' ,'db9' ,'db10' ,...
        'coif1' ,'coif2' ,'coif3' ,'coif4' , 'coif5' , ...
        'sym2' ,'sym3' ,'sym4' ,'sym5' ,'sym6' ,'sym7' ,'sym8' , ...
        'bior1.1', 'bior1.3', 'bior1.5', 'bior2.2', 'bior2.4', 'bior2.6', 'bior2.8', ...
        'bior3.1', 'bior3.3', 'bior3.5', 'bior3.7', ...
        'bior3.9', 'bior4.4', 'bior5.5', 'bior6.8', ...
        'rbio1.1', 'rbio1.3', 'rbio1.5', ...
        'rbio2.2', 'rbio2.4', 'rbio2.6', 'rbio2.8', ...
        'rbio3.1', 'rbio3.3', 'rbio3.5', 'rbio3.7', ...
        'rbio3.9', 'rbio4.4', 'rbio5.5', 'rbio6.8' };
    uicontrol( pDWT , 'Style' , 'popupmenu' , ...
        'String' , choices , ...
        'Position' , [left+100 bottom width height] , ...
        'Tag' , 'DWTwavelet' )
    
    % Wavelet text
    uicontrol( pDWT , 'Style' , 'text' , ...
        'String' , 'Wavelet' , ...
        'Position' , [left bottom width height] )
    
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 2 );
    width = width_load;
    height = height_load;
    % Wavelet level_popupmenu
    uicontrol( pDWT , 'Style' , 'popupmenu' , ...
        'String' , { '1', '2', '3', '4', '5' } , ...
        'Position' , [left+100 bottom width height] , ...
        'Tag' , 'DWTlevel' )
    
    % Wavelet level_text
    uicontrol( pDWT , 'Style' , 'text' , ...
        'String' , 'Level' , ...
        'Position' , [left bottom width height] )
    
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 3 );
    width = width_load;
    height = height_load;
    % Wavelet pushbutton
    uicontrol( pDWT , 'Style' , 'pushbutton' , ...
        'String' , 'Decompose' , ...
        'Position' , [left bottom width height] , ...
        'Callback', 'imfusionDWT2 #decompose' )
    
%% Fusion Method
    
    pFM = uipanel( fg , 'Title' , 'Fusion Method' , ...
        'FontWeight' , 'bold' , ...
        'Units' , 'pixel' , ...
        'Position' , [ 10 10 400 150 ]);
    
    % Wavelet
    total_load = 4;
    height_load = 30;
    width_load = 80;
    left_gap_load = 10;
    bottom_gap_load = 10;
    
    % Wavelet popupmenu
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 1 );
    width = width_load;
    height = height_load;
    choices = { 'max' , 'min' , 'mean' , 'rand' , 'img1' , 'img2' };
    uicontrol( pFM , 'Style' , 'popupmenu' , ...
        'String' , choices , ...
        'Position' , [left+100 bottom width height] , ...
        'Tag' , 'FMApprox' )
    
    % Wavelet text
    uicontrol( pFM , 'Style' , 'text' , ...
        'String' , 'Approximation' , ...
        'Position' , [left bottom width height] )
    
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 2 );
    width = width_load;
    height = height_load;
    % Wavelet level_popupmenu
    choices = { 'max' , 'min' , 'mean' , 'rand' , 'img1' , 'img2' };
    uicontrol( pFM , 'Style' , 'popupmenu' , ...
        'String' , choices , ...
        'Position' , [left+100 bottom width height] , ...
        'Tag' , 'FMDetails' )
    
    % Wavelet level_text
    uicontrol( pFM , 'Style' , 'text' , ...
        'String' , 'Details' , ...
        'Position' , [left bottom width height] )
    
    left = left_gap_load;
    bottom = bottom_gap_load + height_load * ( total_load - 3 );
    width = width_load;
    height = height_load;
    % Wavelet pushbutton
    uicontrol( pFM , 'Style' , 'pushbutton' , ...
        'String' , 'Apply' , ...
        'Position' , [left bottom width height] , ...
        'Callback', 'imfusionDWT2 #apply' )

elseif strcmp( action , '#loadim1' ),
    %% loadim1
    [ filename , path ] = uigetfile( { '*.*' , 'All Files (*.*)' } , 'Pick an image' );
    file = [path filename];
    
    try 
        I1 = imread( file );
    catch
        error( [filename ' is not an image'] )
    end
  
    obj = findobj( 'Tag' , 'textim1' );
    set( obj , 'String' , file )

    fgIm = figure( 'Name' , 'Images' , ...
        'NumberTitle' , 'off' , ...
        'Tag' , 'fgIm');
    
    subplot( 2 , 4 , 1 )
    imshow( I1 )
    
elseif strcmp( action , '#loadim2' ),
    %% loadim2
    [ filename , path ] = uigetfile( { '*.*' , 'All Files (*.*)' } , 'Pick an image' );
    file = [path filename];
    
    try 
        I2 = imread( file );
    catch
        error( [filename ' is not an image'] )
    end

    obj = findobj( 'Tag' , 'textim2' );
    set( obj , 'String' , file )
    
    
    obj = findobj( 'Tag' , 'fgIm' );
    figure( obj )
    subplot( 2 , 4 , 5 )
    imshow( I2 )

elseif strcmp( action , '#decompose' ),
    %% decompose
    obj = findobj( 'Tag', 'DWTwavelet' );
    w = get( obj, 'Value' );
    obj = findobj( 'Tag', 'DWTlevel' );
    l = get( obj, 'Value' );
    obj = findobj( 'Tag' , 'textim1' );
    im1 = get( obj , 'String' );
    obj = findobj( 'Tag' , 'textim2' );
    im2 = get( obj , 'String' );
    
    choices = { 'haar', 'dmey', ...
        'db1' ,'db2', 'db3' , 'db4' ,'db5' ,'db6' ,'db7' ,'db8' ,'db9' ,'db10' ,...
        'coif1' ,'coif2' ,'coif3' ,'coif4' , 'coif5' , ...
        'sym2' ,'sym3' ,'sym4' ,'sym5' ,'sym6' ,'sym7' ,'sym8' , ...
        'bior1.1', 'bior1.3', 'bior1.5', 'bior2.2', 'bior2.4', 'bior2.6', 'bior2.8', ...
        'bior3.1', 'bior3.3', 'bior3.5', 'bior3.7', ...
        'bior3.9', 'bior4.4', 'bior5.5', 'bior6.8', ...
        'rbio1.1', 'rbio1.3', 'rbio1.5', ...
        'rbio2.2', 'rbio2.4', 'rbio2.6', 'rbio2.8', ...
        'rbio3.1', 'rbio3.3', 'rbio3.5', 'rbio3.7', ...
        'rbio3.9', 'rbio4.4', 'rbio5.5', 'rbio6.8' };
    
    I1 = imread( im1 );
    I2 = imread( im2 );
    
    [ D1 ]  = dwtlevel( I1, l, 1, choices{w} );
    [ D2 ]  = dwtlevel( I2, l, 1, choices{w} );
    
    
    obj = findobj( 'Tag' , 'fgIm' );
    figure( obj )
    subplot( 2 , 4 , 2 )
    imshow( 1 - D1 )
 
    subplot( 2 , 4 , 6 )
    imshow( 1 - D2 )
    
elseif strcmp( action , '#apply' ),
    %% apply
    obj = findobj( 'Tag', 'DWTwavelet' );
    w = get( obj, 'Value' );
    obj = findobj( 'Tag', 'DWTlevel' );
    level = get( obj, 'Value' );
    obj = findobj( 'Tag' , 'textim1' );
    im1 = get( obj , 'String' );
    obj = findobj( 'Tag' , 'textim2' );
    im2 = get( obj , 'String' );
    obj = findobj( 'Tag' , 'FMDetails' );
    a = get( obj , 'Value' );
    obj = findobj( 'Tag' , 'FMApprox' );
    b = get( obj , 'Value' );
    
    wname = { 'haar', 'dmey', ...
        'db1' ,'db2', 'db3' , 'db4' ,'db5' ,'db6' ,'db7' ,'db8' ,'db9' ,'db10' ,...
        'coif1' ,'coif2' ,'coif3' ,'coif4' , 'coif5' , ...
        'sym2' ,'sym3' ,'sym4' ,'sym5' ,'sym6' ,'sym7' ,'sym8' , ...
        'bior1.1', 'bior1.3', 'bior1.5', 'bior2.2', 'bior2.4', 'bior2.6', 'bior2.8', ...
        'bior3.1', 'bior3.3', 'bior3.5', 'bior3.7', ...
        'bior3.9', 'bior4.4', 'bior5.5', 'bior6.8', ...
        'rbio1.1', 'rbio1.3', 'rbio1.5', ...
        'rbio2.2', 'rbio2.4', 'rbio2.6', 'rbio2.8', ...
        'rbio3.1', 'rbio3.3', 'rbio3.5', 'rbio3.7', ...
        'rbio3.9', 'rbio4.4', 'rbio5.5', 'rbio6.8' };
    
    I1 = imread( im1 );
    I2 = imread( im2 );
    
    fusmeth = { 'max' , 'min' , 'mean' , 'rand' , 'img1' , 'img2' };
     
    IF = wfusimg( I1 , I2 , wname{w} , level , fusmeth{a} , fusmeth{b} );
    
    IF = imdwt2rgb( IF );
    
    obj = findobj( 'Tag' , 'fgIm' );
    figure( obj )
    subplot( 2 , 4 , [ 3 4 7 8 ] )
    imshow( IF )
    
end
end

function [ A ]  = dwtlevel( I , l , i , ch )
    [ cA1 , cH1 , cV1 , cD1 ] = dwt2( I , ch );
    cA1 = imdwt2rgb( cA1 );
    cH1 = imdwt2rgb( cH1 );
    cV1 = imdwt2rgb( cV1 );
    cD1 = imdwt2rgb( cD1 );
    if i < l,
        i = i + 1;
        [ cA1 ] = dwtlevel( cA1 , l , i , ch );
    end
    [ n , m , ~ ] = size( cA1 );
    cH1 = imresize( cH1 , [ n , m ] );
    cV1 = imresize( cV1 , [ n , m ] );
    cD1 = imresize( cD1 , [ n , m ] );
    A = [cA1, cH1; cV1, cD1];
end

function cH1 = imdwt2rgb( cH1 )
    [ ~ , ~ , k ] = size( cH1 );
    if k == 3,
        tmp1 = cH1(:,:,1);
        tmp2 = cH1(:,:,2);
        tmp3 = cH1(:,:,3);
        if min( tmp1(:) ) < 0,
            tmp1 = tmp1 + abs( min( tmp1(:) ) );
        end
        if min( tmp2(:) ) < 0,
            tmp2 = tmp2 + abs( min( tmp2(:) ) );
        end
        if min( tmp3(:) ) < 0,
            tmp3 = tmp3 + abs( min( tmp3(:) ) );
        end
        tmp1 = tmp1 / max( tmp1(:) );
        tmp2 = tmp2 / max( tmp2(:) );
        tmp3 = tmp3 / max( tmp3(:) );
        disp( [ minmax( tmp1(:)' ); minmax( tmp2(:)' ); minmax( tmp3(:)' ) ] )
        cH1(:,:,1) = tmp1;
        cH1(:,:,2) = tmp2;
        cH1(:,:,3) = tmp3;
    else
        tmp1 = cH1;
        if min( tmp1(:) ) < 0,
            tmp1 = tmp1 + abs( min( tmp1(:) ) );
        end
        tmp1 = tmp1 / max( tmp1(:) );
        cH1 = tmp1;
    end
end
    