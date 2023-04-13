import UIKit
import CoreData
import Alpha0Connect4

class Connect4ViewController: UIViewController, Connect4DataSource {
    private var humanColor: GameSession.DiscColor = Bool.random() ? .red : .yellow
    var numberOfPlayedDiscs = 1
    private var board = [[String]]()

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var connect4View: Connect4View!

    private let connect4Model = Connect4Model()
    private let gameSession = GameSession()

    var size: CGSize?
    var cgRect: CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        connect4View.boardSources = self

        _ = CGSize(width: gridWidth * CGFloat(7), height: gridWidth * CGFloat(6))
        _ = CGRect(x: 0, y: -(startPoint.y - gridWidth * CGFloat(6)), width: view.bounds.size.width, height: view.bounds.size.height)
        DispatchQueue.main.async {
            self.present(self.resetGameModalPopup(), animated: true)
        }
    }

    
    private func resetGameModalPopup() -> UIAlertController {
      let alert = UIAlertController(title: nil, message: "Would you like to start a new game?", preferredStyle: .alert)
      let startNewGameAction = UIAlertAction(title: "Yes", style: .default) { _ in
        self.restartGame()
      }
      alert.addAction(startNewGameAction)
      resultLabel.text = ""
      return alert
    }

    private func restartGame() {
      gameSession.startGame(first: true)
    }

    private func resetGameSession() {
      DispatchQueue.main.asyncAfter(deadline: .now()) {
        self.resetGameAlert()
      }
    }

    private func resetGameAlert() {
      self.present(self.resetGameModalPopup(), animated: true)
    }

    
    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        switch gameSession.state {
        case .cleared:
            break
        case .idle(let color):
            if color == humanColor {
                playerTurn(color: color, sender)
                resultLabel.text = "player's move"
                gameSession.dropDisc()
            } else {
                // should add ai
                playerTurn(color: color, sender)
                gameSession.dropDisc()
                resultLabel.text = "bots's move"
            }
        
        case .thinking(_):
            // should add ai here
            break
        case .ended(let outcome):
            var gameResult: String
            switch outcome {
            case humanColor:
                gameResult = "Bot (\(humanColor)) wins!"
            case !humanColor:
                gameResult = "Human (\(!humanColor)) wins!"
            default:
                gameResult = "Draw!"
            }
            resultLabel.text = "Winner is \n" + gameResult
            let moc = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
            _ = CoreDataSession.save(botPlays: humanColor, first: false, layout: gameSession.boardLayout,
                                     positions: gameSession.playerPositions, winningPositions: gameSession.winningPositions,
                                     in: moc)
        @unknown default:
            break
        }
    }

    private func playAI(coordinates: Int) {
        gameSession.dropDiscAt(coordinates)
    }
    
    public var boardArray: [[String]] = [[String]](repeating: [String](repeating: "", count: 7), count: 6)
    // which column is the player dropping a disc in. minus 1 means invalid move
    func playerTurn(color: DiscColor, _ sender: UITapGestureRecognizer) -> Int{
        let location = sender.location(in: self.connect4View)
        let xCoordinate = getXTap(number: location.x)
        let coordinates = calculateCoordinates(xCoordinate, color: color)
        //        if gameSession.isValidMove(coordinates) This piece of code would make it illegal for a human to drop a bot disc. Since our ai is not working I left this if condition out to demonstrate the games working without an ai
        let yCoordinate = getYTap(number: location.y, col: CGFloat(coordinates))
        let discFrame = CGRect(x: xCoordinate, y: yCoordinate, width: 50, height: 50)
        let discMove = (action: 1, color: color, index: numberOfPlayedDiscs)
        numberOfPlayedDiscs += 1
        let discView = DiscView(viewFrame: discFrame, moveData: discMove)
        self.view.addSubview(discView)
        discView.displayLabel([1])
        print(gameSession.boardLayout)
        return coordinates
//    }
//        return -1
    }

    

    func calculateCoordinates(_ number: CGFloat, color: DiscColor) -> Int{
        let col = Int(number / 57.5)
        for i in 0..<6 {
            if boardArray[col][i] == "" {
                boardArray[col][i] = color.description
                break
            }
        }
        return col
    }
    
    func getXTap(number: CGFloat) -> CGFloat {
        return round(number / 57.5) * 57.5
    }


    func getYTap(number: CGFloat, col: CGFloat) -> CGFloat {
        let columnSize = getColSize(i: col)
        return 540 - (55 * columnSize)
    }


    func getColSize(i: CGFloat) -> CGFloat{
        let intValue = Int(i.rounded())
        let row = boardArray[intValue]
        let nonEmptyElements = row.filter { !$0.isEmpty }
        return CGFloat(nonEmptyElements.count - 1)
    }
    
    @IBAction func resetGame(_ sender: Any) {
        resetGameSession()
    }
    
    var startPoint: CGPoint {
        return connect4Model.getInitTile(boardSize: connect4View.boardWidth, middle: connect4View.boardCenter)
    }
    
    var discRadius: CGFloat {
        return connect4Model.getDiscRadius(boardWidth: connect4View.boardWidth)
    }
    
    var gridWidth: CGFloat {
        return connect4View.boardWidth / 7
    }
    
    func placeToPlaceDiscAndHole(_ column: Int, _ row: Int) -> CGPoint {
        return connect4Model.createHolesHelper(boardSize: connect4View.boardWidth, boardBeginning: connect4View.boardCenter, column: column, row: row)
    }
    
}
