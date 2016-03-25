function model = solve_model(model)
    model = solve_displacements(model);
    model = solve_stresses(model);
    model = solve_forces(model);
end
