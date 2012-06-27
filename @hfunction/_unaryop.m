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

function hf = _unaryop(hf, op)

  hf = hfunction(hf);

  ## Brackets discrimination
  brackets = false;
  idxop = _idxop(op);

  if (idxop < hf.idxop)
    brackets = true;
  endif

  ## Making the function (string for inline)
  str = char(hf);

  if (brackets)
    str = [ "(" str ")" ];
  endif

  str = [ op str ];

  ## Making hfunction
  hf = hfunction(str, idxop, argnames(hf){:});

endfunction

function p = _idxop(op)

  if (op == "'" || op == ".'")
    p = 2;
  elseif (op == "+" || op == "-" || op == "!")
    p = 3;
  else
    error("_unaryop: idxop: invalid operator");
  endif

endfunction