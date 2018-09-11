
if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="blue"; fi

PROMPT='%{$fg[$NCOLOR]%}%c%{$fg[$NCOLOR]%}%p$(git_prompt_info)%{$reset_color%} »%{$reset_color%} '


function git_stashed(){
 if [ "$(git rev-parse --verify --quiet refs/stash  2>/dev/null)" != "" ] ; then echo "▲ " 
fi
}


git_status_color(){
   if [ "$(git diff --cached --no-ext-diff --numstat 2> /dev/null)" ] ; then  # Staged
	echo %{$fg[yellow]%}
   elif [  "$(git status -s --ignore-submodules=dirty  2> /dev/null)"  ] ; then #Dirty 
	echo  %{$fg[red]%}
   else 
	echo %{$fg[green]%} 
   fi 
}

function git_count(){
 echo $(git rev-list --left-right '@{upstream}...HEAD' 2> /dev/null |  awk '/>/ {a += 1} /</ {b += 1} END {if (a > 0 || b > 0) printf(" "); if (a > 0) printf("%s%d","↑",a); if (b > 0) printf("%s%d","↓",b) }')
}



git_prompt_info(){
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo ":$(git_status_color)$(git_stashed)$(git_current_branch)%{$reset_color%}$(git_count)"
}





# See http://geoff.greer.fm/lscolors/
export LSCOLORS="exfxcxdxbxbxbxbxbxbxbx"
export LS_COLORS="di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=31;40:cd=31;40:su=31;40:sg=31;40:tw=31;40:ow=31;40:"

