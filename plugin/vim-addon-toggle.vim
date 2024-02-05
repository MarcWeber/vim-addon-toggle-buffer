" exec vam#DefineAndBind('s:l','g:vim_addon_toggle_buffer','{}')
if !exists('g:vim_addon_toggle_buffer') | let g:vim_addon_toggle_buffer = {} | endif | let s:l = g:vim_addon_toggle_buffer

let s:l['cpp_impl'] = funcref#Function('return vim_addon_toggle#Substitute('.string('\.cpp,\.c,\.cc,\.cxx').','.string('.h,.hh').')')
let s:l['cpp_headers'] = funcref#Function('return vim_addon_toggle#Substitute('.string('\.h,\.hh').','.string('.cpp,.c,.cc,.cxx').')')

let s:l['js_to_coffe'] = funcref#Function('return vim_addon_toggle#Substitute('.string('\.js').','.string('.coffe,.iced,.html').')')
let s:l['coffe_to_js'] = funcref#Function('return vim_addon_toggle#Substitute('.string('\.coffe,\.iced,\.html').','.string('.js').')')


let s:l['js_to_coffe'] = funcref#Function('return vim_addon_toggle#Substitute('.string('\.js').','.string('.coffe,.iced,.html').')')
let s:l['coffe_to_js'] = funcref#Function('return vim_addon_toggle#Substitute('.string('\.coffe,\.iced,\.html').','.string('.js').')')

let s:l['patch_rej_to_file'] = funcref#Function('return vim_addon_toggle#Substitute('.string('\.rej').','.string('').')')

"s:l['cpp_headers']let s:l['angular.io_ts_to_css'] = funcref#Function('return vim_addon_toggle#Substitute('.string('component\.ts').','.string('component.css').')')
"s:l['cpp_headers']let s:l['angular.io_css_to_ts'] = funcref#Function('return vim_addon_toggle#Substitute('.string('component\.css').','.string('component.ts').')')

noremap \tg :call vim_addon_toggle#Toggle("narrow")<cr>
noremap \TG :call vim_addon_toggle#Toggle("all")<cr>
" narrow: presents a small list (more likely)
" all:    try to find all files you could be interested in.
 
" for Vim this means:
" narrow: .vim files in same addon (same runtimepath)
" all:   all .vim files found in any runtimpath of &rtp (TODO)
