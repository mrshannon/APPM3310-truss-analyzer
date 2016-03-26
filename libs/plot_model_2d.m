function figure_handle = plot_model_2d(model, plot_result)

    c = config();

    figure_handle = figure();
    hold on;

    [c.axis_bounds, c.border] = compute_axis_bounds(model, c);

    plot_forces(model, c, plot_result);
    plot_initial_nodes(model, c);
    plot_initial_elements(model, c);

    if plot_result
        set_colorbar(model, c);
        plot_result_elements(model, c);
        plot_result_nodes(model, c);
    end

    plot_constraints(model, c);
    set_labels(c);

end


function [axis_bounds, border] = compute_axis_bounds(model, c)
    coords = cat(1, model.nodes.coords);
    min_coords = min(coords, [], 1);
    max_coords = max(coords, [], 1);
    border = (max_coords - min_coords)*c.border_width;
    axis_bounds = ...
        [min_coords(1)-border(1), max_coords(1)+border(1), ...
         min_coords(2)-border(2), max_coords(2)+border(2)];
end


function plot_initial_nodes(model, c)
    coords = cat(1, model.nodes.coords);
    nodes_handle = plot(coords(:,1), coords(:,2), 'o');
    nodes_handle.Color = c.model_color;
    nodes_handle.MarkerFaceColor = c.model_color;
end


function plot_result_nodes(model, c)
    coords = cat(1, model.nodes.coords) + cat(1, model.nodes.delta);
    nodes_handle = plot(coords(:,1), coords(:,2), 'o');
    nodes_handle.Color = c.result_node_color;
    nodes_handle.MarkerFaceColor = c.result_node_color;
end


function set_colorbar(model, c)
    colormap(c.colormap);
    stresses = cat(1, model.elements.stress);
    min_stress = min(stresses);
    max_stress = max(stresses);
    caxis([min_stress, max_stress]);
    xlabel(colorbar(), '\sigma', 'Rotation', 0, 'FontSize', 12);
end


function plot_initial_elements(model, c)
    for i = 1:numel(model.elements)
        element = model.elements(i);
        p1 = model.nodes(element.nodes(1)).coords;
        p2 = model.nodes(element.nodes(2)).coords;
        coords = cat(1, p1, p2);
        element_handle = plot(coords(:,1), coords(:,2), '-');
        element_handle.Color = c.model_color;
        element_handle.LineWidth = c.element_width;
    end
end


function plot_result_elements(model, c)
    for i = 1:numel(model.elements)
        element = model.elements(i);
        p1 = model.nodes(element.nodes(1)).coords + ...
            model.nodes(element.nodes(1)).delta;
        p2 = model.nodes(element.nodes(2)).coords + ...;
            model.nodes(element.nodes(2)).delta;
        coords = cat(1, p1, p2);
        element_handle = plot(coords(:,1), coords(:,2), '-');
        element_handle.Color = colormap_lookup(element.stress);
        element_handle.LineWidth = c.element_width;
    end
end


function plot_forces(model, c, plot_result)
    for i = 1:numel(model.forces)
        base = model.nodes(model.forces(i).node).coords;
        if plot_result
            base = base + model.nodes(model.forces(i).node).delta;
        end
        base = base(1:2);
        vector = model.forces(i).vector(1:2);
        vector = vector/norm(vector)*mean(c.border)*0.75;
        tip = base + vector;
        h = draw_arrow(base, tip);
        h.Color = c.force_color;
        h.LineWidth = c.force_width;
        h.MaxHeadSize = c.force_arrow_size;
        h = text(tip(1) + vector(1)*0.5, tip(2) + vector(2)*0.5, ...
            sprintf('F_{%d}', i));
        h.VerticalAlignment = 'middle';
        h.HorizontalAlignment = 'center';
    end
end


function plot_constraints(model, c)
    for i = 1:numel(model.nodes)
        node = model.nodes(i);
        constraint = model.constraints.(node.constraint);
        coords = node.coords;
        w = c.constraint_size;
        if constraint(1)
            x = [coords(1), coords(1)];
            y = [coords(2)-c.border(2)*w, coords(2)+c.border(2)*w];
            h = plot(x, y);
            h.Color = c.constraint_color;
        end
        if constraint(2)
            x = [coords(1)-c.border(1)*w, coords(1)+c.border(1)*w];
            y = [coords(2), coords(2)];
            h = plot(x, y);
            h.Color = c.constraint_color;
        end
    end
end


function set_labels(c)
    axis(c.axis_bounds);
    xlabel('x');
    ylabel_handle = ylabel('y');
    ylabel_handle.Rotation = 0;
    grid;
    axis equal;
end
