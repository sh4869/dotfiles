if type -q nodenv
    status --is-interactive; and source (nodenv init - --no-rehash|psub)
end
if type -q pyenv
    status --is-interactive; and source (pyenv init - --no-rehash|psub)
    eval (pyenv init --path)
end
if type -q rbenv
    status --is-interactive; and source (rbenv init - --no-rehash|psub)
end
set PATH /usr/local/opt/gettext/bin $PATH

