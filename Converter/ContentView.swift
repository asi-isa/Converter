//
//  ContentView.swift
//  Converter
//
//  Created by isa on 07.09.25.
//

import SwiftUI

struct ContentView: View {
    private let units: [UnitDuration] = [
        .hours,
        .minutes,
        .seconds,
        .milliseconds
    ]
    @FocusState private var isAmountFocused: Bool
    @State private var sourceUnit: UnitDuration = .minutes
    @State private var targetUnit: UnitDuration = .seconds
    @State private var amount = 1.0
    private var targetAmount: Double {
        let sourceValue = Measurement(value: amount, unit: sourceUnit)
        return sourceValue.converted(to: targetUnit).value
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Source Unit") {
                    Picker("Source Unit", selection: $sourceUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.displayName).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Target Unit") {
                    Picker("Target Unit", selection: $targetUnit) {
                        ForEach(units, id: \.self) { unit in
                            Text(unit.displayName).tag(unit)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                
                Section("Amount") {
                    TextField("Amount", value: $amount, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isAmountFocused)
                }
                
                Section("Converted Amount") {
                    Text(targetAmount, format: .number)
                }
                
            }
            .navigationTitle("Converter")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                if isAmountFocused {
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

extension UnitDuration {
    var displayName: String {
        switch self {
        case .hours: return "Hours"
        case .minutes: return "Minutes"
        case .seconds: return "Seconds"
        case .milliseconds: return "Milliseconds"
        default: return self.symbol
        }
    }
}

#Preview {
    ContentView()
}
