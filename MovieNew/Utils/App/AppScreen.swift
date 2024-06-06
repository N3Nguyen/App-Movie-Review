import Foundation
public enum AppScreen {
  
    case home
    case playing
    case profile
    case detail
    case main
    case rateReview
    case trailerMovie

    var storyBoardName: String {
        switch self {
        case .home:
            return "HomeScreen"
        case .playing:
            return "PlayingScreen"
        case .profile:
            return "ProfileScreen"
        case .detail:
            return "DetailMovie"
        case .main:
            return "Main"
        case .rateReview:
            return "RateAndReview"
        case .trailerMovie:
            return "TrailerScreen"
        }
    }
}
