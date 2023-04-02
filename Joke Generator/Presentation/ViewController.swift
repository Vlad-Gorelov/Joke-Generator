
import UIKit
import Foundation

class ViewController: UIViewController {


    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var punchlineButton: UIButton!




    @IBAction func giveMeAJoke(_ sender: Any) {
        getJoke()
}


    override func viewDidLoad() {
        super.viewDidLoad()
        punchlineButton.tintColor = UIColor.jkGreen
        getJoke()
    }

    func getJoke() {
        let apiUrl = URL(string: "https://official-joke-api.appspot.com/random_joke")!
        URLSession.shared.dataTask(with: apiUrl) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching joke: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let joke = try JSONDecoder().decode(Joke.self, from: data)
                DispatchQueue.main.async {
                    self.storyTextView.text = joke.setup + "\n\n" + joke.punchline
                }
            } catch {
                print("Error decoding joke: \(error.localizedDescription)")
            }
        }.resume()
    }





} // конец класса

struct TranslationText: Codable {
    let text: String
}

struct Translation: Codable {
    let code: Int
    let lang: String
    let text: [String]
}

struct Joke: Codable {
    let setup: String
    let punchline: String
}





