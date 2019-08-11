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
rng('shuffle')

totalMembers = 100; % members in the swarm
maxIterations = 110; % max swaps to run

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
    
    % break early if convergence below this amount
    if stDev(j) < 0.05
        maxIterations = j;
        fprintf('*** Early break *** \n')
        break
    end
    
end

%mean(memberNum(:,1)) % 'starting' mean fyi

% output stats
fprintf('Mean:\t%.2f\n', trueMean)
fprintf('Min:\t%.2f\n', min(memberNum(:,maxIterations)))
fprintf('Max:\t%.2f\n', max(memberNum(:,maxIterations)))
fprintf('StDev:\t%.2f\n', stDev(maxIterations))
fprintf('Loops:\t%i\n',maxIterations)

plot(stDev)
xlabel('standard deviation')
ylabel('iteration')
xlim([1, maxIterations])

x = [1:maxIterations]; % for plotting

figure(2)
plot(x,memberNum)
xlabel('iteration')
ylabel('member value')
xlim([1, maxIterations])
grid on

hline = refline(0,trueMean);
hline.Color = 'black';
hline.LineStyle = ':';
hline.LineWidth = 1;
