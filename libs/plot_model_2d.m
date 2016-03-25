function figure_handle = plot_model_2d(model)

    c = config();

    figure_handle = figure();
    hold on;

    % Plot nodes.
    coords = cat(1, model.nodes.coords);
    nodes_handle = plot(coords(:,1), coords(:,2), 'o');
    nodes_handle.Color = c.model_color;
    nodes_handle.MarkerFaceColor = c.model_color;

    % Fix axis bounds.
    coords = cat(1, model.nodes.coords);
    min_coords = min(coords, [], 1);
    max_coords = max(coords, [], 1);
    border = (max_coords - min_coords)*0.1;
    axis([min_coords(1)-border(1), max_coords(1)+border(1), ...
        min_coords(2)-border(2), max_coords(2)+border(2)]);

    % Plot elements.
    for i = 1:numel(model.elements)
        element = model.elements(i);
        p1 = model.nodes(element.nodes(1)).coords;
        p2 = model.nodes(element.nodes(2)).coords;
        coords = cat(1, p1, p2);
        element_handle = plot(coords(:,1), coords(:,2), '-');
        element_handle.Color = c.model_color;
    end

    % Plot constraints.
    for i = 1:numel(model.nodes)
        node = model.nodes(i);
        constraint = model.constraints.(node.constraint);
        coords = node.coords;
        w = c.constraint_size;
        if constraint(1)
            x = [coords(1), coords(1)];
            y = [coords(2)-border(2)*w, coords(2)+border(2)*w];
            h = plot(x, y);
            h.Color = c.constraint_color;
        end
        if constraint(2)
            x = [coords(1)-border(1)*w, coords(1)+border(1)*w];
            y = [coords(2), coords(2)];
            h = plot(x, y);
            h.Color = c.constraint_color;
        end
    end

    % Set labels and grid.
    xlabel('x');
    ylabel_handle = ylabel('y');
    ylabel_handle.Rotation = 0;
    grid;

end
