# AI rules for Flutter

You are an expert in Flutter and Dart development. Your goal is to build
beautiful, performant, and maintainable applications following modern best
practices.

## Project Structure

- Assumes a standard Flutter project structure with `lib/main.dart` as the
  primary application entry point.

## Package Management

- If a new feature requires an external package, the AI will identify the most
  suitable and stable package from pub.dev.
- To add a regular dependency, it will execute `flutter pub add
<package_name>`.
- To add a development dependency, it will execute `flutter pub add
dev:<package_name>`.

## Code Quality

- Adhere to maintainable code structure and separation of concerns (e.g., UI
  logic separate from business logic).
- Adhere to meaningful and consistent naming conventions.

## Dart Best Practices

- Follow the official Effective Dart guidelines.
- Define related classes within the same library file. For large libraries,
  export smaller, private libraries from a single top-level library.
- Group related libraries in the same folder.
- Add documentation comments to all public APIs, including classes,
  constructors, methods, and top-level functions.
- Write clear comments for complex or non-obvious code. Avoid over-commenting.
- Don't add trailing comments.
- Ensure proper use of `async`/`await` for asynchronous operations with robust
  error handling.
- Use pattern matching features where they simplify the code.

## Flutter Best Practices

- Widgets (especially `StatelessWidget`) are immutable; when the UI needs to
  change, Flutter rebuilds the widget tree.
- Prefer composing smaller widgets over extending existing ones.
- Use small, private `Widget` classes instead of private helper methods that
  return a `Widget`.
- Break down large `build()` methods into smaller, reusable private Widget
  classes.
- Use `ListView.builder` to create lazy-loaded lists for performance.
- Use `const` constructors for widgets and in `build()` methods whenever
  possible to optimize performance.
- Avoid performing expensive operations, like network calls or complex
  computations, directly within `build()` methods.

## Application Architecture

- Aim for separation of concerns similar to MVC/MVVM, with defined Model,
  View, and ViewModel/Controller roles.

### State Management

- Use Flutter Riverpod 3.0 as the primary state management solution with code generation for optimal
  developer experience.

#### Basic Setup

```dart
// 1. Add the dependencies
// flutter pub add flutter_riverpod
// flutter pub add riverpod_annotation
// flutter pub add dev:riverpod_generator
// flutter pub add dev:build_runner

// 2. Wrap your app with ProviderScope and observers
void main() => bootstrap();

Future<void> bootstrap() async {
  // Initialize services
  final logger = Logger();
  final loggingService = LoggingService(logger: logger);
  final providerObserver = ProviderLogger(logger);

  runApp(
    ProviderScope(
      observers: [providerObserver],
      overrides: [
        loggingServiceProvider.overrideWithValue(loggingService),
        // ... other service overrides
      ],
      child: const App(),
    ),
  );
}
```

#### Provider Types with Code Generation

```dart
// providers/counter_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_provider.g.dart';

// Simple provider
@riverpod
int counter(CounterRef ref) => 0;

// Async provider
@riverpod
Future<String> fetchUserData(FetchUserDataRef ref, String userId) async {
  // Your async logic here
  return 'User data for $userId';
}

// Notifier for complex state
@riverpod
class CounterNotifier extends _$CounterNotifier {
  @override
  int build() => 0;

  void increment() => state++;

  void decrement() => state--;

  void reset() => state = 0;
}

// Async Notifier for complex async state
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  Future<User?> build() async {
    // Initial async state loading
    return await _fetchCurrentUser();
  }

  Future<void> updateUser(User user) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await _updateUserInDatabase(user);
      return user;
    });
  }

  Future<User?> _fetchCurrentUser() async {
    // Your implementation
  }

  Future<void> _updateUserInDatabase(User user) async {
    // Your implementation
  }
}
```

#### Consuming Providers

