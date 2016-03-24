function Kbar = local_stiffness_matrix(model, element_number)
    element = model.elements(element_number);
    material = model.materials.(element.material);
    E = material.modulus;
    A = material.area;
    p1 = model.nodes(element.nodes(1)).coords(1:model.dimensions);
    p2 = model.nodes(element.nodes(2)).coords(1:model.dimensions);
    L = norm(p2 - p1);
    Kbar = (E*A)/L * template_matrix(model.dimensions);
end


function tmp_mat = template_matrix(dimensions)
    tmp_mat = zeros(dimensions);
    tmp_mat(1,1) = 1;
    tmp_mat = [tmp_mat, -tmp_mat; -tmp_mat, tmp_mat];
end
