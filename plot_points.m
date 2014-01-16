function [] = plot_points(data, params)
%PLOT_POINTS plot coordinates and paths of end and middle points
%  PLOT_POINTS(DATA, PARAMS) uses the specified simulation DATA and the
%  beam parameters PARAMS.

% Left end
if params.leftCnstr == 0
    figure
    subplot(2,1,1)
    hold on, grid on, box on
    plot(data.t, data.e(1,:), 'r')
    hold on
    plot(data.t, data.e(2,:), 'g')
    plot(data.t, data.e(3,:), 'b')
    legend('x', 'y', 'z');
    xlabel('time')
    title('Coordinates of left end')
    axis tight
    subplot(2,1,2)
    hold on, grid on, box on
    plot(data.e(1,:), data.e(3,:))
    xlabel('x')
    ylabel('y')
    title('Path of left end')
    axis equal
    
end

% Middle point
if mod(params.ne, 2) == 0
    % Even number of elements
    ie = params.ne / 2;
    x = params.L;
else
    % Odd number of elements
    ie = (params.ne + 1) / 2;
    x = params.L / 2;
end

nt = length(data.t);
rm = zeros(3,nt);
S = shape_fun(x, params.L, 0);
for it = 1:length(data.t)
    rm(:,it) = S_e(S, data.e(6*ie-5:6*ie+6,it));
end

figure
subplot(2,1,1)
hold on, grid on, box on
plot(data.t, rm(1,:), 'r')
hold on
plot(data.t, rm(2,:), 'g')
plot(data.t, rm(3,:), 'b')
legend('x', 'y', 'z');
xlabel('time')
title('Coordinates of middle point')
axis tight
subplot(2,1,2)
hold on, grid on, box on
plot(rm(1,:), rm(3,:))
xlabel('x')
ylabel('y')
title('Path of middle point')
axis equal


% Right end
if params.rightCnstr == 0
    figure
    subplot(2,1,1)
    hold on, grid on, box on
    plot(data.t, data.e(end-5,:), 'r')
    hold on
    plot(data.t, data.e(end-4,:), 'g')
    plot(data.t, data.e(end-3,:), 'b')
    legend('x', 'y', 'z');
    xlabel('time')
    title('Coordinates of right end')
    axis tight
    subplot(2,1,2)
    hold on, grid on, box on
    plot(data.e(end-5,:), data.e(end-3,:))
    xlabel('x')
    ylabel('y')
    title('Path of right end')
    axis equal
end