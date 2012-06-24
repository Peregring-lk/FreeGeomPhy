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
    error("hequation: expecting an index");
  endif

  if (idx(1).type == ".") # For internal purposes only.
    if (idx(1).subs == "hequation")
      v = he.hequation;
    elseif (idx(1).subs == "hfirst")
      v = he.hfirst;
    elseif (idx(1).subs == "hsecond")
      v = he.hsecond;
    elseif (idx(1).subs == "op")
      v = he.op;
    else
      error("hequation: invalid element access");
    endif
  elseif (idx(1).type == "{}")
    if (idx(1).subs{1} == 0)
      v = he.op;
    elseif (idx(1).subs{1} == 1)
      v = he.hfirst;
    elseif (idx(1).subs{1} == 2)
      v = he.hsecond;
    else
      error("hequation: invalid member access");
    endif
  elseif (idx(1).type == "()")
    v = he.hequation(idx(1).subs{:});
  else
    error("hequation: invalid subscript type");
  endif

endfunction