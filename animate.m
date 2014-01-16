function [] = animate(data, params)
%ANIMATE animates a noodle using specified simulation data.

% Noodle length
L = params.ne * params.L;

figure('Position', [200 300 900 500], 'Color', [1 1 1]);
view(-30,15)
hold on
hf = fill3([-L; -L; 2*L; 2*L],[0; 0; 0; 0],[-L; L/2; L/2; -L],[0.8,0.8,1]);
set(hf, 'facealpha', 0.2, 'edgecolor',[0.7,0.7,0.7]);
plot3([0;0],[0;0],[-L;L/2],'color',[0.7,0.7,0.7]);
plot3([L;L],[0;0],[-L;L/2],'color',[0.7,0.7,0.7]);
plot3([-L;2*L],[0;0],[0;0],'color',[0.7,0.7,0.7]);
hp = plot3(0,0,0);
axis equal
xlim([-L 2*L])
ylim([-0.2 0.2])
zlim([-L L/2])

set(gca, 'ytick', []);

for i = 1:length(data.t)
    r = calc_points(data.e(:,i), params, 20);
    set(hp, 'XData', r(1,:), 'YData', r(2,:), 'ZData', r(3,:));
    
    pause(0.001)
end
