function Ke = global_stiffness_matrix(model, element_number)
    T = transformation_matrix(model, element_number);
    Kbar = local_stiffness_matrix(model, element_number);
    Ke = transpose(T)*Kbar*T;
end
