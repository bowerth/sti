---
layout: default
title: Welcome
---

# Welcome

This website provides documentation for indicator calculation tools and their underlying data assembled by the OECD Directorate for Science, Technology and Innovation. It is best displayed with the recent version of a modern browser like Google Chrome or Mozilla Firefox and can be navigated with the top menu.

## Applications {#app}

[R Shiny](http://shiny.rstudio.com/)
:   - applications allow interactive calculation and visualisation of indicators
	- users can experiment with the selection of inputs and immediately see the change in results
	- visual and textual representations of selected and resulting dimension members provide guidance to users
	- slides with further explanation are available at [as_seminar_shiny](http://bowerth.github.io/as_seminar_shiny#3) (hit left and right arrow keys to move slides)

Access
:   - internal application available at http://10.101.26.220:3838/industry  
    - external application hosted on Microsoft Azure available at http://oecd-icio.cloudapp.net:3838/industry

Do-it-yourself
:   Experimenting with inputs and their immediate effect on outputs allows users to develop a feeling for the robustness of results to parameter changes

The links listed below provide additional explanation on available tools

<ul class="toc">
  {% include app-nav.html %}
</ul>

## Data {#data}

Concepts and definitions of data sources:

<ul class="toc">
  {% include data-nav.html %}
</ul>

## Methods {#method}

Methods applied to data:

<ul class="toc">
  {% include method-nav.html %}
</ul>

## Reports {#report}

Country reports:

<ul class="toc">
  {% include report-nav.html %}
</ul>

## Projects {#project}

Current projects:

<ul class="toc">
  {% include project-nav.html %}
</ul>

About the tools:

<ul class="toc">
  {% include about-nav.html %}
</ul>

## Colophon {#colophon}

The contents were written with [Rmarkdown](http://rmarkdown.rstudio.com/), reports pre-processed by [brew](http://www.rforge.net/doc/packages/brew/brew.html). [knitr](http://yihui.name/knitr/) and [pandoc](http://johnmacfarlane.net/pandoc/) converted the raw Rmarkdown to html. The website was made with [jekyll](http://jekyllrb.com/) and styled with [bootstrap](http://getbootstrap.com/).

Code is set in [inconsolata](http://levien.com/type/myfonts/inconsolata.html).
