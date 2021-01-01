# G-Know

G-Know is a flutter application devloped via using firebase, firestore and public api (in this case it is GitHub's api).

## You can:
* Get notification about your GitHub account when you get a star or/and fork to your repository
* Get notification about your Github account when you have a new follower
* Create a list with your favorite users
* Get notification from your favorite users when they share a repository
* See any user's profile with their repository names and with their main information
* Save your excellent ideas in the note part of your profile

## Getting Started
![Profile - Search - Notifications](ScreenShots/profile-search-notifications.png)
![Drawer - Search Profile - Settings](ScreenShots/drawer-searchProfile-settings.png)

## Information about app:
**1-** On the login page username: mobile and password: 123.<br>
**2-** On the Register page you can see the UI but since there is no database, it doesn't work yet.<br>
**3-** To see the images you should be connected to the Internet because we used networkImage widget. 
   (And you should wait a bit for loading of networkImages.)<br>
**4-** To see the example of how other user's profile will look like, on the search history part of search page
   you can click the user named "mustafamuratcoskun".<br>
   
## Parts of the project:
**A. User Interface:** In this part, it is expected that build up the UI of the app.<br>
**B. Getting Data from the Web:** In this part, it is expected that modify the app so that it can get the necessary data
from the web API used in the app and display it in the corresponding views of the app.<br>
**C. Local Database & Firebase:** In this part, it is expected that modify the app so that it stores the data it takes
from the web API into both a local database and remote database on Cloud Firestore, and queries the database to
display the information.<br>
**D. Services, Notifications, and Broadcast Receivers:** In this part, it is expected that modify the app so that it uses
services and broadcast receivers as well as a notification system.<br>
   
