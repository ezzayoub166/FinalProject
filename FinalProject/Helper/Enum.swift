//
//  Enum.swift
//  UltimateDatingApp
//
//  Created by iosMaher on 1/14/20.
//  Copyright © 2020 MaherUliwa. All rights reserved.
//

enum GenderType : String {
    case Male = "Male"
    case Female = "Female"
    case NonBinary = "Non-Binary"
    case none = ""
}

enum BulidType : String {
    
    case villa
    case house
    case department
    
    var value: String {
        switch self {
        case .villa:
            return "Male"
        case .house:
            return "Female"
        case .department:
            return "شقة"
        default:
            return ""
        }
    }
    
    var title: String {
        switch self {
        case .villa:
            return "Male"
        case .house:
            return "Female"
        case .department:
            return "شقة"
        default:
            return ""
        }
    }
}



enum e_font_type : String {
    case Light = "Poppins-Light"
    case Medium = "Poppins-Medium"
    case Regular = "Poppins-Regular"
}


/// Mark: Category_Type
var str_photos = "Photos"
var str_videos = "Videos"
var str_recordings = "Recordings"

enum e_cate_type {

    case
    Photos,
    Videos,
    Recordings,
    None
    
    init(_ type: String) {
        switch type {
        case str_photos: self = .Photos
        case str_videos: self = .Videos
        case str_recordings: self = .Recordings
        default: self = .None
        }
    }
   
    var title: String {
        switch self {
        case .Photos: return str_photos
        case .Videos: return str_videos
        case .Recordings: return str_recordings
        case .None: return ""
        }
    }

    var desc: String {
        switch self {
        case .Photos: return str_photos
        case .Videos: return "clips"
        case .Recordings: return "files"
        case .None: return ""
        }
    }
    
}
///


enum e_media_type {
    
    case
    Photo,
    Video,
    Record,
    None

    init(_ type: String) {
        switch type {
        case "photo": self = .Photo
        case "video": self = .Video
        case "recording": self = .Record
        default: self = .None
        }
    }

    var type: String {
        switch self {
        case .Photo:
            return "photo"
        case .Video:
            return "video"
        default:
            return "recording"
        }
    }
    
}


enum Strings : String {

    case StoreNameRequired = "Store name is required"
    case CreateAccountSuccessfully = "Your account has been created successfully . Please check your Inbox"
    case PleaseVerifyEmail = "Please verify your email"
    case ChangedSuccessfully = "Changed successfully"
    case ProfileUpdatedSuccessfully = "Profile updated successfully"
    case AddedSuccessfully = "Added successfully"
    case ReviewRequired = "Review is required"

    case ReportedSuccessfully = "Reported successfully"
    case PasswordChangedSuccessfully = "Password changed successfully"
    case OldPasswordWrong = "Old password is wrong"
    case OldPasswordisRequired = "Old password is required"
    case NewPasswordisRequired = "New password is required"
    case InvalidEmail = "Enter a valid email"
    case EmailAlreadyInUse = "The e-mail address that you entered is already in use. Enter a different e-mail address"
    case NoInternetConnection = "Check your internet connection"
    case WeakPassword = "Weak password was entered . Password must contains at least 6 Characters"
    case UserNotFound = "This account was not found"
    case WrongPassword = "Wrong Email or Password"
    case RequiresRecentLogin = "You must login again"
    case UnKnownProblem = "An error occurred please try again later"
    case NameRequired     = "Name is required"
    case AllFieldsRequired = "All fields are Required"
    case EmailRequired = "Email is required"
    case LocationRequired = "Location is required"
    case PasswordRequired = "Password is required"
    case ConfirmPasswordRequired = "Confirmation password is required"
    case PasswordAndConfirmationNotMatch = "The New Password and Confirmation Password must match"
    case Logout = "Do you want to logout?"
    case PasswordSent = "Your password has been sent to you"
    case AddressRequired = "Address is required"
    case PhotoRequired = "Photo is required"
    case DescRequired = "Description is required"
    case ExpiryDateRequired = "Expiry date is required"

    case ProdName = "Product name is required"

//    case NickNameRequired = "Nickname is required"
//    case AgeRequired      = "Age is required"
//    case GenderRequired   = "Gender is required"
//    case MaritalStatusRequired  = "Marital status is required"
//    case HobbiesRequired    = "Hobbies is required"
//    case FamilyRequired    = "Family is required"
//    case MusicRequired    = "Music is required"
//    case LiveNameRequired = "Live name is required"
//    case CommentPhotoRequired = "Comment/Photo is required"
//    case RequestVendor = "Your request has been sent"
//    case AlreadyPartner = "You already partner"
//    case PreviewDateRequired = "Date preview is required"
//    case EventTitleRequired = "Title is required"
//    case PhotoVideoRequired = "Photo/Video is required"
//    case DateFromRequired = "Date from is required"
//    case DateToRequired = "Date to is required"
//    case FilterRequired = "Choose filter type"
//    case TrophyRequired = "Trophy is required"
//    case IntentRequired = "Intent is required"
//    case SeekingRequired = "Seeking is required"
//    case UpcomingEventRequired = "Upcoming event is required"
//    case ReligionRequired = "Religion is required"
//    case EthnicityRequired = "Ethnicity is required"
//    case LifeStyleCultureRequired = "Life Style/Culture is required"
//    case PreviousAchievementsRequired = "Previous year achievements is required"
//    case DirectionLifeRequired = "Direction in life is required"
//    case DrugChoiceRequired = "Drug of choice is required"
//    case RemovedSuccessfully = "Removed successfully"
//    case ClubRequired = "Club name is required"
//    case CompleteProfile = "Please complete your profile"
//    case ResumeRequired = "Resume is required"
//    case MobileRequired = "Mobile is required"
//    case GenderRequired = "Gender is required"
//    case PickCV = "Please pick your cv"
//    case HobbyRequired = "Please select a hobby"
//    case CompanyRequired  = "Company name is required"
//    case PositionRequired = "Position is required"
//    case BioRequired = "Bio is required"
    case CommentRequired = "Comment is required"
}
