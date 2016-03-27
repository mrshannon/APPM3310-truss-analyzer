% model = solve_displacements(model)
%
%   Solve model for displacements.
%
% Inputs:
%   model:
%       Model structure.
%
% Output:
%   model:
%       Model structure with displacements added.
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

function model = solve_displacements(model)

    % Setup linear system.
    K = master_stiffness_matrix(model);
    K = modify_stiffness_matrix(model, K);
    f = force_vector(model);

    % Solve the system.
    if sprank(K) < size(K, 1)
        error('Stiffness matrix is singular.');
    end
    u = K\f;

    % Store displacements
    for i = 1:numel(model.nodes)
        idx = (i-1)*model.dimensions + (1:model.dimensions);
        delta = zeros(size(model.nodes(i).coords));
        delta(1:model.dimensions) = u(idx);
        model.nodes(i).delta = delta;
    end

end
