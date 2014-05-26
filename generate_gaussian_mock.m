function [mock_filtered, mock_sharp] = generate_gaussian_mock(mock_frame_size, move_pattern, N_out_frame, sigma, th)


if length(move_pattern)==1
    move_pattern = [move_pattern, move_pattern];
else
    move_pattern = [move_pattern(1), move_pattern(2)];
end

mock_frame_size_default = 100;
move_pattern_default = [1, 1];
N_out_frame_default = 2;
sigma_default = 0.3;
th_default = 5;

switch nargin 
    case 0
        [mock_filtered, mock_sharp] = gauss_mock_frames(mock_frame_size_default, move_pattern_default, ...
            N_out_frame_default, sigma_default, th_default);
    case 1
        [mock_filtered, mock_sharp] = gauss_mock_frames(mock_frame_size, move_pattern_default, ...
            N_out_frame_default, sigma_default, th_default);
    case 2
        [mock_filtered, mock_sharp] = gauss_mock_frames(mock_frame_size, move_pattern, ...
            N_out_frame_default, sigma_default, th_default);
    case 3
        [mock_filtered, mock_sharp] = gauss_mock_frames(mock_frame_size, move_pattern, ...
            N_out_frame, sigma_default, th_default);
    case 4
        [mock_filtered, mock_sharp] = gauss_mock_frames(mock_frame_size, move_pattern, ...
            N_out_frame, sigma, th_default);
    case 5
        [mock_filtered, mock_sharp] = gauss_mock_frames(mock_frame_size, move_pattern, ...
            N_out_frame, sigma, th);
    otherwise
        disp('Error: The number of input arguments exceeds the maximum.');
end