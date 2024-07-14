# FPlanner
It is a sample app for trying
- SwiftUI
- SwiftData
- Local Notifications
- Snapshot Testing

It allows you to:
- Create training (gym , karate, custom)
- Display list of trainings
- Add/Edit/Remove trainings
- Start a training


# TODO
- Clean the code
- Make karate duration optional! 
- Add alarm when duration finished
- When training repeats it should show the future date as Scheduled

# Tech stack
- SwiftUI
- SwiftData
- swift-snapshot-testing - from PointFree 

# What is next: 
- Notification
- Start training view
- Tests //  Try out swift testing framework
- Widgets
- Localisation
- Think about a different font and colour schema 
- WatchOS support

Notification
- Notifying user for the training 
- 2 Notification first 10 min before , the second during the training time
- When the training time notification arrived , place a start button 
- When start tapped , display a view which shows the exercises 

Start Training View 
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

Widgets 
- Use widgets to show upcoming trainings


Swift Data
- Maybe use #Predicate for searching training 
- Use #Index for indexing the name and date , because we search by name or date 
