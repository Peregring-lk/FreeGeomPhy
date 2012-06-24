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

function hf = hfunction(arg, op)

  if (nargin == 0)
    hf = hfunction("x");
    return;
  endif

  if (isa(arg, "hfunction"))
    hf = arg;
  else
    if (is_function_handle(arg))
      hf.hfunction = inline([func2str(arg) "([x; y; z])"]);
      hf.op = "@";
    elseif (ischar(arg)) # For internal purposes only.
      hf.hfunction = inline(arg);

      if (isvarname(arg))
        hf.op = "@";
      else
        hf.op = "f";
      endif
    elseif (isnumeric(arg))
      hf.hfunction = inline(num2str(arg));
      hf.op = "@";
    else
      error("hfunction: expecting function handle, real number or variable name.");
    endif

    if (nargin == 2)
      hf.op = op;
    endif

    hf = class(hf, "hfunction");

  endif

endfunction