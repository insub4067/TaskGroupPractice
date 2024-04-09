import SwiftUI

struct TaskGroupPractice: View {
    var body: some View {
        Button("Execute") {
            Task {
                let letters = await getLetters()
                print(letters)
            }
        }
    }
}

extension TaskGroupPractice {
    
    func getLetters() async -> [String] {
        // MARK: - `of` is return type of child task, `returning` is return type taskGroup
        await withTaskGroup(of: String.self, returning: [String].self) { group in
            // MARK: - Add Child Task
            for i in 1...10 {
                group.addTask {
                    let second = (1...5).randomElement()
                    try? await Task.sleep(for: .seconds(second!))
                    print(i)
                    return ("\(i)")
                }
            }
            
            // MARK: - Iterate and return Result
            var letters = [String]()
            for await letter in group {
                letters.append(letter)
            }
            return letters
        }
    }
}
