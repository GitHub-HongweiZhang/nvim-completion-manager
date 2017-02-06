
if get(g:,'cm_enable_for_all',1)
	" simple ignore files larger than 1M, for performance
	au BufEnter * if (exists('b:cm_enable')==0 && line2byte(line("$") + 1)<1000000) | call cm#enable_for_buffer() | endif
endif

" if you don't want built-in sources enabled use `let g:cm_builtin_sources={}`
let s:cm_builtin_sources = get(g:, 'cm_builtin_sources',{
		\ 'ultisnips':{},
		\ 'bufkeyword':{},
		\ 'filepath':{},
		\ 'jedi':{},
		\ 'tern':{},
		\ 'gocode':{},
		\ 'tmux':{},
		\ })


" ultisnips
if has_key(s:cm_builtin_sources,'ultisnips')
	call cm#register_source({'name' : 'cm-ultisnips',
		\ 'priority': 7, 
		\ 'abbreviation': 'Snips',
		\ 'cm_refresh': 'cm#sources#ultisnips#cm_refresh',
		\ })
endif


" Note: the channels field is required as an array, on most cases only one
" channel will would be enough. While there may be cases in which you need
" another thread to do the indexing, caching work, it's easier to use another
" channel instead of controlling threading on your own.

" keyword
if has_key(s:cm_builtin_sources,'bufkeyword')
	call cm#register_source({
			\ 'name' : 'cm-bufkeyword',
			\ 'priority': 5, 
			\ 'abbreviation': 'Key',
			\ 'channels': [
			\   {
			\		'type': 'python3',
			\		'path': 'autoload/cm/sources/bufkeyword.py',
			\		'events':['CursorHold','CursorHoldI','BufEnter','BufWritePost','TextChangedI'],
			\		'detach':1,
			\	}
			\ ],
			\ })
endif


" tmux
if has_key(s:cm_builtin_sources,'tmux') || $TMUX!=""
	call cm#register_source({
			\ 'name' : 'cm-tmux',
			\ 'priority': 4, 
			\ 'abbreviation': 'Tmux',
			\ 'channels': [
			\   {
			\		'type': 'python3',
			\		'path': 'autoload/cm/sources/cm_tmux.py',
			\		'events':['CursorHold','CursorHoldI','FocusGained','BufEnter'],
			\		'detach':1,
			\	}
			\ ],
			\ })
endif


" filepath
if has_key(s:cm_builtin_sources,'filepath')
	" refresh 1 for call signatures
	call cm#register_source({
			\ 'name' : 'cm-filepath',
			\ 'priority': 6, 
			\ 'abbreviation': 'path',
			\ 'channels': [
			\   {
			\		'type': 'python3',
			\		'path': 'autoload/cm/sources/cm_filepath.py',
			\		'detach': 1,
			\   }
			\ ],
			\ })
endif

" jedi
if has_key(s:cm_builtin_sources,'jedi')
	" refresh 1 for call signatures
	call cm#register_source({
			\ 'name' : 'cm-jedi',
			\ 'priority': 9, 
			\ 'abbreviation': 'Py',
			\ 'scopes': ['python'],
			\ 'refresh': 1, 
			\ 'channels': [
			\   {
			\		'type': 'python3',
			\		'path': 'autoload/cm/sources/cm_jedi.py',
			\		'events': ['InsertLeave'],
			\		'detach': 1,
			\   }
			\ ],
			\ })
endif

" tern
if has_key(s:cm_builtin_sources,'tern')
	call cm#register_source({
			\ 'name' : 'cm-tern',
			\ 'priority': 9, 
			\ 'abbreviation': 'Js',
			\ 'scopes': ['javascript','javascript.jsx'],
			\ 'channels': [
			\   {
			\		'type': 'python3',
			\		'path': 'autoload/cm/sources/cm_tern.py',
			\		'detach': 1,
			\   }
			\ ],
			\ })
endif

" gocode
if has_key(s:cm_builtin_sources,'gocode')
	call cm#register_source({
			\ 'name' : 'cm-gocode',
			\ 'priority': 9, 
			\ 'abbreviation': 'Go',
			\ 'scopes': ['go'],
			\ 'channels': [
			\   {
			\		'type': 'python3',
			\		'path': 'autoload/cm/sources/cm_gocode.py',
			\		'detach': 1,
			\   }
			\ ],
			\ })
endif

