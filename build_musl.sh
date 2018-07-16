set -ex
td=$(mktemp -d)

pushd $td
git clone https://github.com/richfelker/musl-cross-make .

echo "TARGET = arm-linux-musleabihf" > config.mak
echo "OUTPUT = /usr/local/musl" >> config.mak

make -j$(nproc)
make install

popd
rm -rf $td