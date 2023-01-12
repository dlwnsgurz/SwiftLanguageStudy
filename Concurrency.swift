//
//   Concurrency.swift
//  SwiftPractice
//
//  Created by LEE on 2023/01/12.
//

import Foundation

// - Topic: Concurrency
/// 비동기 코드란, 일시적으로 중단되고 다시 실행될 수 있지만 한 번에 한 코드만 실행되는 코드를 의미한다.
/// 병렬 코드는, 한 번에 여러 개의 코드를 동시에 실행되는 코드를 의미한다.

/*------------------------------------------*/
/// - Defining and Calling Asynchronous Functions
/// 비동기 메소드, 함수는 기존의 함수나 메소드가 수행하는 역할(오류 던지기,  실행 완료, 리턴 실패)들에 더불어 일시적으로 실행을 멈추는 기능까지 한다.
/// 오류를 던지는 함수는 throws키워드를 쓰듯이, 비동기 함수는 async키워드를 쓴다.
/// 만약 오류를 던지면서 비동기 함수인 경우 async throws 로 정의한다.
/// 함수나 메소드가 return을 할 때까지 중지된다.
func listPhotos(inGallery name: String) async -> [String]{
    let result // some asynchronous networking code..
    return result
}

/// 아래의 코드는 네트워크상의 사진들의 이름을 가져오고, 사진들을 다운받고, 첫번째 사진을 보여주는 코드이다. 순서대로 살펴보자.
/// 1. 첫번째 줄부터 코드가 실행되고, listPhotos가 return할 때까지 실행을 일시 중지한다.
/// 2. 실행이 중지되는 동안 다른 동시 코드가 실행된다. 이는 다음 await 포인트까지 실행된다.
/// 3. listPhotos가 값을 return 하면 코드가 다시 실행되며 photoNames에 저장된다.
/// 4. sortedNames와 name은 순차적으로 값이 저장된다.
/// 5. await 가 마크되어 있는 downloadPhoto가 return 할 때까지 실행을 멈추며, 다른 동시코드가 실행될 기회를 제공한다.
/// 6. downloadPhoto가 return을 하면 show()에 인자로 전달된다.
let photoNames = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)

/// 비동기 함수는 코드의 실행을 일시적으로 중단하고, 해당 쓰레드의 다른 동기 코드가 실행될 수 있도록한다. 이를 쓰레드 양보라고한다.
/// 비동기 함수에 의해 코드의 실행이 일시적으로 중단되므로, 비동기 함수는 특정 위치에서만 호출될 수 있다.
/// 1. 비동기 함수, 메소드에서 호출할 수 있다.
/// 2. @main으로 표시되고, 구조체. 클래스. 열거형의 메서드에 있는 코드
/// 3. 아래의 예시들처럼 구조화 되지 않은 하위 작업의 코드

/// 아래의 코드는 앱의 불변성을 위반한다.
/// 왜냐하면, firstPhoto가 두 갤러리에 일시적으로 동시에 존재하기 때문이다.
/// add와 remove 사이에 비동기 함수를 호출한다면, 앱 내에서 문제가 발생할 수 있으므로,
/// 이를 해결해야한다.
let firstPhoto = await listPhotos(inGallery: "Summer Vacation")[0]
add(firstPhoto, toGallery: "Road Trip")
// At this point, firstPhoto is temporarily in both galleries.
remove(firstPhoto, fromGallery: "Summer Vacation")

/// 아래의 함수는 동기 함수이므로, 중단 가능한 지점(즉, 비동기 함수를 호출할 수 없다)을 추가할 수 없다.
/// 만약 비동기 함수를 호출한다면, 컴파일 에러가 발생한다.
func move(_ photoName: String, from source: String, to destination: String) {
    add(firstPhoto, toGallery: destination)
    remove(firstPhoto, fromGallery: source)
}

/*------------------------------------------*/

/// - Asynchronous Sequences
/// 위의 함수는 배열 전체가 이용가능해진 경우에 return한다.
/// 비동기 시퀸스는 한 요소가 이용 가능해질때까지 실행을 중지하다가 한 요소가 이용 가능해지면 실행을 한다.
/// 매 iteration 마다 await 이 호출되어 요소가 이용 가능해질때까지 실행을 중지한다.
/// 별개로, for-in 루프는 Sequence 프로토콜을 따라야하고, 비동기 시퀸스를 쓰기 위해선 AsynchronoousSequence 프로토콜을 따라야한다.
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines{
    print(line)
}

/*------------------------------------------*/

