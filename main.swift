//class AudioChannel{
//    static let thresholdLevel = 10
//    static var maximumChannelLevel = 0
//    var currentLevel: Int{
//        get{ currentLevel}
//        set{
//            if currentLevel > AudioChannel.thresholdLevel{
//                currentLevel = AudioChannel.thresholdLevel
//            }
//            if currentLevel > AudioChannel.maximumChannelLevel{
//                AudioChannel.maximumChannelLevel = currentLevel
//            }
//        }
//
//    }
//
//}

class AudioChannel{
    static let thresholdLevel = 10
    static var maximumChannelLevel = 0
    var currentLevel: Int = 0{
        didSet{
            if currentLevel > AudioChannel.thresholdLevel{
                currentLevel = AudioChannel.thresholdLevel
            }
            if currentLevel > AudioChannel.maximumChannelLevel{
                AudioChannel.maximumChannelLevel = currentLevel
            }
        }
            
    }
    
}
