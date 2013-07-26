function! latex_replace#MathMode(arg)
  "Split on / but allow for \/
  let splat = split(a:arg, '\\\@<!/')
  if len(splat) != 2
    echomsg 'Error: argument must be of the form "foo/bar"'
  endif
  let search_term = splat[0]
  let replace_term = splat[1]
  let internal_match = '\_.\{-}'
  let start = [
      \ '\\begin{equation}',
      \ '\\begin{align',
      \ '\\\[',
      \ '\\\@<!\$']
  let end = [
      \ '\\end{equation}',
      \ '\\end{align',
      \ '\\\]',
      \ '\\\@<!\$']

  if search_term =~ '^\'
    let search_term = search_term . '\>'
  else
    " Make sure that the search term isn't part of some macro
    let search_term = '\(\\\h*\)\@<!' . search_term
  endif

  " Go through each pattern, doing a separate replace for each case.
  let bpos = getpos('.')
  let bpos[1] = 0
  let view = winsaveview()

  for idx in range(4)
    call setpos('.', bpos)
    let search = '\(' . start[idx] . internal_match . '\)'
      \ . '\(' . internal_match . end[idx] . '\)'
    silent execute '%s/' . search . "/\\=substitute(submatch(0),'"
        \ . search_term . "','" . replace_term . "','g')/ge"
  endfor
  call winrestview(view)
endfunction
