#!/bin/bash
tar -xf lbrowser_icon.tar.gz

# icon
for p in `find . -name *.png` 
do
mpath=`echo $p | cut -d'/' -f2-7`
truepath="/$mpath/google-chrome.png"
echo $truepath
mv $p $truepath
done

#desktop file
cp ./google-chrome.desktop /usr/share/applications/google-chrome.desktop

#product png
tar -xf lbrowser_product.tar.gz
mv lbrowser/* /opt/google/chrome/