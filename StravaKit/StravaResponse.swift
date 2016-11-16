
/// Represents a response from a completed Strava request
public enum Response<Value> {
    case success(Value)
    case failure(StravaError)
}
