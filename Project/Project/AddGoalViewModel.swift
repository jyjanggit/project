import Foundation

protocol AddGoalViewModelDelegate: AnyObject {
  func didAddGoal(_ goal: Goal)
}

final class AddGoalViewModel {
  
  weak var delegate: AddGoalViewModelDelegate?
  
  func addGoal(
    goal: String,
    initValue: Double,
    goalValue: Double,
    unit: String,
    changeType: ChangeType
  ) {
    let newGoal = Goal(
      goal: goal,
      initValue: initValue,
      currentValue: initValue,
      goalValue: goalValue,
      unit: unit,
      type: changeType
    )
    
    delegate?.didAddGoal(newGoal)
  }
}




