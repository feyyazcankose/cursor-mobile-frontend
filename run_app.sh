#!/bin/bash

# Cursor Mobile Flutter App Runner
# This script helps you run the Flutter app with proper setup

echo "🚀 Starting Cursor Mobile Flutter App..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    echo "Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check Flutter version
echo "📱 Flutter version:"
flutter --version

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Generate code
echo "🔧 Generating code..."
flutter packages pub run build_runner build --delete-conflicting-outputs

# Check for connected devices
echo "📱 Checking for connected devices..."
flutter devices

# Run the app
echo "🏃 Running the app..."
flutter run

echo "✅ App started successfully!"
