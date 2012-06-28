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

function hs = subsasgn(hs, idx, rhs)

  if (isempty(idx))
    error("hsystem: subsasgn: expecting a index cell");
  endif

  if (idx(1).type != "{}")
    error("hsystem: subsasgn: invalid access operator");
  endif

  if (idx(1).subs{1} > 2)
    error("hsystem: subsasgn: invalid member access");
  endif

  if (idx(1).subs{1} == 0)
    if (!ischar(rhs))
      error("hsystem: subsasgn: expecting operator as string");
    endif

    hs.op = rhs;
  else
    idx1 = idx(1);

    if (length(idx) > 1)
      idx(1) = [];
      he = subsasgn(subsref(hs, idx1), idx, rhs);
      hs = subsasgn(hs, idx1, he);
    else
      if (!isa(rhs, "hequation") && !isa(rhs, "hsystem"))
        error("hsystem: subsagn: expecting an equation or system");
      endif

      if (idx1.subs{1} == 1)
        hs.hfirst = rhs;
      elseif (idx1.subs{1} == 2)
        hs.hsecond = rhs;
      else
        error("hsystem: subsasgn: invalid index access");
      endif

    endif

  endif

  if (isempty(hs.hsecond))
    hs = hsystem(hs.hfirst);
  else
    hs = hsystem(hs.op, hs.hfirst, hs.hsecond);
  endif

endfunction