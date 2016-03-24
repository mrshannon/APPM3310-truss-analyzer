function T = transformation_matrix(model, element_number)

    element = model.elements(element_number);
    p1 = model.nodes(element.nodes(1)).coords;
    p2 = model.nodes(element.nodes(2)).coords;
    v = p2-p1;
    u = v/norm(v);
    tmp = [u; null(u)'];
    T = [tmp, eye(size(tmp)); eye(size(tmp)), tmp];

end
