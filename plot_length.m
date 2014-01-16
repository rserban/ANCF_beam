function l = plot_length(data, params)
%PLOT_LENGTH Calculate and plot time history of beam length

nt = length(data.t);
l = zeros(nt,1);
for it = 1:nt
    l(it) = beam_length(data.e(:,it), params);
end

figure
plot(data.t, l);
grid on, box on
xlabel('time')
ylabel('length')
title('Beam Length')



%% ------------------------------------------------------------

function l = beam_length(e, params)
%BEAM_LENGTH Calculate beam length at given configuration

[x3, w3] = gauss_points(3);

l = 0;

% Loop over all ANCF elements on the noodle
for ie = 1:params.ne
    % Find range of nodal coordinates for this element
    istart = 6*ie - 5;
    iend = 6*ie + 6;

    % Calculate length of element
    le = 0;
    for k = 1:3
        x = (1+x3(k)) * params.L / 2;
        Sx = shape_fun(x, params.L, 1);
        rx = S_e(Sx, e(istart:iend));
        le = le + w3(k) * norm(rx);
    end  
    
    l = l + le *params.L / 2;
end
