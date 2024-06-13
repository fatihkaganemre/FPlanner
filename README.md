# FPlanner
It is a sample app for trying SwiftUI and SwiftData
It allows you to:
- Create training (gym , karate, custom)
- Display list of trainings
- Edit/Remove trainings

# Tech stack
- SwiftUI
- SwiftData

# What is next: 
- Routing
- Add Tests //  Try out swift testing framework


Notification
- Notifying user for the training 
- 2 Notification first 10 min before , the second during the training time
- When the training time notification arrived , place a start button 
- When start tapped , display a view which shows the exercises 

Start Training View 
- It should start a training depends on its type 
- if there is a duration display a timer with a nice animation
- Tracking the exercises and ringing an alarm once the exercise completes
    - Live activity widget configuration
    - .supplementalActivityFamilies([.small]) for watchOS

Extra Ideas
- Try to add Siri feature the the app (App Intents API)
- Is there any way to ask ChatGPT in the app for better training ? 
- Maybe use Image playground sheet to let users to add some image to training
- Create a graph of gym exercises
- Allow to update exercises 
- Create a sample data with PreviewModifier in Swift 6.0


Swift Data
- Maybe use #Predicate for searching training 
- Use #Index for indexing the name and date , because we search by name or date 
