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

function hg = mpower(hg, n)

  if (!isa(hg, "hfigure"))
    error("hfigure: mpower: expecting a figure as first argument");
  endif

  if (!isnumeric(n))
    error("hfigure: mpower: expecting a number as second argument");
  endif

  hg.beta += n;

  ## Assuming give us alpha and beta in radians.
  sinalpha = sin(hg.alpha);
  cosalpha = cos(hg.alpha);

  sinbeta = sin(hg.beta);
  cosbeta = cos(hg.beta);

  hg.rotm = inv([ cosalpha  -sinalpha * cosbeta   sinalpha * sinbeta;
                  sinalpha   cosalpha * cosbeta  -cosalpha * sinbeta;
                  0          sinbeta              cosbeta             ]);

endfunction