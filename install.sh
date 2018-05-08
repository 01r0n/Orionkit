clear
echo "

 ██████╗ ██████╗ ██╗ ██████╗ ███╗   ██╗██╗  ██╗██╗████████╗
██╔═══██╗██╔══██╗██║██╔═══██╗████╗  ██║██║ ██╔╝██║╚══██╔══╝
██║   ██║██████╔╝██║██║   ██║██╔██╗ ██║█████╔╝ ██║   ██║
██║   ██║██╔══██╗██║██║   ██║██║╚██╗██║██╔═██╗ ██║   ██║
╚██████╔╝██║  ██║██║╚██████╔╝██║ ╚████║██║  ██╗██║   ██║
 ╚═════╝ ╚═╝  ╚═╝╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝   ╚═╝

██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗     ███████╗██████╗
██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║     ██╔════╝██╔══██╗
██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║     █████╗  ██████╔╝
██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║     ██╔══╝  ██╔══██╗
██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████╗███████╗██║  ██║
╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝
";

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/orionkit"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/orionkit"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.orionkit"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory orionkit was found! Do you want to replace it? [Y/n]:" ;
    read mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/orionkit*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/orionkit*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/Orion" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/Orion"
    else
        sudo rm -rf "$ETC_DIR/Orion"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/01r0n/orionkit "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/orionkit.py" '${1+"$@"}' > "$INSTALL_DIR/orionkit";
chmod +x "$INSTALL_DIR/orionkit";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/orionkit" "$BIN_DIR"
    cp "$INSTALL_DIR/orionkit.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/orionkit" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/orionkit.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/orionkit";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing orionkit !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
