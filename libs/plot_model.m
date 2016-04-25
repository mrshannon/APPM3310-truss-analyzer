% figure_handle = plot_model(model, plot_result)
%
%   Draw truss and optionally loaded model with colormapped stresses.
%
% Inputs:
%   model:
%       Model structure.
%
%   plot_result:
%       True if the result is to be plotted.  False to only plot the
%       unloaded truss.
%
% Output:
%   figure_handle:
%       Handle to figure where model is plotted.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function figure_handle = plot_model(model, plot_result)

    c = config();
    c.plot_result = plot_result;

    c.figure_handle = figure();
    hold on;

    [c.axis_bounds, c.border] = ...
        compute_axis_bounds(model, c);

    plot_forces(model, c);
    plot_initial_nodes(model, c);
    plot_initial_elements(model, c);

    if plot_result
        set_colorbar(model, c);
        plot_result_elements(model, c);
        plot_result_nodes(model, c);
    end

    plot_constraints(model, c);
    set_labels(model, c);

    figure_handle = c.figure_handle;

end


% [axis_bounds, border] = compute_axis_bounds(model, c)
%
%   Draw truss and optionally loaded model with color-mapped stresses.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
% Output:
%   axis_bounds:
%       Axis bounds for use by axis function.
%
%   border:
%       Scalar border width around truss plot.
%
function [axis_bounds, border] = ...
        compute_axis_bounds(model, c)

    % Compute minimum and maximum coordinates for nodes.
    coords = cat(1, model.nodes.coords);
    if c.plot_result
        delta = cat(1, model.nodes.delta);
        coords = cat(1, coords, coords+delta);
    end
    min_coords = min(coords, [], 1);
    max_coords = max(coords, [], 1);

    % Compute border width.
    border = (max_coords - min_coords)*c.border_width;
    border = border(1:model.dimensions);
    border = mean(border);

    % Compute axis bounds.
    axis_bounds = [];
    for i = 1:model.dimensions
        axis_bounds = cat(2, axis_bounds, ...
            [min_coords(i)-border, max_coords(i)+border]);
    end
end


% plot_forces(model, c)
%
%   Plot force vectors.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function plot_forces(model, c)

    % Compute maximum force.
    max_force = max(sqrt(sum(cat(1, model.forces.vector).^2, 2)));

    % Loop over each force.
    for i = 1:numel(model.forces)

        % Compute base of force vector.
        base = model.nodes(model.forces(i).node).coords;
        if c.plot_result
            base = base + model.nodes(model.forces(i).node).delta;
        end
        base = base(1:model.dimensions);

        % Compute length and tip of force vector (not based on force).
        vector = model.forces(i).vector(1:model.dimensions);
        vector = vector/max_force*c.border*0.75;
        tip = base + vector;

        % Draw vector.
        h = draw_arrow(base, tip);
        h.Color = c.force_color;
        h.LineWidth = c.force_width;
        h.MaxHeadSize = c.force_arrow_size;

        % Draw label.
        str = sprintf('F_{%d}', i);
        unit_vector = vector/norm(vector)*c.border;
        switch model.dimensions
            case 2
                h = text(...
                    tip(1) + unit_vector(1)*0.15, ...
                    tip(2) + unit_vector(2)*0.15, str);
            case 3
                h = text(...
                    tip(1) + unit_vector(1)*0.15, ...
                    tip(2) + unit_vector(2)*0.15, ...
                    tip(3) + unit_vector(3)*0.15, str);
        end
        h.VerticalAlignment = 'middle';
        h.HorizontalAlignment = 'center';
    end
end


% plot_initial_nodes(model, c)
%
%   Plot nodes of unloaded truss.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function plot_initial_nodes(model, c)
    coords = cat(1, model.nodes.coords);
    switch model.dimensions
        case 2
            h = plot(coords(:,1), coords(:,2), 'o');
        case 3
            h = plot3(coords(:,1), coords(:,2), coords(:,3), 'o');
    end
    h.Color = c.model_color;
    h.MarkerFaceColor = c.model_color;
end


% plot_initial_elements(model, c)
%
%   Plot elements of unloaded truss.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function plot_initial_elements(model, c)
    for i = 1:numel(model.elements)
        element = model.elements(i);
        p1 = model.nodes(element.nodes(1)).coords;
        p2 = model.nodes(element.nodes(2)).coords;
        coords = cat(1, p1, p2);
        switch model.dimensions
            case 2
                h = plot(coords(:,1), coords(:,2), '-');
            case 3
                h = plot3(coords(:,1), coords(:,2), coords(:, 3), '-');
        end
        h.Color = c.model_color;
        h.LineWidth = c.element_width;
    end
end


% set_colorbar(model, c)
%
%   Setup colorbar for stresses.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function set_colorbar(model, c)
    colormap(c.colormap);
    stresses = cat(1, model.elements.stress);
    min_stress = min(stresses);
    max_stress = max(stresses);
    stress_bound = max(abs(cat(1, min_stress, max_stress)));
    caxis([-stress_bound, stress_bound]);
    xlabel(colorbar(), '\sigma', 'Rotation', 0, 'FontSize', 12);
end


% plot_result_elements(model, c)
%
%   Plot stress color-coded elements of loaded truss.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function plot_result_elements(model, c)
    for i = 1:numel(model.elements)
        element = model.elements(i);
        p1 = model.nodes(element.nodes(1)).coords + ...
            model.nodes(element.nodes(1)).delta;
        p2 = model.nodes(element.nodes(2)).coords + ...;
            model.nodes(element.nodes(2)).delta;
        coords = cat(1, p1, p2);
        switch model.dimensions
            case 2
                h = plot(coords(:,1), coords(:,2), '-');
            case 3
                h = plot3(coords(:,1), coords(:,2), coords(:, 3), '-');
        end
        h.Color = colormap_lookup(element.stress);
        h.LineWidth = c.element_width;
    end
