
HTML vignettes, e.g. including JS graphics from dygraphs

https://stackoverflow.com/questions/30175567/include-dygraphs-in-jekyll-run-site-from-r/31988717

- generate with YAML: 
output:
  rmarkdown::html_fragment:
    self_contained: false
    lib_dir: lib
    fig.width: ..
    fig.height: ..

1. render with `rmarkdown::html_output`, copy dygraph dependencies from header
2. create a new jekyll layout in `_layouts/` with the dygraphs dependencies (changing `libs` to `/libs` as mentioned before)
3. run rmarkdown again, this time with `rmarkdown::html_fragment` to generate html without header
4. copy html fragment to `_includes/`
5. create a new blog post using layout specified in [2]
6. include html fragment in body of blog post using `{% include html_fragment.html %}`
