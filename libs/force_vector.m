% f = force_vector(model)
%
%   This function generates the modified force vector for use with the
%   modified stiffness matrix.
%
function f = force_vector(model)
    f = zeros(numel(model.nodes)*model.dimensions, 1);
    for force = model.forces
        idx = (force.node-1)*model.dimensions + (1:model.dimensions);
        f(idx) = force.vector(1:model.dimensions);
    end
end
