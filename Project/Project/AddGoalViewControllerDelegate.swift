import Foundation

protocol AddGoalViewControllerDelegate: AnyObject {
  func didAddGoal(goal: String,target: Double, unit: String, type: Int, initPercent: Double, initProgress: Double, untilGoal: Double)
}
