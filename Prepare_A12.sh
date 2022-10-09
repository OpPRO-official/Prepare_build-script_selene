#!/bin/bash
echo "Warning! For this script need installed git!"
echo ""
sleep 2

echo "Welcome to prepare script by @oleg_oppro (Telegramm) for roms A12-A12L!"
echo ""
sleep 1

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

elif [ -d "vendor/nusantara" ]; then
	echo "nusantara folder found! Use on configs nusantara prefix"
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
elif [ -d "vendor/corvus" ]; then
	echo "corvus folder found! Use on configs corvus prefix"
	NameSpace_old="corvus"

else
 echo -n "Detected unknow prefix on your rom! Please, write prefix. (ex. aosp, lineage, dot): "
 read NameSpace_old

fi







# Links and other
NameSpace=$NameSpace_old
NameSpace+=_selene.mk
Devicetree="https://github.com/OpPRO-official/android_device_redmi_selene.git -b twelve device/xiaomi/selene"
Sepolicy_vndr="https://github.com/OpPRO-official/device_mediatek_sepolicy_vndr_backup.git -b 12.1 device/mediatek/sepolicy_vndr"
Kernel="https://github.com/OpPRO-official/android_kernel_xiaomi_selene_backup.git --depth=1 -b twelve kernel/xiaomi/selene"
Vendor="https://github.com/OpPRO-official/android_vendor_xiaomi_selene_backup.git -b twelve vendor/xiaomi/selene"
Mt6768ims="https://github.com/OpPRO-official/android_vendor_xiaomi_mt6768-ims_backup.git -b twelve vendor/xiaomi/mt6768-ims"
Dirac="https://github.com/OpPRO-official/vendor_dirac_backup.git -b twelve vendor/dirac"

echo ""
echo "Nice! Go next"
echo ""
sleep 2
echo "First, i prepare device folder"
echo ""
# Download device tree
git clone $Devicetree
git clone $Sepolicy_vndr
echo ""
# Config device tree
rm -rf device/xiaomi/selene/cherish.dependencies
mv device/xiaomi/selene/cherish_selene.mk device/xiaomi/selene/$NameSpace
sed -i "s/cherish/${NameSpace_old}/g" device/xiaomi/selene/AndroidProducts.mk
sed -i "s/cherish/${NameSpace_old}/g" device/xiaomi/selene/$NameSpace
# common_full_phone checker
if test -f "vendor/$NameSpace_old/config/common_full_phone.mk"; then
	echo "File common_full_phone.mk exists, no need to change"


else
  echo "File common_full_phone.mk don't exists, i change $NameSpace..."
  sed -i "s/common_full_phone.mk/common.mk/g" device/xiaomi/selene/$NameSpace
  echo "Changed!"

fi

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
# Download Vendor, mt6768-ims, and Dirac-vendor
git clone $Vendor
git clone $Mt6768ims
git clone $Dirac

echo ""
# VoLTE source code patcher
if test -f "frameworks/opt/net/ims/src/java/com/android/ims/ImsServiceBase.java"; then
	echo "VoLTE patch don't need, nice!"

else
  echo "Ah, shit, need VoLTE patch!"
  rm -rf frameworks/opt/telephony/src/java/com/android/internal/telephony/metrics/TelephonyMetrics.java
  sleep 1
  rm -rf frameworks/opt/net/ims/src/java/com/android/ims/ImsManager.java
  sleep 1
  cp TelephonyMetrics.java frameworks/opt/telephony/src/java/com/android/internal/telephony/metrics/TelephonyMetrics.java
  sleep 1
  cp ImsManager.java frameworks/opt/net/ims/src/java/com/android/ims/ImsManager.java
  sleep 1
  cp ImsServiceBase.java frameworks/opt/net/ims/src/java/com/android/ims/ImsServiceBase.java
  sleep 1
  echo "VoLTE patch done!"
  
fi

echo ""
echo "On my script i use sources codes by @yazidkucrit (Telegramm) and @Mikazuuu07 (Telegramm)"
echo ""
sleep 1
echo "Done! Don't forget include volte fix if need!"
