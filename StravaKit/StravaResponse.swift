
/// Represents a response from a completed Strava request
public enum StravaResponse<T> {
    case Success(T)
    case Failure(StravaError)
}