//
//  ContentView.swift
//  ChickenCoopModel
//
//  Created by Furkan İSLAM on 24.06.2025.
//

import SwiftUI
import SwiftData


struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext // Swiftdata ya veri eklemek/silmek için kullanılır(CRUD İŞLEMLERİ)
    @Query private var pets: [Pet] // Veritabanında ki pet nesnelerini otomatik olarak alır.
    @State private var path = [Pet]() // NavigationStack içinde gezinme için (Hangi pet'e gidildiğini takip eder)
    @State private var isEditing: Bool = false // silme modu aktif mi değil mi onu kontrol eder.
    
    let layout = [
        GridItem(.flexible(minimum: 120)),
        GridItem(.flexible(minimum: 120))
    ]
    
    func addPet() {
        isEditing = false
        let pet = Pet(name: "Coop", person: "Person", egg: "Egg", petNumber: "Pet Number")
        modelContext.insert(pet)
        path = [pet]
    }
    var body: some View {
        // MARK: - NavigationStack
        NavigationStack(path: $path) {
            
            // MARK: - ScrollView
            ScrollView {
                
                // MARK: - LazyVGrid
                LazyVGrid(columns: layout) {
                    
                    // MARK: - GridRow
                    GridRow {
                        
                        // MARK: - ForEach
                        ForEach(pets) { pet in
                            
                            // MARK: - NavigationLink
                            NavigationLink(value: pet) {
                                
                                // MARK: - VStack
                                VStack {
                                    if let imageData = pet.photo {
                                        if let image = UIImage(data: imageData) {
                                            Image(uiImage: image)
                                                .resizable()
                                                .scaledToFit()
                                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                        }
                                    } else {
                                        Image(systemName: "bird.circle")
                                            .resizable()
                                            .scaledToFit()
                                            .padding(40)
                                            .foregroundStyle(.quaternary)
                                    }
                                    Spacer()
                                        Text(pet.name)
                                            .font(.title.weight(.light))
                                            .padding(.vertical)
                                    Spacer()
                                }
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 8, style: .circular))
                                .overlay(alignment: .topTrailing) {
                                    if isEditing {
                                        Menu {
                                            Button("Delete", systemImage: "trash", role: .destructive) {
                                                withAnimation {
                                                    modelContext.delete(pet)
                                                    try? modelContext.save()
                                                }
                                            }
                                        } label: {
                                            Image(systemName: "trash.circle.fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fill)
                                                .frame(width: 36, height: 36)
                                                .foregroundStyle(.red)
                                                .symbolRenderingMode(.multicolor)
                                                .padding()
                                        }
                                    }
                                }
                            }
                            .foregroundStyle(.primary)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .navigationTitle(pets.isEmpty ? "" : "Chickeen")
            .navigationDestination(for: Pet.self, destination: EditCoopView.init)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        withAnimation {
                            isEditing.toggle()
                        }
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add a New Coop", systemImage: "plus.circle", action: addPet)
                }
            }
            .overlay {
                if pets.isEmpty {
                    CustomContentUnavailableView(icon: "bird.circle", title: "No Pets", description: "Add a new pet to get started.")
                }
            }
        }
    }
}

#Preview ("Sample Data"){
    ContentView()
        .modelContainer(Pet.preview)
}

#Preview ("No Data"){
    ContentView()
        .modelContainer(for: Pet.self, inMemory: true)
}
