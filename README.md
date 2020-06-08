# lovebank-frontend
Mobile app for the LoveBank app

How to run the App?(Android)

1. Download/Clone the lovebank-frontend github repo
2. For the Android App, Download the google-services.json from Firebase (Android project(LoveBank) > project Overview> project settings and scroll down)
3. Add the .json file to flutter_lovebank>android>app directory
4. Run the project on an Android emulator (You can use eithe Android Studio or VSCode for this purpose)
5. You'' land in the 3 page app carousel, sliding through them to third page would give you the Sign In/Create an Account options
6. click the 'Create An Account' page to create a new account
      - email should be a valid working email
      - Password Should be at least 8 characters long
      - Takes you to home screen if it works
      - Shows an error message otherwise
7.  logout should bring you back to home page
8.  Sign In with an email and password that you have already created
      - Takes you to home screen with valid credentials
      - Error Message otherwise

