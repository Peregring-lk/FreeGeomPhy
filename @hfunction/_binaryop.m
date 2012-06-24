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

function hf = _binaryop(a, b, op)

  if (!isa(a, "hfunction"))
    a = hfunction(a);
  endif

  if (!isa(b, "hfunction"))
    b = hfunction(b);
  endif

  str = char(a);

  if (_ispow(op))
    if (a.op == "@")
      str = [ str " " op " " ];
    else
      str = [ "(" str ")" " " op " " ];
    endif

    if (b.op == "@")
      str = [ str char(b) ];
    else
      str = [ str "(" char(b) ")" ];
    endif

  elseif (_ismul(op))
    if (_ispow(a.op) || _ismul(a.op) || a.op == "@")
      str = [ str " " op " " ];
    else
      str = [ "(" str ")" " " op " " ];
    endif

    if (_ispow(b.op) || _ismul(b.op) || b.op == "@")
      str = [ str char(b) ];
    else
      str = [ str "(" char(b) ")" ];
    endif

  else
    str = [ str " " op " " char(b) ];
  endif

  hf = hfunction(str, op);

endfunction

function b = _ispow(op)

  b = op == "^" || op == ".^";

endfunction

function b = _ismul(op)

  b = op == "*" || op == "/" || op == ".*" || op == "./";

endfunction