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
  hfidxop = _idxop(hf.op);

  if (idxop < hfidxop)
    brackets = true;
  elseif (idxop == hfidxop && !strcmp(op, hf.op))
    brackets = true;
  endif

  ## Making the function (string for inline)
  str = char(hf);

  if (brackets)
    str = [ "(" str ")" ];
  endif

  if (strcmp(op, "-."))
    mop = "-";
  elseif (strcmp(op, "+."))
    mop = "+";
  else
    mop = op;
  endif

  str = [ mop str ];

  ## Making hfunction
  hf = hfunction(str, op, argnames(hf){:});

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