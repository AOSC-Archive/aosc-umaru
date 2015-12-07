source ./.config

[ -e out/tools ] && rm -rf out/tools
mkdir -p out/tools

sh toolchain/binutils/pass1.sh
