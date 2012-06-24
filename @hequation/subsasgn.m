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

function he = subsasgn(he, idx, rhs)

  if (isempty(idx))
    error("hequation: expecting an index");
  endif

  if (idx(1).type == "{}")
    op = he.op;
    first = he.hfirst;
    second = he.hsecond;

    if (idx(1).subs{1} == 0)
      op = rhs;
    elseif (idx(1).subs{1} == 1)
      first = rhs;
    elseif (idx(1).subs{1} == 2)
      second = rhs;
    else
      error("hequation: invalid member access");
    endif

    he = hequation(first, second, op);

  else
    error("hequation: invalid subscript type");
  endif

endfunction
