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

function plot3(hf, xmin, step, xmax, strtitle, varargin)

  if (nargin < 4)
    error("hfunction: plot: need almost four parameters");
  endif

  if (!isscalar(xmin))
    error("hfunction: plot: expecting a scalar value as min");
  endif

  if (!isscalar(step))
    error("hfunction: plot: expecting a scalar value as step");
  endif

  if (!isscalar(xmax))
    error("hfunction: plot: expecting a scalar value as max");
  endif

  if (nargin < 5)
    strtitle = "";
  elseif (!ischar(strtitle))
    varargin = { strtitle varargin{:} };
    strtitle = "";
  endif

  graphics_toolkit("fltk");

  lx = xmin:step:xmax;
  ly = lx;

  [x y] = meshgrid(lx, ly);

  xx = x(:);
  yy = y(:);

  X = [xx yy]';

  ## Get solutions.
  idx.type = "()";
  idx.subs = { X, varargin{:} };

  zz = subsref(hf, idx)(:);

  ## Plotting
  hold on;

  xylim = [ xmin xmax ];
  zzlim = [ min(zz) max(zz) ];

  zz = reshape(zz, size(x));

  meshc(x, y, zz);

  set(gca, "box", "off");
  set(gca, "drawmode", "fast");

  xlim(xylim);
  ylim(xylim);
  zlim(zzlim);

  xlabel("x");
  ylabel("y");
  zlabel("z");

  axis tight;
  view(30, 30);

  grid;

  ## Set parameters.
  if (numel(varargin) > 0)
    strparams = "";

    args = { argnames(hf){2:end} };

    if (ischar(args))
      args = { args };
    endif

    for i = 1:numel(varargin)
      strparams = [ strparams args{i} " = " ];
      strparams = [ strparams num2str(varargin{i}) ", " ];
    endfor

    strparams = strparams(1:end - 2);

    strstdtitle = [ char(hf) "   with   " strparams ];
  else
    strstdtitle = char(hf);
  endif

  ## Set title.
  if (!strcmp(strtitle, ""))
    strtitle = [ strtitle "\n" strstdtitle ];
  else
    strtitle = strstdtitle;
  endif

  title(strtitle);

  hold off;

endfunction