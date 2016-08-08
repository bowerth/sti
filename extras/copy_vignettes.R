
## require(tools)

## path.jekyll <- file.path(dbpath, "GitHub", "jekyll", "industry")
## ## path.package <- system.file("doc", package = "stanData")
## ## path.package <- file.path(dbpath, "GitHub", "stanData", "vignettes")
## ## path.package <- file.path(dbpath, "GitHub", "skillData", "vignettes")
## ## packages <- c("stanData", "skillData", "stan")
## packages <- c("stanData")
## ## packages <- c("stan")

## for (package in packages) {

##     path.package <- file.path(dbpath, "GitHub", package, "vignettes")

##     files <- list.files(path.package)
##     rmdfiles <- files[file_ext(files)=="rmd"]

##     prepend <- paste0(
##         'layout: default\n',
##         'output: bookdown::html_chapter\n',
##         '---\n')

## ## copy "diagrams" folder to jekyll folder
##     folder.content <- c("diagrams")
##     path.content <- file.path(path.package, folder.content)
##     files.content <- list.files(path.content)
##     ## do not copy files with certain extensions
##     excl.ext <- c("graphml")
##     files.content <- files.content[!file_ext(files.content)%in%excl.ext]
##     file.copy(from = path.content, to = path.jekyll, recursive = TRUE)

## ## vignette <- rmdfiles[1]
##     for (vignette in rmdfiles) {
##     ##
##         file.vignette <- file.path(path.package, vignette)
##         file.vignette.con <- file(file.vignette)
##         file.out <- file.path(path.jekyll, paste0('vignette_', vignette))
##     ##
##         ## text <- readLines(file(file.vignette))
##         text <- readLines(file.vignette.con)
##         close(file.vignette.con)

##         title <- text[1:2]
##         text <- text[12:length(text)] # line of top-level header
##         text.out <- c(title, prepend, text)
##         fileCon = file(file.out)
##         writeLines(text = text.out, con = fileCon)
##         close(fileCon)
##     }

## }

copyVignettes <- function(file.vignette,
                          diagrams=FALSE) {

    vignette <- basename(file.vignette)

    path.jekyll <- file.path(dbpath, "GitHub", "jekyll", "industry")

    prepend <- paste0(
        'layout: default\n',
        'output: bookdown::html_chapter\n',
        '---\n')

    if (diagrams) {
        ## copy "diagrams" folder to jekyll folder
        folder.content <- c("diagrams")
        path.content <- file.path(path.package, folder.content)
        files.content <- list.files(path.content)
        ## do not copy files with certain extensions
        excl.ext <- c("graphml")
        files.content <- files.content[!file_ext(files.content)%in%excl.ext]
        file.copy(from = path.content, to = path.jekyll, recursive = TRUE)
    }

    ## file.vignette <- file.path(path.package, vignette)
    file.vignette.con <- file(file.vignette)
    file.out <- file.path(path.jekyll, paste0('vignette_', vignette))
    ##
    ## text <- readLines(file(file.vignette))
    text <- readLines(file.vignette.con)
    close(file.vignette.con)

    title <- text[1:2]
    text <- text[12:length(text)] # line of top-level header
    text.out <- c(title, prepend, text)
    fileCon = file(file.out)
    writeLines(text = text.out, con = fileCon)
    close(fileCon)

    return(cat("\n", file.vignette, "processed\n\n"))

}

## source(file.path(dbpath, "GitHub", "jekyll", "industry", "extras", "copy_vignettes.R"))
copyVignettes(file.path(dbpath, "GitHub", "stanData", "vignettes", "stani4_api.md"))
