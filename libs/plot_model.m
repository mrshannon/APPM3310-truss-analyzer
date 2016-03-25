function figure_handle = plot_model(model)
    switch model.dimensions
        case 2
            figure_handle = plot_model_2d(model);
        case 3
            figure_handle = plot_model_3d(model);
    end
end
