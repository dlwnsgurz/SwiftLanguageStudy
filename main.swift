var testScores = ["Dave" : [91,89,77], "John" : [87,88,88]]
testScores["Dave"]?[0] += 2 // Dave : [93,89,77]
testScores["John"]?[2] -= 1 // John : [87,88,86]
testScores["Lee"]?[3] = 4 // nil
