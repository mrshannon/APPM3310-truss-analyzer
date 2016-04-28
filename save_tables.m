% save_tables(prefix, model)
%
%   Save model solution into csv tables.
%
% Input:
%   prefix:
%       Prefix path to save tables to.
%
%   model:
%       Model structure.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function save_tables(prefix, model)

    nodes_filename = sprintf('%s_nodes.csv', prefix);
    fid = fopen(nodes_filename, 'w');
    fprintf(fid, ['node,        x,        y,        z,', ...
        '       dx,       dy,       dz\n']);
    for idx = 1:numel(model.nodes)
        node = model.nodes(idx);
        fprintf(fid, ...
            '%4d, %8.4f, %8.4f, %8.4f, %8.4f, %8.4f, %8.4f\n', ...
            idx, node.coords(1), node.coords(2), node.coords(3), ...
            node.delta(1), node.delta(2), node.delta(3));
    end
    fclose(fid);

    elements_filename = sprintf('%s_elements.csv', prefix);
    fid = fopen(elements_filename, 'w');
    fprintf(fid, ['element, material, firstnode, secondnode,', ...
        '     stress,      force\n']);
    for idx = 1:numel(model.elements)
        element = model.elements(idx);
        fprintf(fid, '%7d, % 8s, %9d, %10d, %10.4f, %10.4f\n', ...
            idx, element.material, ...
            element.nodes(1), element.nodes(2), ...
            element.stress, element.force);
    end
    fclose(fid);

end
