//
//  SearchLocationView.swift
//  WeatherForecast
//
//  Created by Hymavathi parimi on 27/07/24.
//

import SwiftUI

struct SearchLocationView: View {
    @ObservedObject private var viewModel: SearchLocationViewModel
    @State private var searchText: String = ""
    @FocusState private var focusedField: Bool
    @Binding private var selectedCity: String?
    @Environment(\.dismiss) private var dismiss
    @State private var showAlert: Bool = false

    init(viewModel: SearchLocationViewModel, selectedCity: Binding<String?>) {
        self.viewModel = viewModel
        _selectedCity = selectedCity
    }

    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Colors.themeColor
                    .ignoresSafeArea()
                contentView
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Text("Weather")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                if AppUserDefaults.selectedLocation != nil {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }

    private var contentView: some View {
        VStack {
            searchView
            searchResultsView
        }
        .padding(.top, 20)
        .onAppear {
            self.focusedField = viewModel.recentSearchCities.isEmpty
        }
        .alert("", isPresented: $showAlert) {
            Button("Okay", role: .cancel) {}
        } message: {
            Text("The Internet connection appears to be offline.")
        }
    }

    @ViewBuilder
    private var searchResultsView: some View {
        List {
            if searchText.isEmpty {
                recentSearchCitiesView
            } else if !viewModel.searchedCities.isEmpty {
                searchCitiesView
            } else {
                searchResultNoFoundView
            }
        }
        .listStyle(.plain)
        .navigationBarTitleDisplayMode(.inline)
        .scrollDismissesKeyboard(.interactively)
    }

    @ViewBuilder
    private var recentSearchCitiesView: some View {
        if !viewModel.recentSearchCities.isEmpty {
            Section {
                ForEach(viewModel.recentSearchCities, id: \.self) { city in
                    Button {
                        selectedCity = city
                        dismiss()
                    } label: {
                        HStack {
                            Text(city)
                                .font(.headline)
                                .fontDesign(.rounded)
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .padding(.all, 18)
                    }
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
                }
            } header: {
                Text("Recent")
                    .bold()
                    .foregroundStyle(.gray)
                    .padding(.horizontal, 18)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
                    .listSectionSeparator(.hidden)
            }
        }
    }

    @ViewBuilder
    private var searchCitiesView: some View {
        Section {
            ForEach(viewModel.searchedCities, id: \.self) { city in
                Button {
                    if NetworkManager.isConnectedToInternet() {
                        selectedCity = city.city
                        dismiss()
                    } else {
                        focusedField = false
                        showAlert.toggle()
                    }
                } label: {
                    HStack {
                        Text(city.city ?? "")
                            .font(.headline)
                            .fontDesign(.rounded)
                            .foregroundStyle(.white)
                        Spacer()
                    }
                    .padding(.all, 18)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
            }
        } header: {
            Text("Cities")
                .bold()
                .foregroundStyle(.gray)
                .padding(.horizontal, 18)
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                .listSectionSeparator(.hidden)
        }
    }

    private var searchView: some View {
        HStack(spacing: 8) {
            searchTextField
            clearButton
        }
        .padding(.horizontal, 18)
    }

    private var searchTextField: some View {
        TextField("", text: $searchText) {}
            .placeholder(when: searchText.isEmpty) {
                Text("Search city")
                    .foregroundStyle(.white)
                    .font(.body)
            }
            .tint(.white)
            .autocorrectionDisabled(true)
            .keyboardType(.alphabet)
            .foregroundStyle(.white)
            .focused($focusedField)
            .padding(.all, 12)
            .clipShape(
                RoundedRectangle(cornerRadius: 4)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(.white, lineWidth: 2)
            )
            .onChange(of: searchText) {
                viewModel.searchCity(searchCity: searchText)
            }
            .onSubmit {
                viewModel.searchCity(searchCity: searchText)
            }
            .submitLabel(.search)
    }

    private var clearButton: some View {
        Button {
            searchText = ""
        } label: {
            Text("Clear")
                .foregroundStyle(.white)
                .opacity(searchText.isEmpty ? 0.5 : 1)
        }
        .disabled(searchText.isEmpty ? true : false)
    }

    @ViewBuilder
    private var searchResultNoFoundView: some View {
        HStack {
            searchResultNoFoundTextView
        }
        .padding(.all, 18)
        .listRowInsets(EdgeInsets())
        .listRowBackground(Color.clear)
        .listSectionSeparator(.hidden)
    }

    private var searchResultNoFoundTextView: some View {
        var attributedString = AttributedString("Cities matching with \(searchText) not found.")
        attributedString.foregroundColor = .gray

        if let range = attributedString.range(of: searchText) {
            attributedString[range].foregroundColor = .white
            attributedString[range].font = UIFont.boldSystemFont(ofSize: 20)
        }
        return Text(attributedString)
    }
}

#Preview {
    SearchLocationView(viewModel: SearchLocationViewModel(cities: []), selectedCity: .constant("Tadepalligudem"))
}
