
/// Represents a response from a completed Strava request
public enum Response<T> {
    case Success(T)
    case Failure(StravaError)
}