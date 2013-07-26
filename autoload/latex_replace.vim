function! latex_replace#MathMode(arg)
  "Split on / but allow for \/
  let splat = split(a:arg, '\\\@<!/')
  let search_term = splat[0]
  let replace_term = splat[1]
  if len(splat) != 2
    echomsg 'Error: argument must be of the form "foo/bar"'
  endif
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
    let last_capture_group = '\3'
  else
    " Make sure that the search term isn't part of some macro
    let search_term = '\(\\\h*\)\@<!' . search_term
    let last_capture_group = '\4'
  endif

  " Go through each pattern, doing a separate replace for each case.
  for idx in range(4)
    let search = '\(' . start[idx] . internal_match . '\)'
      \ . '\(' . search_term . '\)'
      \ . '\(' . internal_match . end[idx] . '\)'
    execute '%s/' . search . '/\1' . replace_term . last_capture_group . '/ge'
  endfor
endfunction
