clear, clc
filename=['C:\Users\zywadam\Desktop\DS\requests.csv'];
data=csvread(filename,1,0);
rider_id=data(:,1);
start_lat=data(:,2);
start_lng=data(:,3);
end_lat=data(:,4);
end_lng=data(:,5);
n=length(rider_id);

% match_id=[435,228,228,435];
% match_index=match_id+ones(1,4);
% match_2_distance=distance(start_lat(match_index(1)),start_lng(match_index(1)),start_lat(match_index(2)),start_lng(match_index(2)))+distance(start_lat(match_index(2)),start_lng(match_index(2)),end_lat(match_index(3)),end_lng(match_index(3)))+distance(end_lat(match_index(3)),end_lng(match_index(3)),end_lat(match_index(4)),end_lng(match_index(4)))

%n=100;
dist=NaN(n,n);
totaldis=0;
path=num2cell(zeros(n,n));
match_2=NaN(1,4);
count=0;

h=waitbar(0,'Please wait...');
for i=1:n
    if ~isempty(find(match_2 == rider_id(i)))
    else
    dist_0=distance(start_lat(i),start_lng(i),end_lat(i),end_lng(i));
    if start_lat(i)<end_lat(i)
        ya=start_lat(i);
        yb=end_lat(i);
    else
        ya=end_lat(i);
        yb=start_lat(i);
    end
    if start_lng(i)<end_lng(i)
        xa=start_lng(i);
        xb=end_lng(i);
    else
        xa=end_lng(i);
        xb=start_lng(i);
    end
    
        
    %calculate possible optimal route and distance for all neighboring nodes within triangle
    for j=1:n
        if ~isempty(find(match_2 == rider_id(j)))
        else
        if (ya<start_lat(j) && start_lat(j)<yb) && (xa<start_lng(j) && start_lng(j)<xb)
%             dist_1=matchdistance(rider_id(i),rider_id(j),rider_id(j),rider_id(i));
%             dist_2=matchdistance(rider_id(i),rider_id(j),rider_id(i),rider_id(j));
            %get 2-matching distance for two types of routes: ABBA and ABAB
            match_id_1=[rider_id(i),rider_id(j),rider_id(j),rider_id(i)];
            match_index=match_id_1+ones(1,4);
            dist_1=distance(start_lat(match_index(1)),start_lng(match_index(1)),start_lat(match_index(2)),start_lng(match_index(2)))+distance(start_lat(match_index(2)),start_lng(match_index(2)),end_lat(match_index(3)),end_lng(match_index(3)))+distance(end_lat(match_index(3)),end_lng(match_index(3)),end_lat(match_index(4)),end_lng(match_index(4)));
            match_id_2=[rider_id(i),rider_id(j),rider_id(i),rider_id(j)];
            match_index=match_id_2+ones(1,4);
            dist_2=distance(start_lat(match_index(1)),start_lng(match_index(1)),start_lat(match_index(2)),start_lng(match_index(2)))+distance(start_lat(match_index(2)),start_lng(match_index(2)),end_lat(match_index(3)),end_lng(match_index(3)))+distance(end_lat(match_index(3)),end_lng(match_index(3)),end_lat(match_index(4)),end_lng(match_index(4)));
            
            if dist_1>dist_2
                dist(i,j)=dist_2;
                path{i,j}=[rider_id(i),rider_id(j),rider_id(i),rider_id(j)];
            else
                dist(i,j)=dist_1;
                path{i,j}=[rider_id(i),rider_id(j),rider_id(j),rider_id(i)];
            end
        end
        end
    end
    %matching criteria
    [row,col]=find(dist==min(dist(i,:)));
    j=col;
    dist_j=distance(start_lat(j),start_lng(j),end_lat(j),end_lng(j));
    if min(dist(i,:))<0.8*(dist_0+dist_j)
        count=count+1;
        match_2(count,:)=path{i,col};
        totaldis=totaldis+min(dist(i,:));
    end
    end
    waitbar(i/n)
end
close(h)          

%label rest as 1-match trip
match_1=NaN(n,2);
for i=0:n-1
    if isempty(find(match_2 == i))
        match_1(i+1,:)=[i,i];
        totaldis=totaldis+distance(start_lat(i+1),start_lng(i+1),end_lat(i+1),end_lng(i+1));
    end
end


csvwrite('C:\Users\zywadam\Desktop\DS\2-matches.csv',match_2)