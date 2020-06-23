public enum StravaAuthScope: String {

    // Read public segments, public routes, public profile data, public posts, public events, club feeds, and leaderboards
    case read = "read"

    // Read private routes, private segments, and private events for the user
    case readAll = "read_all"

    // Read all profile information even if the user has set their profile visibility to Followers or Only You
    case profileReadAll = "profile:read_all"

    // Update the user's weight and Functional Threshold Power (FTP), and access to star or unstar segments on their behalf
    case profileWrite = "profile:write"

    // Read the user's activity data for activities that are visible to Everyone and Followers, excluding privacy zone data
    case activityRead = "activity:read"

    // The same access as activity:read, plus privacy zone data and access to read the user's activities with visibility set to Only You
    case activityReadAll = "activity:read_all"

    // Access to create manual activities and uploads, and access to edit any activities that are visible to the app, based on activity read access level
    case activityWrite = "activity:write"
}
