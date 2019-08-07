% Swarm Computations
% Kai Brooks
% github.com/kaibrooks
% 2019
%
% Computes a global average from local (swarm) comparisons
%

clc
clear all
close all
rng('default')

totalMembers = 6; % members in the swarm
maxIterations = 20; % max swaps to run

% format: memberNum(member, iteration)

% generate starting (random) numbers
for i = 1:totalMembers
    memberNum(i,1) = randi(100);
end

trueMean = mean(memberNum); % the mean we aim for
stDev(1) = std(memberNum(:,1)); % starting standard deviation

for j = 2:maxIterations % start at 2 since the first one is the initial creation
    % copy array
    memberNum(:,j) = memberNum(:,j-1);
   
    for i=1:totalMembers-1
    
        % select adjacent members to average
        mema = i;
        memb = i+1;
        
        if mema == memb
        %    continue
        end
        
        % average numbers
        avg = mean([memberNum(mema,j) memberNum(memb,j)]);
        
        %fprintf('%.2i: %.2f | %.2i: %.2f = %.2f\n', mema, memberNum(mema,j), memb, memberNum(memb,j), avg);
        
        % write averages
        memberNum(mema,j) = avg;
        memberNum(memb,j) = avg;
        
    end
    
    % write other stats
    stDev(j) = std(memberNum(:,j));
    
    % shuffle?
    %memberNum = memberNum(randperm(size(memberNum,1)),:);
    
end

mean(memberNum(:,1)) % 'starting' mean

memberNum
%memberNum(:,maxIterations)


plot(stDev)
xlabel('standard deviation')
ylabel('iteration')

x = [1:maxIterations]

figure(2)
plot(x,memberNum)

hline = refline(0,trueMean);
hline.Color = 'red';
hline.LineStyle = ':';


