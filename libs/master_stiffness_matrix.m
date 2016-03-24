function K = master_stiffness_matrix(model)
    n = model.dimensions*numel(model.nodes);
    K = spalloc(n, n, (model.dimensions^2)*4*numel(model.elements));
    for e = 1:numel(model.elements)
        Ke = global_stiffness_matrix(model, e);
        EFT = element_freedom_table(model, e);
        for i = 1:(model.dimensions*2)
            for j = 1:(model.dimensions*2)
                p = EFT(i);
                q = EFT(j);
                K(p,q) = K(p,q) + Ke(i,j);
            end
        end
    end
end
