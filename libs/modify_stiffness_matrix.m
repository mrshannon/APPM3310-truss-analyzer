function K = modify_stiffness_matrix(model, K)
    for i = 1:numel(model.nodes)
        node = model.nodes(i);
        idx = (1:model.dimensions) + model.dimensions*(i-1);
        constraint = model.constraints.(node.constraint);
        constraint = constraint(1:model.dimensions);
        constraint_idx = idx(constraint);
        for j = constraint_idx
            K(j,:) = 0;
            K(:,j) = 0;
            K(j,j) = 1;
        end
    end
end
