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
  hf1idxop = _idxop(hf1.op);
  hf2idxop = _idxop(hf2.op);

  if (idxop < hf1idxop && hf1idxop != 4)
    brackets1 = true;
  elseif (idxop == hf1idxop && !strcmp(op, hf1.op))
    brackets1 = true;
  endif

  if (idxop < hf2idxop && hf2idxop != 4)
    brackets2 = true;
  elseif (idxop == hf2idxop && !strcmp(op, hf2.op))
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
  hf = hfunction(str, op, vars{:});

endfunction

function p = _idxop(op)

  if (strcmp(op, ""))
    p = 0;
  elseif (strcmp(op, "{}"))
    p = 1;
  elseif (strcmp(op, "^") || strcmp(op, ".^") || strcmp(op, "'") || strcmp(op, ".'"))
    p = 3;
  elseif (strcmp(op, "+.") || strcmp(op, "-.") || strcmp(op, "!"))
    p = 4;
  elseif (strcmp(op, "*") || strcmp(op, ".*") || strcmp(op, "/") || strcmp(op, "./"))
    p = 5;
  elseif (strcmp(op, "+") || strcmp(op, "-"))
    p = 6;
  elseif (strcmp(op, "<") || strcmp(op, "<=") || strcmp(op, "==") || strcmp(op, "!=") || strcmp(op, ">=") || strcmp(op, ">"))
    p = 8;
  elseif (strcmp(op, "&"))
    p = 9;
  elseif (strcmp(op, "|"))
    p = 10;
  else
    error("_binaryop: idxop: invalid operator");
  endif

endfunction