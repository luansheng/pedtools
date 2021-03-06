#' Get or modify pedigree labels
#'
#' Functions for getting or changing the ID labels of pedigree members.
#'
#' @param x A `ped` object.
#' @param new,old Character vectors (or coercible to character) of the same
#'   length. ID labels in `old` are replaced by those in `new`.
#'
#' @return
#'
#' * `labels()` returns a character vector containing the ID labels of all pedigree members.
#'
#' * `relabel()` returns `ped` object similar to the input except for the labels.
#'
#' @author Magnus Dehli Vigeland
#' @seealso [ped()]
#'
#' @examples
#'
#' x = nuclearPed(1)
#' x
#' labels(x)
#'
#' relabel(x, new="girl", old=3)
#'
#' @export
relabel = function(x, new, old=labels(x)) {
  if(!is.ped(x)) stop2("Input is not a `ped` object")

  if(length(new) != length(old))
    stop2("Arguments `new` and `old` must have the same length")

  if(anyDuplicated(old) > 0)
    stop2("Duplicated entry in argument `old`: ", unique(old[duplicated(old)]))

  # Relabel
  id = labels(x)
  old_int = internalID(x, old)
  id[old_int] = new
  x$ID = id

  # Duplicated IDs after relabeling?
  if(anyDuplicated(id) > 0)
    stop2("Duplicated ID label: ", unique(id[duplicated(id)]))

  # Replace `pedmembers` attribute of each marker
  if(hasMarkers(x))
    x$markerdata = lapply(x$markerdata, `attr<-`, 'pedmembers', id)

  x
}

#' @param object A `ped` object
#' @param ... Not used
#'
#' @rdname relabel
#' @export
labels.ped = function(object, ...) {
  object$ID
}

#' Get or modify pedigree genders
#'
#' Functions for retrieving or changing the gender codes of specified pedigree
#' members.
#'
#' @param x A `ped` object.
#' @param ids A character vector (or coercible to one) containing ID labels.
#' @param verbose A logical: Verbose output or not.
#'
#' @seealso [ped()]
#'
#' @return
#'
#' * `getSex()` returns an integer vector of the same length as `ids`, with
#' entries 0 (unknown), 1 (male) or 2 (female).
#'
#' * `swapSex()` returns a `ped` object similar to the input, but where the
#' gender codes of `ids` (and their spouses) are swapped (1 <->
#' 2).
#'
#' @examples
#' x = nuclearPed(1)
#' stopifnot(all(getSex(x) == c(1,2,1)))
#'
#' swapSex(x, 3)
#'
#' @export
getSex = function(x, ids = labels(x)) {
  if(!is.ped(x)) stop2("Input is not a `ped` object")
  x$SEX[internalID(x, ids)]
}

#' @rdname getSex
#' @export
swapSex = function(x, ids, verbose = TRUE) { #TODO add tests with sex=0
  if(!is.ped(x)) stop2("Input is not a `ped` object")

  # Ignore individuals with unknown gender
  ids = ids[getSex(x, ids) != 0]

  if(!length(ids)) return(x)
  ids = internalID(x, ids)
  labs = labels(x)
  FIDX = x$FIDX
  MIDX = x$MIDX
  spouses = c(MIDX[FIDX %in% ids], FIDX[MIDX %in% ids])

  if (!all(spouses %in% ids)) {
    if (verbose) {
      extra = setdiff(spouses, ids)
      message("Changing sex of spouses as well: ", toString(labs[extra]))
    }
    return(swapSex(x, labs[union(ids, spouses)], verbose = verbose))
  }

  # Swap sex
  x$SEX[ids] = 3L - x$SEX[ids]

  # # Swap parents wherever any of the 'ids' occur as parents
  ids_as_parents = FIDX %in% ids # same with MIDX!
  FIDX[ids_as_parents] = x$MIDX[ids_as_parents]
  MIDX[ids_as_parents] = x$FIDX[ids_as_parents]
  x$FIDX = FIDX
  x$MIDX = MIDX

  x
}



#' Family identifier
#'
#' Functions for getting or setting the family ID of a `ped` object.
#'
#' @param x A `ped` object
#' @param value The new family ID, which must be (coercible to) a character
#'   string.
#' @param ... (Not used)
#'
#' @examples
#' x = nuclearPed(1)
#' famid(x) # empty string
#'
#' famid(x) = "trio"
#' famid(x)
#'
#' @export
`famid` = function(x, ...) {
  UseMethod("famid")
}

#' @rdname famid
#' @export
`famid.ped` = function(x, ...) {
  x$FAMID
}

#' @rdname famid
#' @export
`famid<-` = function(x, ..., value) {
  UseMethod("famid<-")
}

#' @rdname famid
#' @export
`famid<-.ped` = function(x, ..., value) {
  famid = as.character(value)
  if(length(famid) != 1) stop2("Replacement value must have length 1: ", famid)
  x$FAMID = famid
  x
}

