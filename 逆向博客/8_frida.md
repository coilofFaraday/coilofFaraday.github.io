# Debugging Android Apps with Frida

Frida is a dynamic instrumentation toolkit that allows developers to inject scripts into running applications. With Frida, developers can debug Android apps without modifying the source code or using a debugger. In this article, we'll cover the basics of using Frida for debugging Android apps.

---

## Setting up the Environment
To set up the environment, you'll need to install the necessary software and configure your Android device.

* Install ADB: You'll need to install ADB (Android Debug Bridge) on your computer to connect to your Android device.

* Enable USB Debugging: You'll need to enable USB debugging on your Android device to allow ADB to connect to it.

* Install Frida Server: You'll need to install Frida server on your Android device to allow Frida to inject scripts into running apps.

## Using Frida

Once you've set up the environment, you can use Frida to inject scripts into running apps. Here's a simple example of a Frida script that logs the calls to the Android API:

```Javascript
Java.perform(function () {
    var Activity = Java.use('android.app.Activity');
    Activity.onResume.implementation = function () {
        console.log('[*] Activity.onResume() called');
        this.onResume();
    };
});

This script uses the Java.perform function to hook into the onResume method of the Activity class. When the onResume method is called, the script logs a message to the console.

To use the script, save it as a .js file and run it with the Frida command-line tool:

css
Copy code
frida -U -f com.example.app -l script.js --no-pause
This command launches the com.example.app app and injects the script.js script into it. The --no-pause option prevents Frida from pausing the app after injection.

Debugging with Frida
To debug an app with Frida, you'll need to hook into the methods and objects you want to debug. Here's an example of hooking into the WebView class:

javascript
Copy code
Java.perform(function () {
    var WebView = Java.use('android.webkit.WebView');
    WebView.loadUrl.overload('java.lang.String').implementation = function (url) {
        console.log('[*] WebView.loadUrl() called with url: ' + url);
        this.loadUrl(url);
    };
});
This script hooks into the loadUrl method of the WebView class and logs the URL being loaded to the console.

Conclusion
Frida is a powerful tool for debugging Android apps. With its dynamic instrumentation capabilities, developers can easily inject scripts into running apps to monitor and modify their behavior. By understanding the basics of Frida and its API, developers can debug their apps without modifying the source code or using a debugger.