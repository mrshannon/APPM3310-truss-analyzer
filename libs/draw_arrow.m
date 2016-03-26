function h = draw_arrow(base, tip)

    switch numel(base)
        case 2
            h = quiver(base(1), base(2), tip(1)-base(1), tip(2)-base(2), 0);
        case 3
            error('3D arrow not implemented.')
        otherwise
            error('Invalid number of dimensions %d/', numel(base));
    end

end
