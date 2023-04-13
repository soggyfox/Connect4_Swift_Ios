import Foundation
import CoreGraphics

class Connect4Model {
    
    func getGridWidth(boardWidth: CGFloat) -> CGFloat {
        // total board/ cols
      return boardWidth / CGFloat(7)
    }

    func getDiscRadius(boardWidth: CGFloat) -> CGFloat {
      let gridWidth = getGridWidth(boardWidth: boardWidth)
        // we divide by the 2 borders we have 
      return (gridWidth / CGFloat(2.0)) * 0.86
    }

    func getInitTile(boardSize: CGFloat, middle: CGPoint) -> CGPoint {
      let rowWidth = getGridWidth(boardWidth: boardSize)
      let borders = boardSize.remainder(dividingBy: rowWidth)

      let x = middle.x - ((boardSize - borders) / CGFloat(2.0)).rounded()
      let y = middle.y + ((CGFloat(6) * rowWidth) / CGFloat(2.0)).rounded()

      return CGPoint(x: x, y: y)
    }

    // https://gist.github.com/chandlerhuff/5ff41889f83a33e06ae1f5887f86aab6
    // https://stackoverflow.com/questions/64509037/is-there-a-simple-way-to-traverse-a-multi-dimensional-array-and-transform-each-e
    func createHolesHelper(boardSize: CGFloat, boardBeginning: CGPoint, column: Int, row: Int) -> CGPoint {
      let initTile = getInitTile(boardSize: boardSize, middle: boardBeginning)
        let goRight = goRight(boardSize: boardSize)
        let goUp = goUp(boardSize: boardSize)
        // we get the new X value
      let newX = initTile.x + CGFloat(column) * getGridWidth(boardWidth: boardSize) + goRight / 2.0
      let newY = initTile.y - CGFloat(row) * getGridWidth(boardWidth: boardSize) * 0.95 - goUp
      return CGPoint(x: newX, y: newY)
    }

    private func goRight(boardSize: CGFloat) -> CGFloat {
      let gridWidth = getGridWidth(boardWidth: boardSize)
      return gridWidth - gridWidth * 0.96
    }

    func goUp(boardSize: CGFloat) -> CGFloat {
      let gridWidth = getGridWidth(boardWidth: boardSize)
        let inverseWidthRatio = 1 -  0.96
        let shift: CGFloat = gridWidth * (CGFloat(6) * inverseWidthRatio) / 2
      return shift
    }

}
