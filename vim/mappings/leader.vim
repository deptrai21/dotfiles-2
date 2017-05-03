"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "\<Space>"


" switch to last buffer
nnoremap <Leader><Leader> <C-^>

" FZF
nnoremap <Leader>p :Buffers<CR>
nnoremap <Leader><C-P> :call fzf#run({'source': '~/dotfiles/scripts/bookmarks.sh', 'sink': ':Files', 'down': '18'})<CR>


nnoremap <Leader><C-H> :hide<CR>
nnoremap <Leader><C-J> :only<CR>
nnoremap <Leader><C-K> :sv#<CR>
nnoremap <Leader><C-L> :vs#<CR>

" save/close
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :call CloseOnLast()<CR>
nnoremap <Leader>x :x<CR>

" open from dir
nnoremap <Leader>n :Files %:h<CR>

" Search all
nnoremap <Leader>a :RG<Space>
nnoremap <Leader>r :%s/\v

" Zoom one pane
nnoremap <silent> <Leader>z :! tmux resize-pane -Z<CR><CR> :MaximizerToggle<CR>

" Jump To Definition
nnoremap <Leader>d <C-]>
nnoremap <Leader>b <C-T>

autocmd FileType javascript nnoremap <silent> <Leader>d :TernDef<CR>
autocmd FileType javascript nnoremap <silent> <Leader><C-d> :TernRefs<CR>

autocmd FileType typescript nnoremap <silent> <Leader>d :TsuDefinition<CR>
autocmd FileType typescript nnoremap <silent> <Leader><C-d> :TsuReferences<CR>
autocmd FileType typescript nnoremap <silent> <Leader>b :TsuGoBack<CR>
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" new line without insert
nnoremap <Leader>o o<esc>k
nnoremap <Leader>O O<esc>j

" Easy motion
map <Leader>e <Plug>(easymotion-bd-w)
nmap <Leader>e <Plug>(easymotion-overwin-w)
nmap <Leader>f <Plug>(easymotion-overwin-f)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Spell correct
nnoremap <Leader>z 1z=

" Undo Tree
nnoremap <Leader>u :GundoToggle<CR>

" Eslint
nnoremap <Leader>h :Autoformat<CR>

" Tool Tipp Typescript

" Merginal
nnoremap <Leader>g :Merginal<CR>

" Mark Down Preview
nnoremap <Leader>l :LivedownToggle<CR>

" Incsearch
map <Leader>s <Plug>(incsearch-easymotion-/)

nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
nmap <leader>gJ 9999<leader>gj
nmap <leader>gK 9999<leader>gk

