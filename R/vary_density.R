################################################################################
#
#' Adjust triangulation by by dividing a densely populated triangle into smaller
#' triangles by adding 3 points at the middle of each side of the triangle
#'
#' @param sample A data frame containing selected villages for sampling. This is the
#'     data frame produced by \code{get_nearest_point()} function.
#' @param x A character value specifying the variable name in \code{sample}
#'     holding the longitude information of the sampling locations.
#' @param y A character value specifying the variable name in \code{sample}
#'     holding the latitude information of the sampling locations.
#' @param label A character value specifying the variable name in \code{sample}
#'     holding the name of the sampling locations. If no name information
#'     available in data frame, specify a character vector with length equal to
#'     number of sampling locations in \code{sample}. Default is NULL.
#' @param basemap A SpatialPolygonsDataFrame of base map to show when plotting
#'     triangulation. Default is NULL
#' @param crs A character vector specifying the coordinate reference system to
#'     use for the spatial objects. Default is longlat projection for datum
#'     WGS84
#'
#' @return NULL
#'
#' @examples
#' #
#'
#' @export
#'
#
################################################################################

vary_density <- function(sample, x, y, label = seq_along(x),
                         basemap = NULL,
                         crs = "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0") {
  dev.new()
  sp::plot(basemap)
  sp::plot(get_tri(sample, x = x, y = y, crs = crs), add = TRUE)
  points(sample[, c(x, y)], pch = 20, col = "red")
  selectDF <- NULL

  repeat {
    #vil1 <- vil[!(vil$village %in% selPS$village),]
    #plot(basemap)
    #points(query[ , c("x", "y")], pch = 20, col = "blue")
    #plot(get_tri(sample, x = x, y = y, crs = crs), add = TRUE)
    p <- identify(sample[ , x], sample[ , y], labels = label, pos = TRUE, n = 3, tolerance = 0.25)

    #toMOD <- data.frame(cbind(vil1$id[p[[1]]],
    #                        vil1$x[p[[1]]],
    #                        vil1$y[p[[1]]],
    #                        vil1$village[p[[1]]],
    #                        vil1$locality[p[[1]]],
    #                        vil1$id[p[[1]]]), stringsAsFactors = F)
    #names(toMOD) <- c("id", "x", "y", "village", "locality", "d")
    #toMOD[,1] <- as.numeric(toMOD[,1]); toMOD[,2] <- as.numeric(toMOD[,2]); toMOD[,3] <- as.numeric(toMOD[,3])

    selectSP <- sample[p[[1]], ]

    #
    #	Stop if no selection is made and stop if chosen from graphic device
    #

    if(nrow(selectSP) == 0) { break }

    else

    selectDF <- data.frame(rbind(selectDF, sample, selectSP))
    selectDF <- selectDF[!duplicated(selectDF[ , c("x", "y")]), ]

    #
    # Plot
    #
    #plot(base)
    #plot(loc, border = "black", lwd = 2, add =T)
    #points(SPs, pch = 20, cex = .5, col = "red")
    points(selectDF[, c(x, y)], col = "green", cex = 1, pch = 20)
    #selPS.SP = SpatialPoints(cbind(selPS[, 2], selPS[, 3]), proj4string = CRS("+proj=longlat +dataum=WGS84"))
    #p.tri <- rgeos::gDelaunayTriangulation(SpatialPoints(sample[ , c("x", "y")], proj4string = CRS(crs)))
    #plot_tri(x = p.tri, border = "blue", qTSL = 0.975)
    #points(vil$x, vil$y, pch = 20, cex = .5, col = "black")
    sp::plot(get_tri(selectDF, x = x, y = y, crs = crs), add = TRUE, border = "black")
    #SPs.per.loc <- count.sps(selPS, vil, loc)
    #SPs.per.loc

    return(selectDF)
  }
}
