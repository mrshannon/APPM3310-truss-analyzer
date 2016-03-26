function rgb = colormap_lookup(value)
    color_axis = caxis();
    colormap_table = colormap();
    idx = linspace(color_axis(1), color_axis(2), ...
        size(colormap_table, 1));
    rgb = interp1(idx, colormap_table, value);
end
