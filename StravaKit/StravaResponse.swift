
/// Represents a response from a completed Strava request
public enum Response<Value> {
    case Success(Value)
    case Failure(StravaError)
}