tic
f = 'C:\Users\Mathew\Desktop\sample.csv';
XX = csvread(f);
sq = size(XX);
N = sq(1,1);    % number of input frequencies
k = 5;          % distortion order
X = eye(N);     % identity matrix
YY = X;     
Z = X;
for o = 1:k-1
    s = size(Z);
    for i = 1:s(1,1)
        parfor j = 1:N
            p = Z(i,:) + X(j,:);
            YY = [YY;p];
            p = Z(i,:) - X(j,:);
            YY = [YY;p];
        end
    end
    Z = YY;
end

combo = YY*XX;
YY = [YY combo];
YY = unique(YY,'rows');
XX = [XX;0];
final = [XX';YY];

d = size(final);
final(:,d(1,2)) = abs(final(:,d(1,2)));
csvwrite('C:\Users\Mathew\Desktop\myfile.csv',final);
%YY is now the distortion matrix


toc
N
k