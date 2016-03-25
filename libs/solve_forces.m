function model = solve_forces(model)
    for i = 1:numel(model.elements)

        % Extract element.
        element = model.elements(i);

        % Extract cross section area of element.
        A = model.materials.(element.material).area;

        % Calculate force in element.
        model.elements(i).force = A*element.stress;

    end
end
