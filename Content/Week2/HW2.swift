import SwiftUI

struct GameCircle {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    var size: CGFloat
    var scale: CGFloat = 1.0
    var opacity: Double = 1.0
}

struct ProfileCardView: View {
    @State private var gameScore = 0
    @State private var gameCircles: [GameCircle] = []
    @State private var gameTimer: Timer?
    @State private var isGameActive = false
    
    var body: some View {
        ZStack {
            // MARK: - Scrollable Content
            ScrollView(showsIndicators: false){
                VStack(spacing: 0) {
                    // MARK: - Header Section with Gradient Background
                    ZStack {
                        // Gradient Background
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.blue.opacity(0.8),
                                Color.purple.opacity(0.6),
                                Color.pink.opacity(0.4)
                            ]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(height: 300)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 30)
                        )
                        
                        VStack(spacing: 16) {
                            Spacer()
                            
                            // Profile Image
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 120))
                                .foregroundColor(.white)
                                .background(
                                    Circle()
                                        .fill(Color.white.opacity(0.2))
                                        .frame(width: 130, height: 130)
                                )
                                .overlay(
                                    Circle()
                                        .stroke(Color.white, lineWidth: 4)
                                        .frame(width: 130, height: 130)
                                )
                            
                            // User Name and Description
                            VStack(spacing: 8) {
                                Text("Batınay Ünsel")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                
                                Text("iOS Developer & SwiftUI Enthusiast")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                                    .multilineTextAlignment(.center)
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // MARK: - Info Cards Section
                    HStack(spacing: 15) {
                        // Followers Card
                        InfoCard(title: "Takipçi", value: "1.2K", icon: "person.2.fill")
                        
                        // Following Card
                        InfoCard(title: "Takip", value: "520", icon: "person.badge.plus.fill")
                        
                        // Likes Card
                        InfoCard(title: "Beğeni", value: "3.4K", icon: "heart.fill")
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    // MARK: - About Me Section
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Text("Hakkımda")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        
                        Text("""
                        
                        İletişim kurmaktan çekinmeyin, yeni projeler ve işbirlikleri için her zaman açığım!
                        """)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .lineSpacing(4)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 25)
                    
                    // MARK: - Mini Game Section
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Text("🎮 Mini Oyun")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                            Spacer()
                            Text("Skor: \(gameScore)")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.orange)
                        }
                        
                        Text("Hızla ortaya çıkan dairelere dokun!")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        
                        // Game Area
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.purple.opacity(0.1),
                                        Color.blue.opacity(0.1),
                                        Color.green.opacity(0.1)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ))
                                .frame(height: 200)
                            
                            // Game circles
                            ForEach(gameCircles, id: \.id) { circle in
                                Button(action: {
                                    hitCircle(circle)
                                }) {
                                    Circle()
                                        .fill(LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color.orange,
                                                Color.pink,
                                                Color.purple
                                            ]),
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ))
                                        .frame(width: circle.size, height: circle.size)
                                        .scaleEffect(circle.scale)
                                        .opacity(circle.opacity)
                                }
                                .position(x: circle.x, y: circle.y)
                                .animation(.easeInOut(duration: 0.3), value: circle.scale)
                            }
                            
                            if gameCircles.isEmpty {
                                VStack(spacing: 10) {
                                    Image(systemName: "gamecontroller.fill")
                                        .font(.system(size: 40))
                                        .foregroundColor(.gray)
                                    
                                    Text("Oyunu Başlat!")
                                        .font(.headline)
                                        .foregroundColor(.gray)
                                    
                                    Button("BAŞLA") {
                                        startGame()
                                    }
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.horizontal, 30)
                                    .padding(.vertical, 12)
                                    .background(
                                        LinearGradient(
                                            gradient: Gradient(colors: [Color.orange, Color.pink]),
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .cornerRadius(25)
                                }
                            }
                        }
                        .clipped()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 100) // Space for floating buttons
                }
            }
            // MARK: - Floating Action Buttons
            VStack {
                Spacer()
                HStack(spacing: 15) {
                    // Message Button
                    Button(action: {
                        // Message action
                    }) {
                        HStack {
                            Image(systemName: "message.fill")
                            Text("Mesaj Gönder")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [
                                    Color.green.opacity(0.8),
                                    Color.purple.opacity(0.6),
                                    Color.blue.opacity(0.4)
                                ]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(25)
                    }
                    
                    // Follow Button
                    Button(action: {
                        // Follow action
                    }) {
                        HStack {
                            Image(systemName: "person.badge.plus")
                            Text("Takip Et")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.blue.opacity(0.8),
                                        Color.purple.opacity(0.6),
                                        Color.green.opacity(0.4)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ).opacity(0.1))
                                .stroke(LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.blue.opacity(0.8),
                                        Color.purple.opacity(0.6),
                                        Color.green.opacity(0.4)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ), lineWidth: 2)
                            
                        )
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .background {
                    Rectangle()
                        .fill(.ultraThinMaterial.opacity(0.9))
                        .cornerRadius(40)
                        .ignoresSafeArea(.container)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
    }
    
    // MARK: - Game Functions
    func startGame() {
        gameScore = 0
        gameCircles.removeAll()
        isGameActive = true
        
        // Start spawning circles
        gameTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            spawnCircle()
        }
        
        // Stop game after 15 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
            stopGame()
        }
    }
    
    func stopGame() {
        gameTimer?.invalidate()
        gameTimer = nil
        isGameActive = false
        
        // Clear remaining circles with animation
        withAnimation(.easeOut(duration: 0.5)) {
            for i in gameCircles.indices {
                gameCircles[i].opacity = 0
                gameCircles[i].scale = 0.1
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            gameCircles.removeAll()
        }
    }
    
    func spawnCircle() {
        let gameAreaWidth: CGFloat = UIScreen.main.bounds.width - 40 // Account for padding
        let gameAreaHeight: CGFloat = 200
        let circleSize: CGFloat = CGFloat.random(in: 40...60)
        
        let x = CGFloat.random(in: circleSize/2...(gameAreaWidth - circleSize/2))
        let y = CGFloat.random(in: circleSize/2...(gameAreaHeight - circleSize/2))
        
        let newCircle = GameCircle(x: x, y: y, size: circleSize)
        gameCircles.append(newCircle)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            removeCircle(newCircle)
        }
    }
    
    func hitCircle(_ circle: GameCircle) {
        // Increase score
        gameScore += 10
        
        
        if let index = gameCircles.firstIndex(where: { $0.id == circle.id }) {
            withAnimation(.easeOut(duration: 0.2)) {
                gameCircles[index].scale = 0.1
                gameCircles[index].opacity = 0
            }
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                gameCircles.removeAll { $0.id == circle.id }
            }
        }
        
        // feedback
        let impactFeedback = UIImpactFeedbackGenerator(style: .medium)
        impactFeedback.impactOccurred()
    }
    
    func removeCircle(_ circle: GameCircle) {
        if let index = gameCircles.firstIndex(where: { $0.id == circle.id }) {
            withAnimation(.easeOut(duration: 0.3)) {
                gameCircles[index].scale = 0.1
                gameCircles[index].opacity = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                gameCircles.removeAll { $0.id == circle.id }
            }
        }
    }
}

// MARK: - Info Card Component
struct InfoCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(.blue)
            
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 100)
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
