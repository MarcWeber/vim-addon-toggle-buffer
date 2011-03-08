exec vam#DefineAndBind('s:l','g:vim_addon_toggle_buffer','{}')

" Example: see plugin/vim-addon-toggle.vim
fun! vim_addon_toggle#Substitute(from, to)
  let l = []
  let f = expand('%')
  for pat in split(a:from, ',')
    for replace in split(a:to, ',')
      let r = substitute(f, pat.'$', replace, 'g')
      if r != f
        call add(l,string(r))
      endif
    endfor
  endfor
  return l
endf

fun! vim_addon_toggle#VimAlternates(mode)
  if expand('%:e') != 'vim' | return [] | endif

  let l = []
  " TODO implement mode = all
  " assume you're editing a */.vim file
  for f in split(glob(expand('%:h:h').'/*/*.vim'),"\n")
    if expand(f) != expand('%')
      call add(l, string(f))
    endif
  endfor
  return l
endf

" evaluates all functions in g:vim_addon_toogle
" asks user to which file to jump to
fun! vim_addon_toggle#Toggle(mode)
  let alternates = {}

  for F in values(s:l)
    for a in funcref#Call(F, [a:mode])
      if has_key(alternates, a) | continue | endif
      let alternates[a] = 1
    endfor
  endfor
  let l = keys(alternates)
  if empty(l) | return  | endif
  let to = eval(tlib#input#List("s","select local name", l))
  if type(to) == type('')
    exec 'e '.fnameescape(to)
  else
    " TODO: eg allow jumping to a line or such. Useful for .c <-> .h or .ml <-> .mli
  endif
endf
