function EFT = element_freedom_table(model, element_number)
    element = model.elements(element_number);
    EFT = repmat((element.nodes-1)*model.dimensions, ...
        model.dimensions, 1);
    EFT = EFT + repmat((1:model.dimensions)', 1, 2);
    EFT = reshape(EFT, 1, []);
end
