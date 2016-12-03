# ListOfPeople
Displays a list of random users from an API

To Do:

- Test JSON validity with test function using XCTests
- Take fetched data and pass it into Core Data entity with appropriate properties
- Change image cache implementation from dictionary to third party API installed via cocoapods 
- Make image view dynamic to display proper size 
- Present modal view on top of detail view to display more personal information about the user: username, password, cell #, etc.
- Create loading state for table view or activity Indicator while data is being fetched
- User network activity monitor from xcode instruments to ensure that images are being cached properly and no extra network calls are being made. (Let's not drain the user's battery, lol)
