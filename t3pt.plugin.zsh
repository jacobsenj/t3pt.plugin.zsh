#compdef t3pt

_t3pt_get_command_list () {
    $_comp_command1 --no-ansi 2>/dev/null | sed "1,/Available commands/d" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}

_t3pt_get_required_list () {
    $_comp_command1 show --no-ansi 2>/dev/null | sed "1,/Deployments in/d" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}
_t3pt () {
  local curcontext="$curcontext" state line
  typeset -A opt_args
  _arguments \
    '1: :->command' \
    '2: :->args' \
    '*: :->opts'

  case $state in
    command)
      compadd $(_t3pt_get_command_list)
      ;;
    args)
      case $words[2] in
        deploy|simulate|describe)
          compadd $(_t3pt_get_required_list)
          ;;
      esac
      ;;
    *)
      compadd ''
      ;;
  esac
}

compdef _t3pt t3pt
compdef _t3pt t3pt.phar