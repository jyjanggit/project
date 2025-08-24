import Foundation

enum ChangeType: Int {
  case decrease = 0 // 감소
  case increase = 1 // 증가
}

struct Goal {
  let goal: String // 목표 이름
  let initValue: Double // 초기값
  let currentValue: Double // 현재값
  let goalValue: Double // 목표값
  let unit: String // 단위
  let type: ChangeType // 감소, 증가
}

// 입력시 계산해야 하는 것: 목표까지의 값untilGoal, 프로그래스바progress, 프로그래스바의 퍼센트percent
