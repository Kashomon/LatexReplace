## LatexReplace

Latex Replace is a Vim Plugin, which currently exposes one command to the user:

    LatexMathReplace

This command takes exactly one argument, of the form:

    foo/bar

Where the left side is the 'search' term and the right side (after the slash) is
the 'replace' term.

Currently, LatexMathReplace looks through the following regions for things to
replace:

    \begin{equation} ... \end{equation}
    \begin{align} ... \end{align}
    \begin{align*} ... \end{align*}
    $ ... $
    $$ ... $$
    \[ ... \]

Note: LatexMathReplace will not replace partial macros that you have defined
with '\newcommand' or similar.  However, if you specify the full name of a
macro, LatexMathReplace will replace the macro.

### Examples

This is the behavior of `LatexMathReplace foo/bar`:

    $foo$ => $bar$
    $\foobiff$ => $\foobiff$

and `LatexMathReplace \\foo/\bar`

    $foo$ => $foo$
    $\foo$ => $\bar$
    $\foobiff$ => $\foobiff$

### Mappings

If you want to alias LatexMathReplace, you might try something like:

    nnoremap ,lr :LatexMathReplace
