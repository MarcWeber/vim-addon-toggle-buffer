exec vam#DefineAndBind('s:l','g:vim_addon_toggle_buffer','{}')

" Example: see plugin/vim-addon-toggle.vim
fun! vim_addon_toggle#Substitute(from, to, ...)
  " surround pattern by:
  let p = a:0 > 0 ? a:1 : ['','$']
  let l = []
  let existing = []
  let f = expand('%')
  for pat in split(a:from, ',')
    for replace in split(a:to, ',')
      let r = substitute(f, p[0].pat.p[1], replace, 'g')
      if r != f
        call add(l,string(r))
        if filereadable(r)
          call add(existing,string(r))
        endif
      endif
    endfor
  endfor
  if len(existing) > 0
    return existing
  else
    return l
  endif
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

fun! s:GotoFile(s)
  try
    exec 'b '.fnameescape(a:s)
  catch /.*/
    exec 'e '.fnameescape(a:s)
  endtry
endfun

" evaluates all functions in g:vim_addon_toogle
" asks user to which file to jump to
fun! vim_addon_toggle#Toggle(mode)
  let alternates = {}

  " store cursor pos
  let p = getpos('.')

  for F in values(s:l)

    for a in funcref#Call(F, [a:mode])
      if has_key(alternates, a) | continue | endif
      let alternates[a] = 1
    endfor

    " reset cursor pos
    call setpos('.', p)
  endfor
  let l = keys(alternates)
  if empty(l) | return  | endif
  let to = eval(tlib#input#List("s","select local name", l))
  if type(to) == type('')
    call s:GotoFile(to)
  elseif type(to) == type({}) && has_key(to,'file') && has_key(to,'line')
    call s:GotoFile(to.file)
    exec to.line
  else
    throw "unexpected"
  endif
endf