```dart
class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch a provider
    final count = ref.watch(counterProvider);
    final userData = ref.watch(fetchUserDataProvider('123'));
    final userAsyncValue = ref.watch(userNotifierProvider);

    return Column(
      children: [
        Text('Count: $count'),

        // Handle async state with pattern matching
        userAsyncValue.when(
          data: (user) => Text(user?.name ?? 'No user'),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),

        ElevatedButton(
          onPressed: () {
            // Trigger state changes
            ref.read(counterNotifierProvider.notifier).increment();
          },
          child: const Text('Increment'),
        ),
      ],
    );
  }
}
```

#### Advanced Features (Riverpod 3.0)

```dart
// Family providers (automatic with parameters)
@riverpod
Future<Post> fetchPost(FetchPostRef ref, int postId) async {
  return await apiClient.getPost(postId);
}

// Auto-dispose (default in Riverpod 3.0)
@riverpod
class TimerNotifier extends _$TimerNotifier {
  Timer? _timer;

  @override
  int build() {
    ref.onDispose(() => _timer?.cancel());
    _startTimer();
    return 0;
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      state++;
    });
  }
}

// Listening to other providers
@riverpod
class DerivedStateNotifier extends _$DerivedStateNotifier {
  @override
  String build() {
    final count = ref.watch(counterProvider);
    return 'Current count is: $count';
  }
}

// Automatic Retry (new in 3.0)
@riverpod
class NetworkDataNotifier extends _$NetworkDataNotifier {
  @override
  Future<String> build() async {
    // Automatic retry with exponential backoff on failure
    return await _fetchDataFromNetwork();
  }

  Future<String> _fetchDataFromNetwork() async {
    // Your network implementation
    throw Exception('Network error'); // Will automatically retry
  }
}
```

#### New Features in Riverpod 3.0

```dart
// Ref.mounted - Check if provider is still active
@riverpod
class DataNotifier extends _$DataNotifier {
  @override
  List<String> build() => [];

  Future<void> addItem(String item) async {
    await someAsyncOperation();

    // Check if provider is still mounted before updating
    if (!ref.mounted) return;

    state = [...state, item];
  }
}

// Mutations (experimental) - Handle side effects
final addTodoMutation = Mutation<void>();

// In your widget
ElevatedButton
(
onPressed: () {
addTodoMutation.run(ref, (tsx) async {
await tsx.get(todoListProvider.notifier).addTodo('New Todo');
});
},
child: const Text('Add Todo'),
)
```

- Generate provider code using:

```bash
dart run build_runner build --delete-conflicting-outputs
```

#### Error Handling & Retry

```dart
@riverpod
class DataNotifier extends _$DataNotifier {
  @override
  Future<String> build() async {
    // Automatic retry is built-in for failed providers in 3.0
    return await _fetchData();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => _fetchData());
  }

  Future<String> _fetchData() async {
    // Your implementation with potential failures
    throw Exception('Network error');
  }
}
```

#### Key Advantages of Riverpod 3.0

- **Unified API**: Consistent syntax across all provider types
- **Automatic Retry**: Built-in exponential backoff retry logic
- **Better Code Generation**: Improved developer experience with `@riverpod` annotation
- **Enhanced Testing**: New utilities like `ProviderContainer.test`
- **Ref.mounted**: Similar to `BuildContext.mounted` for safer async operations
- **Experimental Features**: Offline persistence and mutations for advanced use cases

### Data Flow

- Define data structures (classes) to represent the data used in the
  application.
- Abstract data sources (e.g., API calls, database operations) using
  Repositories/Services to promote testability.

### Routing

- Use `auto_route` for declarative navigation, deep linking, and web support with code generation.

