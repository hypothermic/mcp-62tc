#!/bin/bash

###################################
#  MCP preset for Tekkit Classic  #
# github.com/hypothermic/mcp62-tc #
#                                 #
# - hypothermic, 29/9/2018        #
###################################

# --- variables


# jars folders
declare dir_jars="../jars/"
declare -a srcfiles=("bin" 
                     "resources")
declare -a patches=("ChunkProviderGenerate.patchx" 
                    "EntityPlayer.patchx"
                    "RenderGlobal.patchx" 
                    "TileEntityFurnace.patchx" 
                    "WorldGenShrub.patchx")

# --- main

cd "$(dirname "$0")/forge"

# check if nessacary source files are availible
for i in "${srcfiles[@]}"
do
    if [ ! -d "$dir_jars$i" ]; then
        echo "Error: resource $i does not exist."
        exit 1
    fi
done

# check if python is installed (any modern version)
if ! command -v python &>/dev/null; then
    echo "Error: python is not installed."
fi

# install forge
python ./install.py

# fix the fernflower errors which fffix.py couldn't fix
cd "../src/minecraft/net/minecraft/src"
for i in "${patches[@]}"
do
    echo "mcptc.sh: Applying patch $i"
    patch < "../../../../../mcptc/$i"
done

echo "mcptc.sh: Replacing EnumArt with modified version"
cp "../../../../../mcptc/EnumArt.java" "."

# finish
echo -e "\n--- mcptc successfully decompiled! ---\n"
echo "== Please report any remaining java =="
echo -e "==  decompilation errors to github! ==\n"