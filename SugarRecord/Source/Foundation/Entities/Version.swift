import Foundation
import RxSwift

internal class Version: NSObject {
    
    //  MARK: - Constants
    
    private static let apiReleasesUrl: String = "http://api.github.com/repos/pepibumur/sugarrecord/releases"
    
    
    // MARK: - Attributes
    
    internal let value: String
    
    
    // MARK: - Init
    
    internal init(value: String) {
        self.value = value
        super.init()
    }
    
    
    //  MARK: - Internal
    
    internal static func newVersion() -> RxSwift.Observable<Version> {
        return RxSwift.Observable
            .combineLatest(self.currentVersion(), self.lastGithub(), resultSelector: {(current: $0, github: $1)})
            .filter { $0.current != $0.github }
            .map { $0.0 }
    }
    
    internal static func currentVersion() -> RxSwift.Observable<Version> {
        return RxSwift.Observable.create { observer -> Disposable in
            if let version = NSBundle(forClass: Version.classForCoder()).objectForInfoDictionaryKey("CFBundleShortVersionString") as? String {
                observer.onNext(Version(value: version))
            }
            observer.onCompleted()
            return NopDisposable.instance
        }
    }
    
    internal static func lastGithub() -> RxSwift.Observable<Version> {
        return RxSwift.Observable.create { observer -> Disposable in
            let request: NSURLRequest = NSURLRequest(URL: NSURL(string: Version.apiReleasesUrl)!)
            NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration()).dataTaskWithRequest(request, completionHandler: { (data, response, error) in
                if let data = data {
                    let json: AnyObject? = try? NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
                    if let array = json as? [[String: AnyObject]], let lastVersion = array.first, let versionTag: String = lastVersion["tag_name"] as? String {
                        observer.onNext(Version(value: versionTag))
                    }
                    observer.onCompleted()
                }
                else if let error = error {
                    observer.onError(error)
                }
                else {
                    observer.onCompleted()
                }
            }).resume()
            return NopDisposable.instance
        }
    }
    
}

func == (lhs: Version, rhs: Version) -> Bool {
    return lhs.value == rhs.value
}
