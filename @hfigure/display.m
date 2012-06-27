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

function display(hfs)

  disp("analytic description: "), display(hfs.hsystem);
  disp(["dimension: " num2str(hfs.dim)]);
  disp("origin: "), disp(hfs.origin);

  if (isscalar(hfs.scale))
    disp(["scale: ", num2str(hfs.scale)]);
  else
    disp("scale: "), disp(hfs.scale);
  endif

  disp(["horizontal angle (rad): ", num2str(hfs.alpha)]);

  if (hfs.dim == 3)
    disp(["vertical angle (rad): ", num2str(hfs.beta)]);
  endif

endfunction