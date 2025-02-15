
## ----------------------------------------------------------------------
##
##   IGraph R package
##   Copyright (C) 2014  Gabor Csardi <csardi.gabor@gmail.com>
##   334 Harvard street, Cambridge, MA 02139 USA
##
##   This program is free software; you can redistribute it and/or modify
##   it under the terms of the GNU General Public License as published by
##   the Free Software Foundation; either version 2 of the License, or
##   (at your option) any later version.
##
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
##
##   You should have received a copy of the GNU General Public License
##   along with this program; if not, write to the Free Software
##   Foundation, Inc.,  51 Franklin Street, Fifth Floor, Boston, MA
##   02110-1301 USA
##
## ----------------------------------------------------------------------

#' igraph data structure versions
#'
#' igraph's internal data representation changes sometimes between
#' versions. This means that it is not possible to use igraph objects
#' that were created (and possibly saved to a file) with an older
#' igraph version.
#'
#' `graph_version()` queries the current data format,
#' or the data format of a possibly older igraph graph.
#'
#' [upgrade_graph()] can convert an older data format
#' to the current one.
#'
#' @param graph The input graph. If it is missing, then
#'   the version number of the current data format is returned.
#' @return A character scalar.
#'
#' @seealso upgrade_graph to convert the data format of a graph.
#' @family versions
#' @export
graph_version <- function(graph) {
  if (missing(graph)) {
    "0.8.0"
  } else {
    stopifnot(is_igraph(graph))
    .Call(C_R_igraph_graph_version, graph)
  }
}

#' igraph data structure versions
#'
#' igraph's internal data representation changes sometimes between
#' versions. This means that it is not possible to use igraph objects
#' that were created (and possibly saved to a file) with an older
#' igraph version.
#'
#' [graph_version()] queries the current data format,
#' or the data format of a possibly older igraph graph.
#'
#' `upgrade_graph()` can convert an older data format
#' to the current one.
#'
#' @param graph The input graph.
#' @return The graph in the current format.
#'
#' @seealso graph_version to check the current data format version
#' or the version of a graph.
#' @family versions
#' @export
upgrade_graph <- function(graph) {
  stopifnot(is_igraph(graph))

  g_ver <- graph_version(graph)
  p_ver <- graph_version()

  if (g_ver < p_ver) {
    if ((g_ver == "0.4.0" && p_ver == "0.8.0")) {
      .Call(C_R_igraph_add_env, graph)
    } else if (g_ver == "0.7.999" && p_ver == "0.8.0") {
      .Call(C_R_igraph_add_version_to_env, graph)
    } else {
      stop("Don't know how to upgrade graph from ", g_ver, " to ", p_ver)
    }
  } else if (g_ver > p_ver) {
    stop("Don't know how to downgrade graph from ", g_ver, " to ", p_ver)
  } else {
    graph
  }
}

## Check that the version is the latest

check_version <- function(graph) {
  if (graph_version() != graph_version(graph)) {
    stop(
      "This graph was created by an old(er) igraph version.\n",
      "  Call upgrade_graph() on it to use with the current igraph version"
    )
  }
}

warn_version <- function(graph) {
  if (graph_version() != graph_version(graph)) {
    message(
      "This graph was created by an old(er) igraph version.\n",
      "  Call upgrade_graph() on it to use with the current igraph version\n",
      "  For now we convert it on the fly..."
    )
    TRUE
  } else {
    FALSE
  }
}
