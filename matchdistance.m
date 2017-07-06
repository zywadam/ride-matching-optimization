function [match_2_distance]=matchdistance(id_1,id_2,id_3,id_4)
% get the 2-pair match distance

filename=['C:\Users\zywadam\Desktop\DS\requests.csv'];
data=csvread(filename,1,0);
rider_id=data(:,1);
start_lat=data(:,2);
start_lng=data(:,3);
end_lat=data(:,4);
end_lng=data(:,5);

match_id=[id_1,id_2,id_3,id_4];
match_index=match_id+ones(1,4);
match_2_distance=distance(start_lat(match_index(1)),start_lng(match_index(1)),start_lat(match_index(2)),start_lng(match_index(2)))+distance(start_lat(match_index(2)),start_lng(match_index(2)),end_lat(match_index(3)),end_lng(match_index(3)))+distance(end_lat(match_index(3)),end_lng(match_index(3)),end_lat(match_index(4)),end_lng(match_index(4)));
end
     
