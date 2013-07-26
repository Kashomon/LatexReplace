function! latex_replace#MathMode(arg)
  "Split on / but allow for \/
  let splat = split(a:arg, '[^\\]\@<=/')
  if len(splat) != 2
    echomsg 'Erorr: argument must be of the form "foo/bar"'
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

  for idx in range(4)
    let search = '\(' . start[idx] . internal_match . '\)'
      \ . '\(\(\\\h\+\)\@<!' . splat[0] . '\)'
      \ . '\(' . internal_match . end[idx] . '\)'
    execute '%s/' . search . '/\1' . splat[1] . '\4/ge'
  endfor
endfunction
