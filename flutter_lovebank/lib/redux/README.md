# Redux


This README is intended to help with the concept of redux, and how it's been implemented in this app.

First of all, read these two links (don't worry if you don't understand everything in them):
  - https://blog.novoda.com/introduction-to-redux-in-flutter/
  - https://medium.com/shift-studio/flutter-redux-and-firebase-cloud-firestore-in-sync-2c1accabdac4

The first link deals with redux in flutter in general, and the second is an implementation of firestore automatic update listening that the firestore listening in our app is based on.

# Important Points

  - Always have the reducer return a separate copy of the app state modified as desired. (Don't directly modify the app state)
  - The automatic firebase listening all happens within the middleware.
  - The middleware in our app is currently all in the form of epics
  - Epics are a type of middleware that accept a stream of all actions passed through middleware as a parameter and returns a modified stream of actions that are passed to the reducer. (as opposed to receiving one action at a time)
  - The basic idea for the firestore listening is to have an epic return the firestore update stream after a "listen" action has been received by the epic and until a "stop listening" action is received by the epic.
  - Use a StoreConnector widget anywhere in the widget tree that you need to access or modify state that exists in the Redux store.
  - Modifying a piece of state held in the Redux store from the widget tree should be done by using a StoreConnector and using "converter:" to create a callback containing "store.dispatch([ACTION])" in some form and then calling that callback at the proper point in the widget tree code.

