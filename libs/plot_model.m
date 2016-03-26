function figure_handle = plot_model(model, plot_result)
    switch model.dimensions
        case 2
            figure_handle = plot_model_2d(model, plot_result);
        case 3
            figure_handle = plot_model_3d(model, plot_result);
    end
end
