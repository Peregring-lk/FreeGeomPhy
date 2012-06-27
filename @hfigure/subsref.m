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

function v = subsref(hfg, idx)

  if (isempty(idx))
    error("hsystem: subsref: expecting a index cell");
  endif

  if (idx(1).type == ".")
    switch (idx(1).subs)
      case "system"
        v = hfg.hsystem;
      case "dim"
        v = hfg.dim;
      case "origin"
        v = hfg.origin;
      case "scale"
        v = hfg.scale;
      case "alpha"
        v = hfg.alpha;
      case "beta"
        v = hfg.beta;
    endswitch
  elseif (idx(1).type == "{}")
    v = subsref(hfg.hsystem, idx);
  elseif (idx(1).type == "()")
    X = idx(1).subs{1};

    if (size(X, 1) != hfg.dim)
      error(["hfigure: subsref: expecting a matrix data of dimension " hfg.dim]);
    endif

    X -= hfg.origin;
    X = hfg.mrot * X;
    X /= scale;

    hfg.hsystem(X, idx(1).subs{2:end}{:});

  endif

endfunction