
# MobSF and Android Studio Emulator for Dynamic Analysis: Challenges and Solutions

Recently ventured into APK reverse engineering using MobSF and Android Studio Emulator for dynamic analysis. Here are the key points, challenges, and their solutions I encountered during this process.

---

## Environment setup
* Install MobSF.

```bash
$ git clone https://github.com/MobSF/Mobile-Security-Framework-MobSF.git
$ cd Mobile-Security-Framework-MobSF
./setup.sh
```

* Ensure server running, accessible via web interface.

   > Note:docker installation doesn't support dynamic analysis

## Android Studio Emulator configuration

* Install Android Studio.

* Create virtual device with AVD Manager.

* Select suitable Android version (API < 28), device profile.

  >  Note: MobSF supports API levels up to 28.
Verify emulator connection with adb.

```bash
$ adb devices
```

---

## APK analysis using MobSF

* Upload target APK to MobSF.

* Examine detailed report: permissions, activities, services, etc.

## APK installation on emulator

* Install analyzed APK via adb command.

```bash
$ adb install <PATH_TO_APK>
```

* Launch application, explore functionalities.

## Dynamic analysis challenges and solutions

* Monitor app behavior, network requests, file system changes.

* Use MobSF tools: live API monitor, log viewer.

* Observe app interactions with system, other apps.

* Challenge 1: MobSF and Android Studio Emulator communication issue

   * Solution: Use writable mode

```bash
$ emulator -avd <AVD_NAME> -writable-system
```

* Challenge 2: MobSF compatibility with emulator API level

   * Solution: Ensure emulator uses API level <= 28


   > Note: Default system is API 31, downgrade to a compatible version.

## Concluding the session

* Close emulator, stop MobSF server.

* Review findings, take notes on app behavior, vulnerabilities, further exploration areas.

---

Here's a summary of my experience using MobSF and Android Studio Emulator for dynamic analysis in APK reverse engineering, including challenges and their solutions. It was a valuable learning opportunity, highlighting the inner workings of Android applications and potential security risks.

Please share any suggestions or questions in the comments!