end


% plot_result_nodes(model, c)
%
%   Plot displaced nodes of loaded truss.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function plot_result_nodes(model, c)
    coords = cat(1, model.nodes.coords) + cat(1, model.nodes.delta);
    switch model.dimensions
        case 2
            h = plot(coords(:,1), coords(:,2), 'o');
        case 3
            h = plot3(coords(:,1), coords(:,2), coords(:,3), 'o');
    end
    h.Color = c.result_node_color;
    h.MarkerFaceColor = c.result_node_color;
end


% plot_constraints(model, c)
%
%   Plot constraints.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function plot_constraints(model, c)
    for i = 1:numel(model.nodes)
        node = model.nodes(i);
        constraint = model.constraints.(node.constraint);
        coords = node.coords;
        switch model.dimensions
            case 2
                plot_constraint_2d(c, coords, constraint);
            case 3
                plot_constraint_3d(c, coords, constraint);
        end
    end
end


% plot_constraint_2d(c, coords, constraint)
%
%   Plot a 2D constraint.
%
% Inputs:
%   c:
%       Configuration structure.
%
%   coords:
%       2 element coordinate vector of location of constraint.
%
%   constraint:
%       2 element boolean constraint vector.  True is constraint, false
%       is unconstrained.
%
function plot_constraint_2d(c, coords, constraint)

    w = c.constraint_size;

    % Plot x-constraint.
    if constraint(1)
        x = [coords(1), coords(1)];
        y = [coords(2)-c.border*w, coords(2)+c.border*w];
        h = plot(x, y);
        h.Color = c.constraint_color;
    end

    % Plot y-constraint.
    if constraint(2)
        x = [coords(1)-c.border*w, coords(1)+c.border*w];
        y = [coords(2), coords(2)];
        h = plot(x, y);
        h.Color = c.constraint_color;
    end
end


% plot_constraint_3d(c, coords, constraint)
%
%   Plot a 3D constraint.
%
% Inputs:
%   c:
%       Configuration structure.
%
%   coords:
%       3 element coordinate vector of location of constraint.
%
%   constraint:
%       3 element boolean constraint vector.  True is constraint, false
%       is unconstrained.
%
function plot_constraint_3d(c, coords, constraint)

    w = c.constraint_size;

    % Plot x-constraint.
    if constraint(1)
        x = [coords(1), coords(1), coords(1), coords(1)];
        y = [coords(2)-c.border*w, coords(2)+c.border*w ...
             coords(2)+c.border*w, coords(2)-c.border*w];
        z = [coords(3)-c.border*w, coords(3)-c.border*w ...
             coords(3)+c.border*w, coords(3)+c.border*w];
        h = fill3(x, y, z, c.constraint_color_3d);
        h.EdgeColor = c.constraint_color;
    end

    % Plot y-constraint.
    if constraint(2)
        x = [coords(1)-c.border*w, coords(1)+c.border*w ...
             coords(1)+c.border*w, coords(1)-c.border*w];
        y = [coords(2), coords(2), coords(2), coords(2)];
        z = [coords(3)-c.border*w, coords(3)-c.border*w ...
             coords(3)+c.border*w, coords(3)+c.border*w];
        h = fill3(x, y, z, c.constraint_color_3d);
        h.EdgeColor = c.constraint_color;
    end

    % Plot z-constraint.
    if constraint(3)
        x = [coords(1)-c.border*w, coords(1)+c.border*w ...
             coords(1)+c.border*w, coords(1)-c.border*w];
        y = [coords(2)-c.border*w, coords(2)-c.border*w ...
             coords(2)+c.border*w, coords(2)+c.border*w];
        z = [coords(3), coords(3), coords(3), coords(3)];
        h = fill3(x, y, z, c.constraint_color_3d);
        h.EdgeColor = c.constraint_color;
    end

    % Plot xy-constraint line.
    if constraint(1) && constraint(2)
        x = [coords(1), coords(1)];
        y = [coords(2), coords(2)];
        z = [coords(3)-c.border*w, coords(3)+c.border*w];
        h = plot3(x, y, z);
        h.Color = c.constraint_color;
    end

    % Plot xz-constraint line.
    if constraint(1) && constraint(3)
        x = [coords(1), coords(1)];
        y = [coords(2)-c.border*w, coords(2)+c.border*w];
        z = [coords(3), coords(3)];
        h = plot3(x, y, z);
        h.Color = c.constraint_color;
    end

    % Plot yz-constraint line.
    if constraint(2) && constraint(3)
        x = [coords(1)-c.border*w, coords(1)+c.border*w];
        y = [coords(2), coords(2)];
        z = [coords(3), coords(3)];
        h = plot3(x, y, z);
        h.Color = c.constraint_color;
    end
end


% plot_constraints(model, c)
%
%   Set labels, axes bounds, and grids.
%
% Inputs:
%   model:
%       Model structure.
%
%   c:
%       Configuration structure.
%
function set_labels(model, c)
    axis equal;
    xlabel('x');
    ylabel_handle = ylabel('y');
    ylabel_handle.Rotation = 0;
    view(model.dimensions);
    axis(c.axis_bounds);
    grid;
    grid minor;
    c.figure_handle.Color = [1.0, 1.0, 1.0];
end
