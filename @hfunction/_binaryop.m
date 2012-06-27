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

function hf = _binaryop(hf1, hf2, op)

  hf1 = hfunction(hf1);
  hf2 = hfunction(hf2);

  ## Brackets discrimination
  brackets1 = false;
  brackets2 = false;

  idxop = _idxop(op);

  if (idxop < hf1.idxop)
    brackets1 = true;
  endif

  if (idxop < hf2.idxop)
    brackets2 = true;
  endif

  ## Making the function (string for inline)
  str1 = char(hf1);
  str2 = char(hf2);

  if (brackets1)
    str1 = [ "(" str1 ")" ];
  endif

  if (brackets2)
    str2 = [ "(" str2 ")" ];
  endif

  str = [ str1 " " op " " str2 ];

  ## Making variable list
  vars = { argnames(hf1){:}, argnames(hf2){:} };

  [ u i ] = unique(vars, "first");
  vars = vars(sort(i));

  ## Making hfunction
  hf = hfunction(str, idxop, vars{:});

endfunction

function p = _idxop(op)

  if (op == "^" || op == ".^")
    p = 2;
  elseif (op == "*" || op == ".*" || op == "/" || op == "./")
    p = 4;
  elseif (op == "+" || op == "-")
    p = 5;
  elseif (op == "<" || op == "<=" || op == "==" || op == "!=" || op == ">=" || op == ">")
    p = 7;
  elseif (op == "&")
    p = 8;
  elseif (op == "|")
    p = 9;
  else
    error("_binaryop: idxop: invalid operator");
  endif

endfunction