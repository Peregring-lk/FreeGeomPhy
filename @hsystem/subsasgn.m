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
    error("hsystem: expecting an index");
  endif

  if (idx(1).type == "{}")
    if (idx(1).subs{1} > length(hs.equations))
      error("hsystem: invalid member access");
    endif

    if (idx(1).subs{1} == 0)
      hs.op = rhs;
    else
      idx1 = idx(1).subs{1};

      if (length(idx) > 1)
        if (idx(2).type != "{}")
          error("hsystem: invalid member access");
        else
          idx(1) = [];

          hs0 = subsasgn(hs.equations{idx1}, idx, rhs);
          hs.equations{idx1} = hs0;
        endif
      else
        hs.equations{idx1} = rhs;
      endif
    endif

    hs = hsystem(hs.op, hs.equations{:});

  else
    error("hsystem: invalid subscript type");
  endif

endfunction
