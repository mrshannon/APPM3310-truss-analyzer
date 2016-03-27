% model = solve_stresses(model)
%
%   Solve model for stresses.
%
% Inputs:
%   model:
%       Model structure (needs forces).
%
% Output:
%   model:
%       Model structure with stresses added.
%

% Copyright (c) 2016, Michael R. Shannon <mrshannon.aerospace@gmail.com>
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are
% met:
%
% 1. Redistributions of source code must retain the above copyright
%    notice, this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright
%    notice, this list of conditions and the following disclaimer in the
%    documentation and/or other materials provided with the distribution.
%
% 3. Neither the name of the copyright holder nor the names of its
%    contributors may be used to endorse or promote products derived
%    from this software without specific prior written permission.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
% A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
% HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
% SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
% LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
% DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
% THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
% (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
% OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function model = solve_stresses(model)
    for i = 1:numel(model.elements)

        % Extract element.
        element = model.elements(i);

        % Generate global displacement vector.
        u = zeros(2*model.dimensions, 1);
        ue = model.nodes(element.nodes(1)).delta;
        u(1:model.dimensions) = ue(1:model.dimensions);
        ue = model.nodes(element.nodes(2)).delta;
        u((1:model.dimensions) + model.dimensions) ...
            = ue(1:model.dimensions);

        % Calculate change in element length.
        T = transformation_matrix(model, i);
        ubar = T*u;
        d = ubar(model.dimensions+1) - ubar(1);

        % Find original length of element.
        p1 = model.nodes(element.nodes(1)).coords(1:model.dimensions);
        p2 = model.nodes(element.nodes(2)).coords(1:model.dimensions);
        L = norm(p2 - p1);

        % Extract modulus of elasticity.
        E = model.materials.(element.material).modulus;

        % Calculate stress in element.
        model.elements(i).stress = E*d/L;

    end
end
