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

function v = subsref(hg, idx)

  warning("off", "Octave:broadcast");

  if (idx(1).type == ".")
    switch (idx(1).subs{1})
      case "origin"
        v = hg.origin;
      case "scale"
        v = hg.scale;
      case "alpha"
        v = hg.alpha;
      case "beta"
        v = hg.beta;
      otherwise
        error("hfigure: subsref: invalid object access");
    endswitch
  else
    x = idx(1).subs{1};

    x -= hg.origin;
    x = hg.rotm * x;
    x /= hg.scale;

    v = hg.hsystem(x, idx(1).subs{2:end});
  endif

endfunction
