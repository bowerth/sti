for (yr in nameyear) {

    ## yr <- 2000
    ## chartdata.csv <- read.csv(file.path(dbpath, "BTDIxE", "R", "data", paste0("bilat", yr, "usd.csv")))
    chartdata.csv <- read.csv(file.path(dbpath, "BTDIxE", "R", "data", paste0("bilat", yr, "_AC.csv")))
    ## nrow(chartdata.csv)
    ## drop countries that have no connection with hubs (except Norway)
    chartdata.csv <- chartdata.csv[!chartdata.csv[,1] %in% dropcou,]
    ## nrow(chartdata.csv)
    ## sort countries according to coutryorderchordchart.csv
    chartdata.csv[,1] <- factor(chartdata.csv[,1], levels = as.character(countryorder$cou))
    chartdata.csv <- chartdata.csv[order(chartdata.csv[,1]),]

    rownames(chartdata.csv) <- chartdata.csv[ , 1]
    chartdata.csv <- chartdata.csv[ , -1]
    chartdata.csv.mat <- as.matrix(chartdata.csv)
    chartdata.csv.mat[is.na(chartdata.csv.mat)] <- 0
    chorddata.csv <- chartdata.csv.mat

    ## link colors
    mat.col <- chorddata.csv
    for (cou in couhubs) {
        mat.col[, cou][mat.col[, cou]!=0] <- as.character(countryorder$farben[countryorder$cou==cou])
    }
    for (cou in colnames(mat.col)[!colnames(mat.col)%in%couhubs]) {
        mat.col[, cou][mat.col[, cou]!=0] <- "grey"
    }
    mat.col[mat.col[,]==0] <- "transparent"
    ## View(mat.col)

    ## if (length(output.format)) output.format <- "pdf"

    ## filename <- file.path(pathgraphs, paste0("1.x_Chord_INT_", yr, "_color.pdf"))
    ## filename <- file.path(pathgraphs, paste0("1.x_Chord_INT_", yr, "_sb.", output.format))
    ## filename <- file.path(pathgraphs, paste0("1.x_Chord_INT_", yr, "_sb_bw.", output.format))
    filename <- file.path(pathgraphs, paste0("1.x_Chord_INT_", yr, "_sb_july23.", output.format))

    if (output.format %in% c("pdf", "svg")) {

        if (output.format=="pdf") {
            pdf(filename)
        } else if (output.format=="svg") {
            svg(filename)
        }

        par(las=1)

        ## test ##
        ## chordDiagram(chorddata.csv,
        ##             annotationTrack = "grid", preAllocateTracks = list(track.height = 0.3))

        ## end test ##
        ## data.frame(row=c("USA"), col = c("MEX"), colour = c("blue"))

        chordDiagram(
            ## chorddata,
            mat=chorddata.csv,
            grid.col=farben,
            ## col=NULL,
            col = mat.col,
            ## row.col=farben,
            ## column.col=farben,
            annotationTrack = "grid", preAllocateTracks = list(track.height = 0.3))

        ## length(names(farben))
        ## length(rownames(chorddata.csv))
        ## length(colnames(chorddata.csv))
        ## View(chorddata.csv)
        ## View(mat.col)

        circos.trackPlotRegion(track.index = 1, panel.fun = function(x, y) {
            xlim = get.cell.meta.data("xlim")
            ylim = get.cell.meta.data("ylim")
            sector.name = get.cell.meta.data("sector.index")
            circos.text(mean(xlim), ylim[1], sector.name, facing = "clockwise",
                        niceFacing = TRUE,
                        adj = c(-0.5, 0.5),
                        cex= 0.4)
        }, bg.border = NA)

        ## title(paste0("Trade in intermediates, ", yr))

        dev.off()

    } else if (output.format == "html") {

    }

    if (write.data==TRUE) {
        data.out <- reshape2::melt(chorddata.csv)
        data.out <- subset(data.out, value!=0)
        names(data.out) <- sub("Var1", "par", names(data.out))
        names(data.out) <- sub("Var2", "cou", names(data.out))
        data.out <- subset(data.out, select = c("cou", "par", "value"))
        write.csv(data.out, file = sub(output.format, "csv", filename), row.names = FALSE)
    }

}
