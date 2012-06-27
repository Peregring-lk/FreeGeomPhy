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

function v = subsref(he, idx)

  if (isempty(idx))
    error("hsystem: subsref: expecting a index cell");
  endif

  if (idx(1).type == "{}")
    switch(idx(1).subs{1})
      case 0
        v = he.op;
      case 1
        v = he.first;
      case 2
        v = he.second;
      otherwise
        error("hequation: subsref: invalid access subscript (permited values between 0 and 2)");
    endswitch
  elseif (idx(1).type == "()")
    v = he.hequation(idx(1).subs{:});
  else
    error("hequation: subsref: invalid access operator");
  endif

endfunction