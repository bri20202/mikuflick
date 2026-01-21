import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var viewModel: GameViewModel

    var body: some View {
        NavigationStack {
            SongSelectionView(songs: viewModel.songs) { song in
                viewModel.selectSong(song)
            }
            .navigationDestination(for: Song.self) { song in
                GameplayView(song: song)
            }
        }
    }
}

private struct SongSelectionView: View {
    let songs: [Song]
    let onSelect: (Song) -> Void

    var body: some View {
        List {
            Section {
                ForEach(songs) { song in
                    NavigationLink(value: song) {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(song.title)
                                .font(.headline)
                            Text("\(song.artist) • \(song.difficulty) • \(song.bpm) BPM")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        onSelect(song)
                    })
                }
            } header: {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Miku Flick 02")
                        .font(.largeTitle.bold())
                    Text("Select a song to begin")
                        .foregroundStyle(.secondary)
                }
                .textCase(nil)
                .padding(.vertical, 8)
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Song Select")
    }
}

private struct GameplayView: View {
    let song: Song
    @EnvironmentObject private var viewModel: GameViewModel
    @State private var showingSettings = false

    var body: some View {
        VStack(spacing: 24) {
            VStack(spacing: 8) {
                Text(song.title)
                    .font(.largeTitle.bold())
                Text("\(song.artist) • \(song.difficulty)")
                    .foregroundStyle(.secondary)
            }

            ScoreCard(score: viewModel.score, combo: viewModel.combo)

            VStack(spacing: 16) {
                Text("Upcoming Note")
                    .font(.headline)
                NoteLaneView(note: viewModel.currentNote)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))

            Button {
                viewModel.handleFlick()
            } label: {
                Text(viewModel.isPlaying ? "Flick!" : "Start")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.isPlaying ? Color.mint : Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }

            Spacer()
        }
        .padding()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showingSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
            }
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView(settings: $viewModel.settings)
        }
    }
}

private struct ScoreCard: View {
    let score: Int
    let combo: Int

    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Score")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(score, format: .number)
                    .font(.title2.bold())
            }

            Divider()
                .frame(height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text("Combo")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(combo, format: .number)
                    .font(.title2.bold())
            }

            Spacer()
        }
        .padding()
        .background(Color(uiColor: .secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

private struct NoteLaneView: View {
    let note: Note

    var body: some View {
        VStack(spacing: 12) {
            Text(note.title)
                .font(.title3.bold())
            Text(note.subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color(uiColor: .systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .strokeBorder(Color(uiColor: .separator), lineWidth: 1)
        }
    }
}

private struct SettingsView: View {
    @Binding var settings: GameSettings

    var body: some View {
        NavigationStack {
            Form {
                Section("Gameplay") {
                    Stepper("Note Speed: \(settings.noteSpeed)x", value: $settings.noteSpeed, in: 1...5)
                    Toggle("Haptics", isOn: $settings.hapticsEnabled)
                }

                Section("Audio") {
                    Slider(value: $settings.musicVolume, in: 0...1) {
                        Text("Music Volume")
                    }
                    Slider(value: $settings.effectVolume, in: 0...1) {
                        Text("Effect Volume")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameViewModel())
}
