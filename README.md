# docker-appium
Run automated tests on your mobile using Appium server

## Built with
- latest debian
- openjdk 7
- node v0.12.7
- latest appium
- Android SDK 24.3.3
- Android API 17 (for Selendroid support)

## Running the appium server
    docker run -d -p 4723:4723 -e APPIUM_ARGS="" --name appium softsam/appium

## Running the appium server to test on physical device
    docker run -d -p 4723:4723 --privileged -v /dev/bus/usb:/dev/bus/usb -e APPIUM_ARGS="" --name appium softsam/appium

## Deploying an APK

Appium can deploy apks. If you want to provide your apk, you can use the /apk volume.

    docker run -d -p 4723:4723 -e APPIUM_ARGS="" -v /home/myuser/apk:/apk --name appium softsam/appium

## Passing arguments to the appium server

If you need to pass arguments to the appium server, put it in the APPIUM_ARGS environment variable. Else, let it empty.
