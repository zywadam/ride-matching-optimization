function [ M ] = distance(start_lat,start_lng,end_lat,end_lng)
% distance: get the manhattan distance between two riders from data
% The manhattan distance definition:  M = 84.2*abs(start_lat-end_lat)+111.2*abs(start_lng-end_lng)

M = 84.2*abs(start_lat-end_lat)+111.2*abs(start_lng-end_lng);
end