/// - Calling Asynchronous Functions in Parallel
/// 아래의 코드의 경우 첫번째 사진을 다운받을 때까지 실행이 멈춘다.
/// 이후, 두번째 사진을 다운 받을 떄까지 실행이 멈춘다.
/// 이후, 세번째 사진을 다운 받을 떄까지 실행이 멈춘다.
/// 이 방식의 단점은 한번에 하나의 사진만 다운받아 진다는 것이다.
let firstPhoto = await downloadPhoto(named: photoNames[0])
let secondPhoto = await downloadPhoto(named: photoNames[1])
let thirdPhoto = await downloadPhoto(named: photoNames[2])

let photos = [firstPhoto, secondPhoto, thirdPhoto]

/// 비동기 함수를 병렬로 실행되게 함으로써 이를 해결할 수 있다.
/// 아래의 코드는 각 사진이 다운될때까지 기다릴필요 없이 각자 실행된다.
/// 또한, 자원이 충분하다면 동시에 다운로드가 진행될 수 있다.
/// 각 비동기 함수의 호출은 기다릴 필요 없으므로 await 키워드를 붙이지 않는다.
/// 이때, 실행은 await 키워드를 만나면 중지된다. 왜냐면 각 사진들이 다운로드 될 때까지 기다려야하기 때문이다(최초 접근 시)
async let firstPhoto = downloadPhoto(named: photoNames[0])
async let secondPhoto = downloadPhoto(named: photoNames[1])
async let thirdPhoto = downloadPhoto(named: photoNames[2])

let photos = await [firstPhoto, secondPhoto, thirdPhoto]

/*------------------------------------------*/

/// - Tasks and Task Groups
/// 작업 비동기적으로 실행될 수 있는 코드 단위이다.
/// 작업들은 각자 하위 - 상위 작업을 가질 수 있으며, 계층적으로 구분된 작업을 구조화된 작업들이라고 한다.
/// 이를 통해 취소 전파와 같은 일부 동작들을 처리할 수 있으며, 컴파일 시간에 오류를 검출할 수 있다.
/// 아래는 구조화된 작업이다.
/// 위에 있는 async - let 구문은 하위 작업들을 생성하는 것이다.
await withTaskGroup(of: Data.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name) }
    }
}

/// 구조화되지 않은 작업은 부모 작업이 없다.
/// 스위프트는 자율성을 위해 구조화되지 않은 작업을 제공하지만, 이에 대한 책임은 나에게 달렸다.
/// 구조화되지 않은 작업을 생성하기 위해 Task.init()을 사용할 수 있다.
/// task는 결과를 기다리거나 취소하는 task를 return한다.
let newPhoto = // ... some photo data ...
let handle = Task {
    return await add(newPhoto, toGalleryNamed: "Spring Adventures")
}
let result = await handle.value

/*------------------------------------------*/

/// - Actors
/// 프로그램을 동시성 조각으로 분리하기 위해 Task를 사용할 수 있다.
/// 이떄, 작업은 서로 분리되어 있어 안전하게 실행될 수 있다.
/// 만약, 각 작업간의 상호작용이 필요한 경우가 발생한다면, Actor를 사용하면된다.
/// Actor는 클래스와 같이 참조 타입이다.
/// 클래스와 다르게 행위자는 한 번에 하나의 작업만 변경가능한 상태에 접근할 수 있도록
/// 허용하기 때문에 여러 작업이 하나의 행위자 인스턴스에 접근하는 경우에도 안전하다 할 수 있다.
/// 다음은 온도를 기록하는 행위자이다.
actor TemperatureLogger {
    let label: String
    var measurements: [Int]
    private(set) var max: Int

    init(label: String, measurement: Int) {
        self.label = label
        self.measurements = [measurement]
        self.max = measurement
    }
}

// 다른 작업이 logger 인스턴스에 접근중인 경우 기다려야 하므로 await 키워드를 명시한다.
let logger = TemperatureLogger(label: "logger", measurement: 25)
print(await logger.max)

/// 행위자의 코드 내부에 update 메소드를 추가해보자.
/// 새로운 온도가 배열에 들어오고, 최대 온도가 갱신되는 사이 문제가 발생할 수 있다.
/// 하지만, 코드 내부에서는 await 키워드를 붙힐 필요가 없다.
/// 오로지 헹위자 내부에서만 await 키워드 없이 접근할 수 있다. 이를 행위자 분리(actor isolation)라고 부른다
extension TemperatureLogger {
    func update(with measurement: Int) {
        measurements.append(measurement)
        if measurement > max {
            max = measurement
        }
    }
}

/*------------------------------------------*/

/// - Sendable Types
/// ?
