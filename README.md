
# Strava Kit
A Swift client for the V3 of the Strava API using [Moya](https://github.com/Moya/Moya)


### Cocoapods Setup
```bash
pod 'StravaKit', :git => 'https://github.com/marcbaldwin/StravaKit', :tag => '<insert-tag>'
```


### RxSwift Example

```Swift

import RxSwift
import StravaKit
import Moya

// ...

let api = MoyaProvider<StravaApi>()

// Fetch athlete's latest 20 activities

stravaApi.rx
  .request(.athleteActivities(
    accessToken: "user-access-token", query: [], page: 1, pageSize: 20
  ))
  .filterSuccessfulStatusCodes()
  .map { response in
    try JSONDecoder().decode(Array<StravaKit.Activity>.self, from: response.data)
  }
  .subscribe(
    onNext: { activities in
      // Do something with the result
    },
    onError: { error in
      // Handle the error
    }
  )
  .disposed(by: disposeBag)

```
