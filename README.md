# LazyUsers

On the start page of the app there should be two tabs Home, FavoritesHome:
- Display users in the LazyVStack list https://api.github.com/users
- Every user should have a button to save to Favorites, all saved in Favorites should be recorded in the local database
- If the user is already in Favorites, show the delete button from Favorites
- When you tap on one user, show his repositories https://api.github.com/users/{login}/repos (Example: <https://api.github.com/users/Blogin/repos>)

Favorites:
- Display all user Favorites that are saved in the database


Everything must be implemented using SwiftUI, Combine, MVVM, SQLite or Core Data. With minimal or no third-party libraries
