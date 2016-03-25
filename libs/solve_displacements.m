function model = solve_displacements(model)

    % Setup linear system.
    K = master_stiffness_matrix(model);
    K = modify_stiffness_matrix(model, K);
    f = force_vector(model);

    % Solve the system.
    if sprank(K) < size(K, 1)
        error('Stiffness matrix is singular.');
    end
    u = K\f;

    % Store displacements
    for i = 1:numel(model.nodes)
        idx = (i-1)*2 + [1:model.dimensions];
        delta = zeros(size(model.nodes(i).coords));
        delta(1:model.dimensions) = u(idx);
        model.nodes(i).delta = delta;
    end

end
