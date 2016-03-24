function model = load_model(file)
    raw = parse_json(fileread(file));
    raw = raw{1};
    model.dimensions = raw.dimensions;
    model.nodes = fix_nodes(raw.nodes);
    model.elements = fix_elements(raw.elements);
    model.materials = raw.materials;
    model.forces = fix_forces(raw.forces);
    model.constraints = fix_constraints(raw.constraints);
end


function nodes = fix_nodes(nodes)
    nodes = cell2mat(nodes);
    for i = 1:numel(nodes)
        nodes(i).coords = cell2mat(nodes(i).coords);
    end
end


function elements = fix_elements(elements)
    elements = cell2mat(elements);
    for i = 1:numel(elements)
        elements(i).nodes = sort(cell2mat(elements(i).nodes));
    end
end


function forces = fix_forces(forces)
    forces = cell2mat(forces);
    for i = 1:numel(forces)
        forces(i).vector = cell2mat(forces(i).vector);
    end
end


function constraints = fix_constraints(constraints)
    fields = fieldnames(constraints);
    for i = 1:numel(fields)
        constraints.(fields{i}) = cell2mat(constraints.(fields{i}));
    end
end
