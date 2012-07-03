## Copyright (C) 2012 Aarón Bueno Villares
##
## This file is part of FreeGeomPhy.
##
## FreeGeomPhy is free software; you can redistribute it and/or
## modify it under the terms of the GNU General Public
## License as published by the Free Software Foundation;
## either version 3 of the License, or (at your option) any
## later version.
##
## FreeGeomPhy is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied
## warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
## PURPOSE.  See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public
## License along with FreeGeomPhy; see the file COPYING.  If not,
## see <http://www.gnu.org/licenses/>.

## FIX: Sobresimplified version
function plot(hfg, min, step, max, stitle)

  if (nargin < 4)
    error("hfigure: plot: need almost four parameters");
  endif

  if (!isscalar(min))
    error("hfigure: plot: expecting a scalar value as min");
  endif

  if (!isscalar(step))
    error("hfigure: plot: expecting a scalar value as step");
  endif

  if (!isscalar(max))
    error("hfigure: plot: expecting a scalar value as max");
  endif

  if (nargin < 5)
    stitle = struct();
  elseif (!isstruct(stitle))
    error("hfigure: plot: expecting a struct as stitle");
  endif

  graphics_toolkit("fltk");

  lx = min:step:max;
  ly = lx;
  lz = lx;

  [x y z] = meshgrid(lx, ly, lz);

  xx = x(:);
  yy = y(:);
  zz = z(:);

  X = [xx yy zz]';

  ## Get solutions.
  idx.type = "()";
  idx.subs = { X };

  s = subsref(hfg, idx);

  finds = X(:, find(s));

  ## Plot figure.
  K = convhulln(finds');

  ## Plotting
  hold on;

  H = trisurf(K, finds(1, :), finds(2, :), finds(3, :));

  shading("interp");
  set(H, "edgealpha", 0.9);

  hFig = ancestor(H, "figure");
  set(hFig, "renderermode", "manual");
  set(hFig, "renderer", "opengl");

  set(gca, "box", "off");
  set(gca, "drawmode", "fast");

  ## Contour
  H1 = tricontour(K, finds(1, :), finds(2, :), finds(3, :), 10, 'r');

  pointsH1 = length(get(H1, "ydata"));

  lim = [min max];
  set(H1, "zdata", lim(1) .* ones(1, pointsH1));

  xlim(lim);
  ylim(lim);
  zlim(lim);

  xlabel("x");
  ylabel("y");
  zlabel("z");

  axis equal;
  view(30, 30);

  grid;

  ## Set title (making string)
  ## Type
  if (isfield(stitle, "type"))
    if (strcmp(stitle.type, "disable"))
      strtype = "";
    else
      strtype = [ "(" stitle.type ")" ];
    endif
  else
    strtype = [ "(unespecified type)" ];
  endif

  ## Others properties
  otherfields = fieldnames(stitle);
  strextra = "";

  if (!isempty(otherfields))
    otherfields = setdiff(otherfields, { "type", "scale", "origin", "alpha", "beta" });
  endif

  if (numel(otherfields) > 0)
    strfield = otherfields{1};
    val = getfield(stitle, strfield);

    strextra = [ strfield ": " ];

    if (ischar(val))
      strextra = [ strextra val];
    elseif (isscalar(val))
      strextra = [ strextra num2str(val)];
    elseif (isnumeric(val))
      strextra = [ strextra "(" ];

      for j = 1:numel(val) - 1
        strextra = [ strextra val(j) " " ];
      endfor

      strextra = [ strextra val(numel(var)) ")" ];
    else
      error("hfigure: plot: expecting a string, scalar or numeric vector in ctitle structure");
    endif

    for i = 2:numel(otherfields)
      strfield = otherfields{i};
      val = getfield(stitle, strfield);

      strextra = [ ", " strextra strfield ": " ];

      if (ischar(val))
        strextra = [ strextra val ];
      elseif (isscalar(val))
        strextra = [ strextra num2str(var) ];
      elseif (isnumeric(val))
        strextra = [ strextra "(" ];

        for j = 1:numel(val) - 1
          strextra = [ strextra val(j) " " ];
        endfor

        strextra = [ strextra val(numel(var)) ")" ];
      else
        error("hfigure: plot: expecting a string, scalar or numeric vector in ctitle structure");
      endif
    endfor
  endif

  ## Origin
  strorigin = "dummy";

  if (isfield(stitle, "origin") && strcmp(stitle.origin, "disable"))
    strorigin = "";
  endif

  if (!strcmp(strorigin, ""))
    strorigin = [ "origin: (" num2str(hfg.origin(1)) " " num2str(hfg.origin(2)) ];

    if (hfg.dim == 3)
      strorigin = [ strorigin " " num2str(hfg.origin(3)) ];
    endif

    strorigin = [ strorigin ")" ];
  endif

  ## Scale
  strscale = "dummy";

  if (isfield(stitle, "scale") && strcmp(stitle.scale, "disable"))
    strscale = "";
  endif

  if (!strcmp(strscale, ""))
    if (isscalar(hfg.scale))
      strscale = [ "scale: " num2str(hfg.scale) ];
    else
      strscale = [ "scale: (" num2str(hfg.scale(1)) " " num2str(hfg.scale(2)) ];

      if (hfg.dim == 3)
        strscale = [ strscale " " num2str(hfg.scale(3)) ];
      endif

      strscale = [ strscale ")" ];
    endif
  endif

  ## Angles.
  strangles = "dummy";

  if (isfield(stitle, "angles") && strcmp(stitle.alpha, "disable"))
      strangles = "";
  endif

  if (!strcmp(strangles, ""))
    if (hfg.dim == 2)
      strangles = [ "alpha: ", num2str(hfg.alpha) ];
    else
      strangles = [ "(alpha, beta) = (" num2str(hfg.alpha) " " num2str(hfg.beta) ")" ];
    endif
  endif

  strtitle = strtype;

  if (!strcmp(strorigin, ""))
    strtitle = [ strtitle " " strorigin ];
  endif

  if (!strcmp(strextra, ""))
    strtitle = [ strtitle ", " strextra ];
  endif

  if (!strcmp(strscale, ""))
    strtitle = [ strtitle ", " strscale ];
  endif

  if (!strcmp(strangles, ""))
    strtitle = [ strtitle ", " strangles ];
  endif

  title(strtitle);

  hold off;

endfunction