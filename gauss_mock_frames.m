function [mock_filtered, mock_sharp] = gauss_mock_frames(mock_frame_size, move_pattern,N_out_frame, sigma, th)

% Number of output frames: N_out_frame
% Size of output mock frame: mock_frame_size 
% Ratio of gaussian filter over size of output mock frame: sigma 
% Moving Pattern of the output frame over main frame: move_pattern 
% The parameter of post filter: th

filter_size = mock_frame_size*sigma;    % Size of the filter is sigma times of the output frame

x_move = move_pattern(1);       % Extracting moving pattern in the x coordinate
y_move = move_pattern(2);       % Extracting moving pattern in the y coordinate

raw_frame_size = ceil([mock_frame_size + 2*filter_size + N_out_frame*abs(x_move),...   % Determining the size 
    mock_frame_size + 2*filter_size + N_out_frame*abs(y_move)]);                       % of the raw matrix


raw_frame = randn(raw_frame_size);     % Creaeting raw frame with gaussian generator
winMask = gausswin(filter_size)*gausswin(filter_size)';   % Gaussian filter

filtered_frame = filter2(winMask,raw_frame);    % Filtering the raw frame with the gaussian window

sharp_frame = th./(abs(filtered_frame)+th);     % Sharpening of the filtered frame with the post filter

% Craeting output set of frames

mock_filtered = zeros(mock_frame_size,mock_frame_size,N_out_frame);
for k = 1:N_out_frame
    mock_filtered(:,:,k) = filtered_frame(ceil((raw_frame_size(1)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*x_move : ceil((raw_frame_size(1)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*x_move + mock_frame_size - 1,...
        ceil((raw_frame_size(2)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*y_move : ceil((raw_frame_size(2)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*y_move + mock_frame_size - 1);
end

mock_sharp = zeros(mock_frame_size,mock_frame_size,N_out_frame);
for k = 1:N_out_frame
    mock_sharp(:,:,k) = sharp_frame(ceil((raw_frame_size(1)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*x_move : ceil((raw_frame_size(1)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*x_move + mock_frame_size - 1,...
        ceil((raw_frame_size(2)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*y_move : ceil((raw_frame_size(2)-mock_frame_size)/2)-(ceil(N_out_frame/2)-k+1)*y_move + mock_frame_size - 1);
end