#!/bin/bash
echo "Warning! For this script need installed git!"
echo ""
sleep 2

echo "Welcome to prepare script by @oleg_oppro (Telegramm) for roms A11!"
echo ""
sleep 1

# This is prefix finder, if you need you can add new prefix (ex. aosp_selene.mk file and other)


# example add new prefix finder
# elif [ -d "vendor/" ]; then
#	echo " folder found! Use on configs  prefix"
#	NameSpace_old=""
if [ -d "vendor/aosp" ]; then
	echo "aosp folder found! Use on configs aosp prefix"
	NameSpace_old="aosp"

elif [ -d "vendor/lineage" ]; then
	echo "lineage folder found! Use on configs lineage prefix"
	NameSpace_old="lineage"

elif [ -d "vendor/dot" ]; then
	echo "dot folder found! Use on configs dot prefix"
	NameSpace_old="dot"

elif [ -d "vendor/blaze" ]; then
	echo "blaze folder found! Use on configs blaze prefix"
	NameSpace_old="blaze"

elif [ -d "vendor/nad" ]; then
	echo "nad folder found! Use on configs nad prefix"
	NameSpace_old="nad"

elif [ -d "vendor/evolution" ]; then
	echo "evolution folder found! Use on configs evolution prefix"
	NameSpace_old="evolution"

elif [ -d "vendor/cherish" ]; then
	echo "cherish folder found! Use on configs cherish prefix"
	NameSpace_old="cherish"

elif [ -d "vendor/xdroid" ]; then
	echo "xdroid folder found! Use on configs xdroid prefix"
	NameSpace_old="xdroid"

elif [ -d "vendor/spark" ]; then
	echo "spark folder found! Use on configs spark prefix"
	NameSpace_old="spark"

elif [ -d "vendor/ancient" ]; then
	echo "ancient folder found! Use on configs ancient prefix"
	NameSpace_old="ancient"

elif [ -d "vendor/komodo" ]; then
	echo "komodo folder found! Use on configs komodo prefix"
	NameSpace_old="komodo"

elif [ -d "vendor/octavi" ]; then
	echo "octavi folder found! Use on configs octavi prefix"
	NameSpace_old="octavi"

elif [ -d "vendor/bliss" ]; then
	echo "bliss folder found! Use on configs bliss prefix"
	NameSpace_old="bliss"

elif [ -d "vendor/statix" ]; then
	echo "statix folder found! Use on configs statix prefix"
	NameSpace_old="statix"

elif [ -d "vendor/derp" ]; then
	echo "derp folder found! Use on configs derp prefix"
	NameSpace_old="derp"

elif [ -d "vendor/havoc" ]; then
	echo "havoc folder found! Use on configs havoc prefix"
	NameSpace_old="havoc"
elif [ -d "vendor/corvus" ]; then
	echo "corvus folder found! Use on configs corvus prefix"
	NameSpace_old="corvus"

else
 echo -n "Detected unknow prefix on your rom! Please, write prefix. (ex. aosp, lineage, dot): "
 read NameSpace_old

fi

NameSpace=$NameSpace_old
NameSpace+=_selene.mk
Devicetree="https://github.com/OpPRO-official/android_device_xiaomi_selene.git device/xiaomi/selene"
Sepolicy_vndr="https://github.com/OpPRO-official/device_mediatek_sepolicy_vndr_pixelexperience_backup.git -b eleven device/mediatek/sepolicy_vndr"
Clangr416183b1="https://android.googlesource.com/platform/prebuilts/clang/host/linux-x86/+archive/refs/heads/android12-release/clang-r416183b1.tar.gz"
Kernel="https://github.com/OpPRO-official/android_kernel_xiaomi_selene_backup.git --depth=1 -b twelve kernel/xiaomi/selene"
Vendor="https://github.com/OpPRO-official/android_vendor_xiaomi_selene.git vendor/xiaomi/selene"

# download device tree
sleep 1
echo ""
echo "Nice! Go next"
echo ""
sleep 2
echo "First, i prepare device folder"
echo ""
git clone $Devicetree
git clone $Sepolicy_vndr

# Config device tree
rm -rf device/xiaomi/selene/ancient.dependencies
mv device/xiaomi/selene/ancient_selene.mk device/xiaomi/selene/$NameSpace
sed -i "s/ancient/${NameSpace_old}/g" device/xiaomi/selene/AndroidProducts.mk
sed -i "s/ancient/${NameSpace_old}/g" device/xiaomi/selene/$NameSpace

# common_full_phone checker
if test -f "vendor/$NameSpace_old/config/common_full_phone.mk"; then
	echo "File common_full_phone.mk exists, no need to change"

else
  echo "File common_full_phone.mk don't exists, i change $NameSpace..."
  sed -i "s/common_full_phone.mk/common.mk/g" device/xiaomi/selene/$NameSpace
  echo "Changed!"

fi

echo ""
# Download clang for kernel
echo "Now i download clang-r416183b1 for kernel compilator"
echo ""
sleep 1
mkdir prebuilts/clang/host/linux-x86/clang-r416183b1/
cd prebuilts/clang/host/linux-x86/clang-r416183b1/
wget $Clangr416183b1
tar -xvf clang-r416183b1.tar.gz
rm -rf clang-r416183b1.tar.gz
cd ../../../../../
echo ""
echo "Good! Go next"
echo ""
sleep 2
echo "Ok, good, next, i prepare your kernel folder"
echo ""
# Download kernel
git clone $Kernel

echo ""
echo "Nice! Go next"
echo ""
sleep 2
echo "Next, i prepare your vendor"
echo ""
# download vendor
git clone $Vendor

echo ""
echo "On my script i use sources codes by @yazidkucrit (Telegramm) and @Mikazuuu07 (Telegramm)"
echo ""
sleep 1
echo "Done! Good Luck!"
