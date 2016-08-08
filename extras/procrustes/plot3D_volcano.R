## install.packages("plot3D")
library(plot3D)

## data("volcano")
## ?volcano
## ## Volcano <- volcano[seq(1, nrow(volcano), by = 3),
## ##                    seq(1, ncol(volcano), by = 3)]
## Volcano <- volcano
## View(volcano)

## image2D(Volcano, rasterImage = TRUE, contour = list(lwd = 2, col = jet.col(11)))

## re-create volcano-type matrix from table with x-, y- and weight values

## matrix dimensions and resolution

dec2int <- function (x, round) round(x, round) * 10^round

create_mat <- function(
    data = data_map
   ,
    row = "y"
   ,
    col = "x"
    ,
    value = "weight.Occurrences."
   ,
    round = 2
   ,
   margin = 10
    ,
    value_min = 0
   ,
   log = FALSE
) {

    nrow <- max(data[[row]]) - min(data[[row]])
    nrow <- dec2int(nrow, round)
    ncol <- max(data[[col]]) - min(data[[col]])
    ncol <- dec2int(ncol, round)

    datamat <- matrix(value_min, nrow = nrow + margin, ncol = ncol + margin)

    add_row <- - dec2int(min(data[[row]]), round) + round(margin / 2)
    data$row_norm <- dec2int(data[[row]], round) + add_row

    add_col <- - dec2int(min(data[[col]]), round) + round(margin / 2)
    data$col_norm <- dec2int(data[[col]], round) + add_col

    if (log) data[[value]] <- log(data[[value]])
    ## i <- 1
    ## i <- 2
    for (i in c(1:nrow(data))) {
        datamat[data$row_norm[i], data$col_norm[i]] <- value_min + data[[value]][i]
    }

    return(datamat)
}

interpolate <- function(datamat = testmat,
                        factor = .8,
                        shape = 1) {
    datamat2 <- datamat
    for (j in c(2:ncol(datamat)-1)) {
        for (i in c(2:nrow(datamat)-1)) {

            ## i <- 3
            ## j <- 3
            ## datamat[c((i-1):(i+1)), c((j-1):(j+1))]

            if (shape == 2) {
                vec <- c(datamat[i, j],
                         datamat[c((i-1), (i+1)), j],
                         datamat[i, c((j-1), (j+1))]
                         )
            } else {
                vec <- c(datamat[c((i-1):(i+1)), c((j-1):(j+1))])
            }

            val <- (max(vec) - min(vec)) * factor
            if (datamat[i, j] < val) datamat2[i, j] <- val
        }
    }
    return(datamat2)
}


data_map <- read.table(file.path(dbpath, "GitHub", "jekyll", "industry", "extras", "procrustes", "data", "NatureBiotechnology_MAP_v1.txt"), sep = "\t", header = TRUE)

data_map[[value]][data_map[[value]]==209] <- 59
## max(data_map[[value]])
## class(data_map[[value]])

datamat <- create_mat(log = FALSE)

datamat_temp <- datamat
for (c in c(1:20)) {
    datamat2 <- interpolate(datamat = datamat_temp, factor = .95,
                            shape = 1
                            ## shape = 2
                            )
    datamat_temp <- datamat2
}

image2D(datamat2, rasterImage = TRUE, contour = list(lwd = 2, col = jet.col(11)))

## ## test radial smoothing
## testmat <- matrix(c(0,0,0,0,0
##                    ,0,0,0,0,0
##                    ,0,0,10,0,0
##                    ,0,0,0,0,0
##                    ,0,0,0,0,0),
##                   ncol = 5)

## interpolate(datamat = testmat, factor = .5)
