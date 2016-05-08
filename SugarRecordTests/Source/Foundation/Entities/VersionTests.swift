import Foundation
import Quick
import Nimble
import OHHTTPStubs
import RxSwift

@testable import SugarRecordCoreData

class VersionTests: QuickSpec {
    
    override func spec() {
        describe("-lastGithub") {
            
            it("should return the last GitHub version if it's been returned by the API") {
//                stub(isPath("/repos/pepibumur/sugarrecord/releases")) { _ in
//                    let obj = [["tag_name": "x.x.x"]]
//                    return OHHTTPStubsResponse(JSONObject: obj, statusCode: 200, headers: nil)
//                }
//                waitUntil(action: { done in
//                    _ = Version.currentVersion().subscribeNext({ (next) in
//                        
//                        
//                    })
//                    _ = Version.lastGithub().subscribeNext { (version) in
//                        expect(version.value) == "x.x.x"
//                        done()
//                    }
//                })
            }
            
            it("should forward the error if the request failed") {
                //TODO
            }
        }
        
        describe("-currentVersion") {
            it("should return the current version") {
                waitUntil(timeout: 10, action: { (done) in
                    _ = Version.currentVersion().subscribeNext({ (version) in
                        print("UUUUUUU")
                        done()
                    })
                })
            }
            
        }
    }
    
}