import Foundation

@MainActor
final class GameViewModel: ObservableObject {
    @Published private(set) var songs: [Song] = Song.sampleLibrary
    @Published private(set) var selectedSong: Song?
    @Published private(set) var score = 0
    @Published private(set) var combo = 0
    @Published private(set) var isPlaying = false
    @Published private(set) var currentNote: Note = .placeholder
    @Published var settings = GameSettings()

    private var noteIndex = 0
    private let noteSequence: [Note] = [
        Note(title: "Flick ↑", subtitle: "Swipe upward to match the beat"),
        Note(title: "Flick →", subtitle: "Swipe right for the next hit"),
        Note(title: "Flick ↓", subtitle: "Swipe downward on cue"),
        Note(title: "Flick ←", subtitle: "Swipe left to finish the bar")
    ]

    func selectSong(_ song: Song) {
        selectedSong = song
        resetRun()
    }

    func handleFlick() {
        if !isPlaying {
            startRun()
            return
        }

        score += 120 * settings.noteSpeed
        combo += 1
        advanceNote()
    }

    func resetRun() {
        score = 0
        combo = 0
        noteIndex = 0
        currentNote = noteSequence.first ?? .placeholder
        isPlaying = false
    }

    private func startRun() {
        isPlaying = true
        score = 0
        combo = 0
        noteIndex = 0
        currentNote = noteSequence.first ?? .placeholder
    }

    private func advanceNote() {
        noteIndex = (noteIndex + 1) % noteSequence.count
        currentNote = noteSequence[noteIndex]
    }
}

struct Song: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let artist: String
    let difficulty: String
    let bpm: Int

    static let sampleLibrary: [Song] = [
        Song(title: "Starlight Flicker", artist: "Virtual Pulse", difficulty: "Normal", bpm: 148),
        Song(title: "Neon Horizon", artist: "Signal Drift", difficulty: "Hard", bpm: 172),
        Song(title: "Skyline Echo", artist: "Kiku Ray", difficulty: "Expert", bpm: 196)
    ]
}

struct Note: Hashable {
    let title: String
    let subtitle: String

    static let placeholder = Note(title: "Ready?", subtitle: "Tap Start to begin a run")
}

struct GameSettings: Hashable {
    var noteSpeed: Int = 2
    var hapticsEnabled: Bool = true
    var musicVolume: Double = 0.8
    var effectVolume: Double = 0.7
}
