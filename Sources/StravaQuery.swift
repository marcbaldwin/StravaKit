public enum StravaQuery {

    case before(Int)
    case after(Int)

    var parameters: [String : Any] {
        switch self {
        case let .before(seconds): return ["before": seconds]
        case let .after(seconds): return ["after": seconds]
        }
    }
}