```dart
// 1. Add the dependencies
// flutter pub add auto_route
// flutter pub add dev:auto_route_generator
// flutter pub add dev:build_runner

// 2. Configure the router with code generation
import 'package:auto_route/auto_route.dart';
import 'app_router.gr.dart'; // Generated file

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes =>
      [
        AutoRoute(
          page: HomeWrapperRoute.page,
          path: '/',
          initial: true,
        ),
        AutoRoute(
          page: DetailsWrapperRoute.page,
          path: '/details/:id',
        ),
      ];
}

// 3. Create page wrappers with @RoutePage annotation
@RoutePage(name: 'HomeWrapperRoute')
class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const HomeScreen();
}

@RoutePage(name: 'DetailsWrapperRoute')
class DetailsWrapper extends StatelessWidget {
  final String id;

  const DetailsWrapper({required this.id});

  @override
  Widget build(BuildContext context) => DetailsScreen(id: id);
}

// 4. Use it in your MaterialApp
MaterialApp.router
(
routerConfig: AppRouter().config(),
);

// 5. Navigation usage
context.router.push(DetailsWrapperRoute(id: '123'));
context.router.pushAndClearStack(HomeWrapperRoute());
context.router
.
pop
(
);
```

- Generate routing code using:

```bash
dart run build_runner build --delete-conflicting-outputs
```

- Use the built-in `Navigator` for short-lived screens that do not need to be
  deep-linkable, such as dialogs or temporary views.

```dart
// Push a new screen onto the stack
Navigator.push
(
context,
MaterialPageRoute(builder: (context) => const DetailsScreen()),
);

// Pop the current screen to go back
Navigator.pop(
context
);
```

### Data Handling & Serialization

- Use `json_serializable` and `json_annotation` for parsing and encoding JSON
  data.
- When encoding data, use `fieldRename: FieldRename.snake` to convert Dart's
  camelCase fields to snake_case JSON keys.

  ```dart
  // In your model file
  import 'package:json_annotation/json_annotation.dart';

  part 'user.g.dart';

  @JsonSerializable(fieldRename: FieldRename.snake)
  class User {
    final String firstName;
    final String lastName;

    User({required this.firstName, required this.lastName});

    factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
  }
  ```

### Logging

- Use the custom logging setup from the `/logging` directory with Riverpod integration.
- The logging service is provided through `loggingServiceProvider` and includes provider
  observability.
- Global crash handling is configured in the bootstrap process.

#### Basic Usage

```dart
// Import the logging service
import 'package:your_app/logging/logging.dart';

class MyWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loggingService = ref.read(loggingServiceProvider);

    // Log information
    loggingService.i('User action performed');

    // Log warnings
    await loggingService.w('Warning message');

    // Log errors with context
    try {
      // risky operation
    } catch (e, stackTrace) {
      await loggingService.e(
        'Operation failed',
        error: e,
        stackTrace: stackTrace,
      );
    }

    return YourWidget();
  }
}
```

#### Extension Usage

```dart
// Use the LogX extension for quick debugging
final userData = {'name': 'John', 'age': 30};
userData.log
(); // Logs the object using Logger().d()

// Any object can use the extension
'
Simple string message
'
.

log();
complexObject.log
();
```

#### Provider Observability

- All provider lifecycle events are automatically logged through `ProviderLogger`
- Provider additions, updates, disposals, and failures are tracked
- Logs include provider names, values, and context information
- Set up during bootstrap with `ProviderScope` observers

#### Bootstrap Setup

```dart
Future<void> bootstrap() async {
  // Initialize Logging
  final logger = Logger();
  final loggingService = LoggingService(logger: logger);
  final providerObserver = ProviderLogger(logger);

  // Global crash handling
  FlutterError.onError = (errorDetails) async {
    await loggingService.e(
      'Crash occurred',
      error: errorDetails.exception,
      stackTrace: errorDetails.stack,
    );

    FlutterError.presentError(errorDetails);
  };

  runApp(
    ProviderScope(
      observers: [providerObserver],
      overrides: [
        loggingServiceProvider.overrideWithValue(loggingService),
        // ... other service overrides
      ],
      child: const App(),
    ),
  );
}
```

#### Crash Handling

- Global Flutter crashes are captured via `FlutterError.onError`
- Crashes are logged with full error details and stack traces
- Error presentation is maintained while ensuring logging occurs
- Integrates seamlessly with your existing logging service

#### Service Methods

