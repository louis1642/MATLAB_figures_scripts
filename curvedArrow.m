function h = curvedArrow(p0, p1, varargin)
%CURVEDARROW  Draw a curved arrow from p0 -> p1 in the current axes.
% p0, p1 : 1x2 [x y]
% Options (name/value): 
%   'Curvature'  (default 0.25)  % + bends left of (p1-p0), - bends right
%   'HeadLength' (default 0.12)   % in axis data units
%   'HeadWidth'  (default 0.10)
%   'N'          (default 100)    % points along the curve
%   'Color'      (default [0 0 0])
%   'LineWidth'  (default 1.5)

% Parse
p = inputParser;
p.addParameter('Curvature',0.25,@isnumeric);
p.addParameter('HeadLength',0.12,@isnumeric);
p.addParameter('HeadWidth',0.10,@isnumeric);
p.addParameter('N',100,@(x)isnumeric(x)&&x>1);
p.addParameter('Color',[0 0 0],@(c)isnumeric(c)&&numel(c)==3);
p.addParameter('LineWidth',1.5,@isnumeric);
p.parse(varargin{:});
opt = p.Results;

ax = gca; hold(ax,'on');

% Control point for a quadratic Bézier: mid + curvature * perp
v = p1 - p0;                               % direction p0->p1
mid = (p0 + p1)/2;
perp = [ -v(2), v(1) ];                    % 90° left of v
if norm(perp) > 0, perp = perp / norm(perp); end
c = mid + opt.Curvature * norm(v) * perp;  % control point

% Bézier points
t = linspace(0,1,opt.N).';
B = (1-t).^2 .* p0 + 2*(1-t).*t .* c + t.^2 .* p1;

% Plot the curve (without the very last bit so the head sits cleanly)
h.line = plot(B(1:end-1,1), B(1:end-1,2), '-', ...
    'Color', opt.Color, 'LineWidth', opt.LineWidth);

% Tangent at the end (t=1) for head orientation: dB/dt = 2(1-t)(c-p0)+2t(p1-c)
t1 = 0.999; % near the end
dB = 2*(1-t1)*(c - p0) + 2*t1*(p1 - c);
if norm(dB) == 0, dB = v; end
dir = dB / norm(dB);

% Build arrowhead triangle at p1
HL = opt.HeadLength;  HW = opt.HeadWidth;
base = p1 - HL * dir;
perpDir = [-dir(2), dir(1)];
pA = p1;                          % tip
pB = base + (HW/2)*perpDir;       % left
pC = base - (HW/2)*perpDir;       % right
h.head = patch([pA(1) pB(1) pC(1)], [pA(2) pB(2) pC(2)], opt.Color, ...
               'EdgeColor', 'none');

axis(ax,'equal'); % nice proportions
end
