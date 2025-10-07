function triquiver(x,y,u,v,scale,headLength,headWidth,varargin)
%TRIQUIVER Draw triangular arrowheads instead of quiver arrows.
%
%   triquiver(x,y,u,v) draws triangles at (x,y) with direction (u,v).
%   The direction vectors (u,v) will be normalized automatically.
%
%   triquiver(x,y,u,v,scale,headLength,headWidth) allows control:
%       scale       : overall scale factor for all heads (default 1)
%       headLength  : triangle length (default 0.05 * axis span * scale)
%       headWidth   : triangle width  (default 0.04 * axis span * scale)
%
%   Additional plotting options can be passed as VARARGIN (e.g. 'FaceColor').
%
%   Example:
%       [X,Y] = meshgrid(-2:1:2,-2:1:2);
%       U = -Y; V = X;  % rotation field
%       figure; hold on; axis equal
%       triquiver(X,Y,U,V,1,[],[],'FaceColor','k')
%

if nargin < 5 || isempty(scale),      scale = 1; end
if nargin < 6, headLength = []; end
if nargin < 7, headWidth  = []; end

x = x(:); y = y(:); u = u(:); v = v(:);

% normalize vectors
m = hypot(u,v);
m(m==0) = 1;
u = u./m; v = v./m;

% axis scaling for consistent sizing
ax = axis;
span = max(ax(2)-ax(1), ax(4)-ax(3));

if isempty(headLength), headLength = 0.05*span*scale; end
if isempty(headWidth),  headWidth  = 0.04*span*scale; end

for k = 1:numel(x)
    % tip
    xt = x(k); yt = y(k);
    % base center
    xb = xt - headLength*u(k);
    yb = yt - headLength*v(k);
    % perpendicular
    px = -v(k); py = u(k);
    % base corners
    x1 = xb + 0.5*headWidth*px;
    y1 = yb + 0.5*headWidth*py;
    x2 = xb - 0.5*headWidth*px;
    y2 = yb - 0.5*headWidth*py;
    % draw
    patch([xt x1 x2],[yt y1 y2],'b','EdgeColor','none',varargin{:});
end
end
