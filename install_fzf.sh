# wget https://github.com/junegunn/fzf-bin/releases/download/0.17.5/fzf-0.17.5-linux_amd64.tgz

case $SHELL in
*/zsh)
  wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh
  wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh
  shell="zsh"
   ;;
*/bash)
  wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.bash
  wget https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.bash
  shell="bash"
   ;;
*)
  echo "Unsupported Shell: ${SHELL}"
  exit 1
esac

cd ~

fzf_key_bindings=`cat key-bindings.${shell}`
fzf_completion=`cat completion.${shell}`

src_file="~/.fzf.${shell}"

cat > "$src_file" << EOF
# Auto-completion
# ---------------
$fzf_completion
# Key bindings
# ------------
$fzf_key_bindings
EOF

echo "source ${src_file}" >> ".${shell}rc"
echo "Setup completed!"
