@echo off
if not exist "%HOMEPATH%\.vim" mkdir "%HOMEPATH%\.vim"
if not exist "%HOMEPATH%\.vim\rc" mkdir "%HOMEPATH%\.vim\rc"
mklink %HOMEPATH%\_vimrc %HOMEPATH%\dotfiles\.vimrc
mklink %HOMEPATH%\.vim\rc\dein.toml %HOMEPATH%\dotfiles\vim\dein.toml
mklink %HOMEPATH%\.vim\rc\dein_lazy.toml %HOMEPATH%\dotfiles\vim\dein_lazy.toml
if not exist "%HOMEPATH%\vimfiles" mkdir "%HOMEPATH%\vimfiles"
if not exist "%HOMEPATH%\vimfiles\colors" mkdir "%HOMEPATH%\vimfiles\colors"
where /Q curl && curl https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim > %HOMEPATH%\vimfiles\colors\molokai.vim
