import Foundation

internal class VersionController {
    
    // MARK: - Internal
    
    internal func verifyAndLog() {
        _ = Version.newVersion().subscribeNext { newVersion in
            print("SugarRecord: There's a new version available \(newVersion)'")
        }
    }
    
}
