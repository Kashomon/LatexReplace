" LatexMathReplace: replace all items that are in MathMode, i.e.,
" \[ ... \]
" \begin{equation} ... \end{equation}
" \begion{align} ... \end{align}
" $ .... $
"
" Argument: Substute of the form 'foo/bar.  Note that any literal slashes
" must be escaped

command -nargs=1 LatexMathReplace call latex_replace#MathMode(<f-args>)
