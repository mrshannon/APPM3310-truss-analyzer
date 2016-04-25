% lint()
%
%   Run checkcode on each file in the project.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% This Source Code Form is subject to the terms of the Mozilla Public
% License, v. 2.0. If a copy of the MPL was not distributed with this
% file, You can obtain one at http://mozilla.org/MPL/2.0/.

function lint()
    files = dir('*.m');
    files = cat(1, files, dir('libs/*.m'));
    files = {files.name};
    checkcode(files{:});
end
