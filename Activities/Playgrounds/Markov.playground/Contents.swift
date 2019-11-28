import Foundation

// BEGIN markov_class
class MarkovChain {
    // BEGIN markov1
    private let startWords: [String]
    private let links: [String: [Link]]

    private(set) var sequence: [String] = []
    // END markov1

    // BEGIN markov2
    enum Link: Equatable {
        case end
        case word(options: [String])
        
        var words: [String] {
            switch self {
                case .end: return []
                case .word(let words): return words
            }
        }
    }
    // END markov2

    // BEGIN markov3
    init?(with inputFilepath: String) {
        guard 
            let filePath = Bundle.main.path(
                forResource: inputFilepath, ofType: ".txt"
            ),
            let inputFile = FileManager.default.contents(atPath: filePath),
            let inputString = String(data: inputFile, encoding: .utf8) 
            else { 
                return nil 
            }

        print("File imported successfully!")
        let tokens = inputString.tokenize()
        
        var startWords: [String] = []
        var links: [String: [Link]] = [:]
        
        // for word or sentence end in intput
        for index in 0..<tokens.count - 1 {
            let thisToken = tokens[index]
            let nextToken = tokens[index + 1]
            
            // if this is a sentence end followed by a word
            // that word is a starter word
            if thisToken == String.sentenceEnd {
                startWords.append(nextToken)
                continue
            }
            
            var tokenLinks = links[thisToken, default: []]
            
            // if this is a word followed by a sentence end
            // add 'end' to this word's links
            if nextToken == String.sentenceEnd {
                if !tokenLinks.contains(.end) {
                    tokenLinks.append(.end)
                }
                
                links[thisToken] = tokenLinks
                continue
            }
            
            // if this is a word followed by a word
            // add this word to the word's word link options
            let wordLinkIndex = tokenLinks.firstIndex(where: { element in
                if case .word = element {
                    return true
                }
                return false
            })
            
            var options: [String] = []
            if let index = wordLinkIndex {
                options = tokenLinks[index].words
                tokenLinks.remove(at: index)
            }
        
            options.append(nextToken)
            tokenLinks.append(.word(options: options))
            links[thisToken] = tokenLinks
        }

        self.links = links
        self.startWords = startWords
        
        // if the input was one or less sentences,
        // this is going to be a useless chain
        if startWords.isEmpty { return nil }
        
        print("Model initialised successfully!")
    }
    // END markov3

    // BEGIN markov4
    func clear() {
        self.sequence = []
    }
    // END markov4

    // BEGIN markov5
    func nextWord() -> String {
        let newWord: String
        
        // if there was no last token or it was a sentence end, get a
        // random new word
        if self.sequence.isEmpty || 
            self.sequence.last == String.sentenceEnd {
            
            // '!' is safe here - startWords can't be empty, else this
            // object would be nil
            newWord = startWords.randomElement()! 
        } else {
            // otherwise get a random new token to follow the last word

            // '!' is safe here - self.sequence can't be empty, else the
            // above .isEmpty would have been true
            let lastWord = self.sequence.last! 

            // get random word or sentence end
            let link = links[lastWord]?.randomElement()
            newWord = link?.words.randomElement() ?? "."
        }
        
        self.sequence.append(newWord)
        return newWord
    }
    // END markov5
    
    // BEGIN markov6
    func generate(wordCount: Int = 100) -> String {

        // get n words, put them together
        for _ in 0..<wordCount { 
            let _ = self.nextWord()
        }
        
        return self.sequence.joined(separator: " ")
            .replacingOccurrences(of: " .", with: ".") + " ..."
    }
    // END markov6
}
// END markov_class

// BEGIN markov_using
let file = "wonderland"
if let markovChain = MarkovChain(with: file) {
    print("\n BEGIN TEXT\n==========\n")
    print(markovChain.generate())
    print("\n==========\n END TEXT\n")
} else {
    print("Failure")
}
// END markov_using
