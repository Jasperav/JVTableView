public extension Array where Element: Restartable {
    public func pauseAll() {
        for restartable in self {
            restartable.pause()
        }
    }
    
    public func resumeAll() {
        for restartable in self {
            restartable.resume()
        }
    }
}


public extension Set where Element: Restartable {
    public func pauseAll() {
        for restartable in self {
            restartable.pause()
        }
    }
    
    public func resumeAll() {
        for restartable in self {
            restartable.resume()
        }
    }
}
