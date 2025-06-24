//
//  EditCoopView.swift
//  ChickenCoopModel
//
//  Created by Furkan İSLAM on 24.06.2025.
//

import SwiftUI
import SwiftData
import PhotosUI

struct EditCoopView: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var pet: Pet
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        Form {
            // MARK: - IMAGE
            Section {
                if let imageData = pet.photo, let image = UIImage(data: imageData) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .padding(.vertical, 8)
                } else {
                    CustomContentUnavailableView(
                        icon: "bird.circle",
                        title: "No Photo",
                        description: "Add a photo of your coop or chickens to easily recognize them."
                    )
                    .padding(.vertical, 8)
                }
                
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    Label("Select a Photo", systemImage: "photo.badge.plus")
                        .frame(maxWidth: .infinity)
                }
                .padding(.vertical, 4)
            }
            .listRowSeparator(.hidden)
            
            // MARK: - COOP INFO SECTION
            Section(header: Text("Coop Information").font(.headline)) {
                TextField("Coop Name", text: $pet.name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Responsible Person", text: $pet.person)
                    .textFieldStyle(.roundedBorder)
            }
            .listRowSeparator(.hidden)
            .padding(.vertical, 4)

            // MARK: - EGG & PET INFO SECTION
            Section(header: Text("Production Details").font(.headline)) {
                TextField("Egg Count", text: $pet.egg)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Chicken Count", text: $pet.petNumber)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
            }
            .listRowSeparator(.hidden)
            .padding(.vertical, 4)

            // MARK: - SAVE BUTTON
            Section {
                Button {
                    dismiss()
                } label: {
                    Text("Save")
                        .font(.title3.weight(.medium))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 8)
                }
                .buttonStyle(.borderedProminent)
            }
            .listRowSeparator(.hidden)
            .padding(.vertical)
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Edit \(pet.name)")
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: photosPickerItem) {
            Task {
                pet.photo = try? await photosPickerItem?.loadTransferable(type: Data.self)
            }
        }
    }
}

#Preview {
    NavigationStack {
        do {
            let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
            let container = try ModelContainer(for: Pet.self, configurations: configuration)
            let sampleData = Pet(name: "A blok", person: "Zehra", egg: "5364", petNumber: "100")
            
            return EditCoopView(pet: sampleData)
                .modelContainer(container)
        } catch {
            fatalError("Could not load preview data. \(error.localizedDescription)")
        }
    }
}
