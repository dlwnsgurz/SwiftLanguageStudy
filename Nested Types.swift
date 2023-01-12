//
//  Nested Types.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/12.
//

import Foundation

// - Topic: Nested Types

/// 구조체, 클래스, 열거형들은 서로 중첩될 수 있다.
/// {} 안에 정의를 써넣으면 중첩된 타입라고 부른다.
/// 특히, 열거형은 클래스나 구조체의 기능을 지원하기위해 사용되기도 한다.

/// - Nested Types in Action
struct BlackjackCard{
    
    enum Suit: Character{
        case spades = "♠"
        case hearts = "♡"
        case diamonds = "♢"
        case clubs = "♣"
    }
    
    enum Rank: Int{
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, king, queen, ace
        
        struct Values{
            let first: Int
            let second: Int?
        }
        
        var values: Values{
            switch self{
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .king, .queen:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
        
    }
    
    let rank: Rank, suit: Suit
    var description: String{
        var output = "suit is \(suit.rawValue)"
        output += ", rank is \(rank.values.first)"
        if let second = rank.values.second{
            output += " or \(second)"
        }
        return output
        
    }
    
}

/// 위의 예에서 구조체를 정의하고 있다,
/// 따라서 멤버와이즈 이니셜라이저가 자동으로 생성된다.
/// 아래의 경우, 스위프트의 타입 추론에 의해 Rank 타입과, Suit 타입의 인스턴스를 이와 같이 전달할 수 있다.
let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
print("theAceOfSpades: \(theAceOfSpades.description)")
// Prints "theAceOfSpades: suit is ♠, value is 1 or 11"

/*------------------------------------------*/

/// - Referring to Nested Types
/// 중첩된 타입을 아래와 같이 참조할 수 있다.
let heartSymbols = BlackjackCard.Suit.spades.rawValue
print(type(of: heartSymbols)) // Character
