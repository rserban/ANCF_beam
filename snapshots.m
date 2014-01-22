function [] = snapshots(data, params, n, dt)
%SNAPSHOTS render snapshots from animation
%  SNAPSHOTS(DATA, PARAMS, N, DT) draws the beam in N configurations, each
%  spaced by a time interval DT.

% Noodle length
L = params.ne * params.L;

% Some colors
light_blue = [0.8,0.8,1];
light_gray = [0.5,0.5,0.5];

figure('Position', [100 100 750 650], 'Color', [1 1 1]);
view(-30,15)
hold on
d = 0.01;
hf = fill3([-L; -L; L; L],[d; d; d; d],[-L; L/2; L/2; -L],light_blue);
set(hf, 'facealpha', 0.2, 'edgecolor',light_gray);
plot3([0;0],[d;d],[-L;L/2],'color',light_gray);
plot3([-L;L],[d;d],[0;0],'color',light_gray);
axis equal
xlim([-L L])
ylim([-0.2 0.2])
zlim([-L L/2])
set(gca, 'ytick', []);
set(gca,'FontSize',14);

% Shades of gray
c_start = 0;
c_end = 0.7;
c_vals = linspace(c_start, c_end, n);
col = repmat(c_vals', 1, 3);

for i = 1:n
    t = (i-1) * dt;
    
    idx = find(data.t > t, 1);
    r = calc_points(data.e(:,idx), params, 20);
    hp = plot3(r(1,:), r(2,:), r(3,:));
    set(hp, 'color', col(i,:), 'linewidth', 2);

    t_str = sprintf('%.2f', t);
    r_tip = data.e(end-5:end-3, idx);
    rx_tip = data.e(end-2:end, idx);
    t_loc = r_tip + (L/12) * rx_tip;
    ht = text(t_loc(1), -d, t_loc(3), t_str);
    set(ht, 'FontSize', 14, 'horizontalalignment', 'center', 'verticalalignment', 'middle');
end

%export_fig('snapshots.png', '-png');


