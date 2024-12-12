function new_justfile -d "create a new justfile with the default list"
  set default_text "\
default:
    @just --list\
"

  touch justfile
  echo $default_text > justfile
end
