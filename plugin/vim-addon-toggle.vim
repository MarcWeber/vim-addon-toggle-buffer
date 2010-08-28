exec scriptmanager#DefineAndBind('s:l','g:vim_addon_toggle_buffer','{}')

let s:l['cpp_impl'] = funcref#Function('return vim_addon_toggle#Substitute('.string('cpp,c,cc').','.string('h,hh').')')
let s:l['cpp_headers'] = funcref#Function('return vim_addon_toggle#Substitute('.string('h,hh').','.string('cpp,c,cc,cxx').')')

" should be moved to vim-addon-ocaml. They server as example
let s:l['ocaml_ml'] = funcref#Function('return vim_addon_toggle#Substitute('.string('ml').','.string('mli').')')
let s:l['ocaml_mli'] = funcref#Function('return vim_addon_toggle#Substitute('.string('mli').','.string('ml').')')

let s:l['vim_alternates'] = funcref#Function('vim_addon_toggle#VimAlternates')

noremap \t :call vim_addon_toggle#Toggle("narrow")<cr>
noremap \T :call vim_addon_toggle#Toggle("all")<cr>
" narrow: presents a small list (more likely)
" all:    try to find all files you could be interested in.
 
" for Vim this means:
" narrow: .vim files in same addon (same runtimepath)
" all:   all .vim files found in any runtimpath of &rtp (TODO)
