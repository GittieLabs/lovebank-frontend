[![Build Status](https://app.bitrise.io/app/6d0031ba53ff36bf/status.svg?token=PySaeQRmcFYXhjVGvEW_qA&branch=staging)](https://app.bitrise.io/app/6d0031ba53ff36bf)

# lovebank-frontend
Mobile app for the LoveBank app

## Installation
Please follow the following link before you proceed further.(https://flutter.dev/docs/get-started/install/macos)<br/>
You will need to have the followings installed or downloaded:

 - Flutter SDK
 - Xcode (iOS App)
 - Android Studio/VScode (Android App)


## Steps to run the Android App:

1. Download/Clone the lovebank-frontend github repo
2. For the Android App, Download the google-services.json from Firebase (It can befound on Firebase account at , Android project(LoveBank) > project Overview> project settings and scroll down)
3. Add the .json file to flutter_lovebank>android>app directory
4. Run the project on an Android Simulator (You can use either Android Studio or VSCode for this purpose)
5. You'll land in the 3 page app carousel, sliding through them to third page would give you the Sign In/Create an Account options
6. click the 'Create An Account' page to create a new account
      - email should be a valid working email
      - Password Should be at least 8 characters long
      - Takes you to home screen if it works
      - Shows an error message otherwise
7.  logout should bring you back to home page
8.  Sign In with an email and password that you have already created
      - Takes you to home screen with valid credentials
      - Error Message otherwise

## Steps to run the iOS App:
The flask app is connected to the Firebase. In order to run the app, you need to download `GoogleService-Info.plist` from the Firebase project overview page. Add the `.plist` file into `flutter_lovebank -> ios -> Runner`.

If you are using the Android Studio: 
 - Follow `flutter_lovebank -> ios` and right click `Runner.xcworkspace` and find `Flutter -> Open iOS module in XCode`. 
 - You need to add `GoogleService-Info.plist` using Xcode or building the iOS app will throw an error. 
 - Once you are done, choose your iOS simulator and click 'Run'. Enjor the beautiful love bank iOS app. <br/>

If you want to run with the command line:
 - In the flutter_lovebank directory, open a simulator: `open -a Simulator`
 - Run the Flutter App:`flutter run` 
