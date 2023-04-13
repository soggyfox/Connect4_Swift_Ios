import UIKit
protocol Connect4DataSource: AnyObject {
    /// The point at which the top-left corner of the board is located.
    var startPoint: CGPoint { get }
    
    /// The radius of the discs in the game.
    var discRadius: CGFloat { get }
    
    /// The width of each grid square in the board.
    var gridWidth: CGFloat { get }
    
    /// Returns the point at which the center of the disc at the specified column and row should be placed.
    ///
    /// - Parameters:
    ///   - column: The column index of the disc.
    ///   - row: The row index of the disc.
    /// - Returns: The point at which the center of the disc should be placed.
    func placeToPlaceDiscAndHole(_ column: Int,_ row: Int) -> CGPoint
}


class Connect4View: UIView {
    
    /// The width of the board.
    var boardWidth: CGFloat { return min(bounds.width, bounds.height) }
    
    /// The center point of the board.
    var boardCenter: CGPoint { return convert(center, from: superview) }
    
    /// A dictionary of colliders for the board, keyed by a unique identifier for each collider.
    var boardColliders = [String: UIBezierPath]()
    
    /// A private `CAShapeLayer` for rendering the board.
    private let board = CAShapeLayer()
    
    /// A data source for providing information about the board.
    weak var boardSources: Connect4DataSource?
    
    override func draw(_ rect: CGRect) {
        board.removeFromSuperlayer()
        
        if let delegate = boardSources {
            let path = UIBezierPath()

            (0..<7).forEach { column in
                (1...6).forEach { row in
                    let point = delegate.placeToPlaceDiscAndHole(column, row)
                    let gridWidth = delegate.gridWidth * 0.96
                    let gridHeight = delegate.gridWidth * 0.96
                    let grid = CGRect(x: point.x, y: point.y, width: gridWidth, height: gridHeight)
                    let centerPoint = CGPoint(x: grid.midX, y: grid.midY)
                    let circle = UIBezierPath(arcCenter: centerPoint, radius: delegate.discRadius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
                    path.append(circle)
                }
            }
            
            
            // Rounded board https://developer.apple.com/documentation/coregraphics/cgrect/1454991-init
            // https://stackoverflow.com/questions/35053805/how-to-give-cornerradius-for-uibezierpath
            // https://stackoverflow.com/questions/15837800/how-to-draw-in-rect-with-bezier-path
            // https://www.hackingwithswift.com/example-code/calayer/how-to-draw-shapes-using-cashapelayer
            let boardRect = CGRect(
                x: delegate.startPoint.x,
                y: delegate.startPoint.y - delegate.gridWidth * CGFloat(6),
                width: delegate.gridWidth * CGFloat(7),
                height: delegate.gridWidth * CGFloat(6))
            let roundedBoard = UIBezierPath(roundedRect: boardRect, cornerRadius: delegate.gridWidth * 0.2)
            path.append(roundedBoard)
            
            let boardLayer = CAShapeLayer()
            boardLayer.path = path.cgPath
            boardLayer.fillRule = .evenOdd
            boardLayer.fillColor = .init(red: 0.2, green: 0.2, blue: 0.7, alpha: 1)
            layer.addSublayer(boardLayer)
            
        }
    }
    
}
