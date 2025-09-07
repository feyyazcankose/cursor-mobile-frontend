# Cursor Mobile - Flutter App

A Flutter mobile application that acts as a remote companion for Cursor IDE projects. The app allows you to connect to your development machine, monitor projects, and interact with Cursor (prompts, diffs, file browsing, previews).

## 🌟 Features

- **Project Management**: List and manage projects with real-time updates
- **File Browser**: Navigate project files with syntax highlighting
- **Prompt Runner**: Send prompts to Cursor and view results with streaming output
- **Activity Feed**: Track commits, file edits, prompts, and server events
- **Preview**: View running apps via WebView integration
- **Real-time Updates**: WebSocket connection for live project updates
- **Dark Theme**: Linear-inspired design with clean, minimal UI

## 🎨 Design Philosophy

The app follows Linear's design principles:

- Minimal, distraction-free layouts
- Dark-first design with custom color palette
- Smooth animations and micro-interactions
- Clean typography using Inter and JetBrains Mono fonts
- Generous spacing and rounded corners

## 🏗️ Architecture

### Project Structure

```
lib/
├── core/
│   ├── models/          # Data models
│   ├── services/        # API and WebSocket services
│   ├── theme/           # App theme and design tokens
│   ├── router/          # Navigation configuration
│   └── data/            # Mock data for development
├── features/
│   ├── connect/         # Connection setup
│   ├── dashboard/       # Projects list
│   ├── project/         # Project detail with tabs
│   ├── files/           # File browser and viewer
│   ├── prompts/         # Prompt management
│   ├── activity/        # Activity feed
│   ├── preview/         # WebView preview
│   └── settings/        # App settings
└── main.dart            # App entry point
```

### State Management

- **Riverpod**: For state management and dependency injection
- **Providers**: Organized by feature with clear separation of concerns
- **AsyncValue**: For handling loading, error, and success states

### Navigation

- **GoRouter**: Declarative routing with type-safe navigation
- **Bottom Navigation**: Main app navigation (Projects, Activity, Settings)
- **Nested Tabs**: Project detail screens with tab navigation

## 🚀 Getting Started

### Prerequisites

- Flutter 3.0+ with Dart null safety
- Android Studio / VS Code with Flutter extensions
- Backend service running (see cursor-mobile-backend)

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd cursor-mobile-frontend
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Generate code**

   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Backend Connection

1. Start the backend service (see cursor-mobile-backend README)
2. Open the app and enter your server URL (default: `http://192.168.1.42:3001`)
3. Optionally add an API token for authentication
4. Tap "Connect" to establish connection

## 📱 Screens

### Connect Screen

- Server URL configuration
- API token input (optional)
- Auto-reconnect toggle
- Connection status feedback

### Dashboard

- Projects list with search
- Project cards with status indicators
- Real-time connection status
- Pull-to-refresh functionality

### Project Detail

- Project header with actions
- Tab navigation (Overview, Files, Prompts, Activity, Preview)
- Status chips and quick actions
- Recent activity timeline

### Files Browser

- Tree navigation with folder expansion
- File icons and metadata
- Context menu for file actions
- Breadcrumb navigation

### File Viewer

- Syntax highlighting for code files
- Line numbers and horizontal scrolling
- Diff view with inline changes
- Action buttons (Open in Cursor, Run Prompt)

### Prompt Runner

- List of previous prompts with status
- New prompt creation with editor
- Context selection (files, folders)
- Advanced parameters configuration
- Real-time streaming output

### Activity Feed

- Chronological activity timeline
- Filter by type (All, Prompts, Files, Server)
- Activity details and metadata
- Grouped by date

### Preview

- WebView for running dev servers
- URL display and refresh controls
- Device size toggles
- Cache management options

### Settings

- Connection management
- Appearance settings
- Sync preferences
- Security options
- Debug tools

## 🔧 Configuration

### Environment Variables

The app uses SharedPreferences for local storage:

- `server_url`: Backend server URL
- `api_token`: Optional API authentication token
- `auto_reconnect`: Auto-reconnect preference

### API Endpoints

The app communicates with the backend via REST API:

- `GET /projects` - List projects
- `GET /files/list` - List project files
- `POST /cursor/prompt` - Send prompt to Cursor
- `GET /git/status` - Get Git status
- And more...

### WebSocket Events

Real-time updates via WebSocket:

- `file_change` - File modification events
- `cursor_update` - Prompt execution updates
- `project_update` - Project changes
- `git_update` - Git operation events

## 🎨 Theming

### Design Tokens

- **Colors**: Primary background (#0B0C10), Accent (#7C5CFF)
- **Typography**: Inter for UI, JetBrains Mono for code
- **Spacing**: Consistent spacing scale (4px, 8px, 12px, 16px, etc.)
- **Border Radius**: 6px, 8px, 12px, 16px
- **Shadows**: Subtle elevation with consistent blur and offset

### Custom Components

- **ProjectCard**: Project list item with status indicators
- **ConnectionStatus**: Real-time connection indicator
- **StatusChip**: Colored status badges
- **ActivityItem**: Timeline activity entry

## 🧪 Development

### Mock Data

The app includes comprehensive mock data for development:

- Sample projects with various languages and frameworks
- Mock file structures and content
- Simulated activity feed
- Cursor response examples

### Code Generation

The app uses code generation for:

- JSON serialization (json_annotation)
- Riverpod providers (riverpod_annotation)
- Build runner for generating code

### Testing

```bash
# Run tests
flutter test

# Run integration tests
flutter test integration_test/
```

## 📦 Dependencies

### Core

- `flutter_riverpod` - State management
- `go_router` - Navigation
- `dio` - HTTP client
- `web_socket_channel` - WebSocket communication

### UI

- `flutter_highlight` - Code syntax highlighting
- `webview_flutter` - WebView for previews
- `flutter_svg` - SVG support

### Utils

- `intl` - Internationalization
- `shared_preferences` - Local storage
- `path` - Path manipulation

## 🚀 Deployment

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🔗 Related Projects

- [cursor-mobile-backend](../cursor-mobile-backend/) - NestJS backend service
- [Cursor IDE](https://cursor.sh/) - AI-powered code editor

## 📞 Support

For support and questions:

- Create an issue in the repository
- Check the documentation
- Review the backend API documentation