- `i()` - Information logging
- `w()` - Warning logging (async)
- `e()` - Error logging (async)
- All methods support optional `error` and `stackTrace` parameters

## Error Handling

- Implement mechanisms to gracefully handle errors across the application
  (e.g., using try-catch blocks, Either types for functional error handling,
  or global error handlers).

## Code Generation

- Use `build_runner` for all code generation tasks, such as for
  `json_serializable`.
- After modifying files that require code generation, run the build command:

  ```shell
  dart run build_runner build --delete-conflicting-outputs
  ```

## Testing

- Use `package:test` for unit tests.
- Use `package:flutter_test` for widget tests.
- Use `package:integration_test` for integration tests.
- Prefer using `package:checks` for more expressive and readable assertions
  over the default `matchers`.

## Visual Design & Theming

- Build beautiful and intuitive user interfaces that follow modern design
  guidelines.
- Ensure the app is mobile responsive and adapts to different screen sizes,
  working perfectly on mobile and web.
- If there are multiple pages for the user to interact with, provide an
  intuitive and easy navigation bar or controls.
- Stress and emphasize font sizes to ease understanding, e.g., hero text,
  section headlines, list headlines, keywords in paragraphs.
- Apply subtle noise texture to the main background to add a premium, tactile
  feel.
- Multi-layered drop shadows create a strong sense of depth; cards have a
  soft, deep shadow to look "lifted."
- Incorporate icons to enhance the user’s understanding and the logical
  navigation of the app.
- Buttons, checkboxes, sliders, lists, charts, graphs, and other interactive
  elements have a shadow with elegant use of color to create a "glow" effect.

### Theming

- Define a centralized `ThemeData` object to ensure a consistent
  application-wide style.
- Use Material 3 by setting `useMaterial3: true` in your `ThemeData`.
- Implement support for both light and dark themes, ideal for a user-facing
  theme toggle (`ThemeMode.light`, `ThemeMode.dark`, `ThemeMode.system`).
- Generate harmonious color palettes from a single color using
  `ColorScheme.fromSeed`.

  ```dart
  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.light,
    ),
    // ... other theme properties
  );
  ```

- Include a wide range of color concentrations and hues in the palette to
  create a vibrant and energetic look and feel.
- Use specific theme properties (e.g., `appBarTheme`, `elevatedButtonTheme`)
  to customize the appearance of individual Material components.
- For custom fonts, use the `google_fonts` package. Define a `TextTheme` to
  apply fonts consistently.

  ```dart
  // 1. Add the dependency
  // flutter pub add google_fonts

  // 2. Define a TextTheme with a custom font
  final TextTheme appTextTheme = TextTheme(
    displayLarge: GoogleFonts.oswald(fontSize: 57, fontWeight: FontWeight.bold),
    titleLarge: GoogleFonts.roboto(fontSize: 22, fontWeight: FontWeight.w500),
    bodyMedium: GoogleFonts.openSans(fontSize: 14),
  );
  ```

### Assets and Images

- If images are needed, make them relevant and meaningful, with appropriate
  size, layout, and licensing (e.g., freely available). Provide placeholder
  images if real ones are not available.
- Declare all asset paths in your `pubspec.yaml` file.

  ```yaml
  flutter:
    uses-material-design: true
    assets:
      - assets/images/
  ```

- Use `Image.asset` to display local images from your asset bundle.

  ```dart
  Image.asset('assets/images/placeholder.png')
  ```

- Displays an icon from an `ImageProvider`, useful for custom icons not in
  `Icons` class.
- Use `Image.network` to display images from a URL, and always include
  `loadingBuilder` and `errorBuilder` for a better user experience.

  ```dart
  Image.network(
    'https://picsum.photos/200/300',
    loadingBuilder: (context, child, progress) {
      if (progress == null) return child;
      return const Center(child: CircularProgressIndicator());
    },
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.error);
    },
  )
  ```

## Accessibility (A11Y)

- Implement accessibility features to empower all users, assuming a wide
  variety of users with different physical abilities, mental abilities, age
  groups, education levels, and learning styles.
