# MARCTable

MARC records are invaluable records for bibliographic research. The [Pymarc library](https://pypi.org/project/pymarc/)
created and maintained by Ed Summers is the best way to create and them.

For those who prefer to do data analysis in R, this package provides a light wrapper around the read functions of PyMARC.


## Installation

```R
if (!require(remotes)) install.packages("remotes")
remotes::install_github("bmschmidt/MARCtable")
```

## Configuration

You need to actually install pymarc through the reticulate package. This will accomplish that for you.

```R
library("MARCtable")
install_pymarc
```

## Use

```R
# Note--this is ~70 MB of data
download.file("https://www.loc.gov/cds/downloads/MDSConnect/BooksAll.2016.part28.utf8.gz")
#Extract on you own: "BooksAll.2016.part28.utf8"
read_MARC("BooksAll.2016.part28.utf8",)

```

## Finding MARC records

Peter Kiraly has written up a helpful guide to [Where can I get MARC records](https://github.com/pkiraly/metadata-qa-marc#datasources).
