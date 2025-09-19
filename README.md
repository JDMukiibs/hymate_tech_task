# hymate_tech_task

Flutter Tech Task for Hymate
---

## 🚀 Setup Instructions

Follow these steps to get the project up and running on your local machine.

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/your-username/your-repo-name.git](https://github.com/your-username/your-repo-name.git)
   cd your-repo-name
   ```
2. **Install dependencies:**
   ```bash
   melos bootstrap
   flutter pub get
   ```
3. **Run the application:**
   ```bash
   flutter run
   ```
   (You may need to specify a device or browser for desktop/web: `flutter run -d chrome` or
   `flutter run -d windows`)

---

## 🛠️ Flutter & Dart SDK Used

* **Flutter Version:** `3.32.6`
* **Dart Version:** `3.8.1`

You can find your current versions by running `flutter --version` in your terminal.

---

## 📝 Small Description of the Implementation

This section provides a high-level overview of how the application is structured and key technical
decisions.

* **Architecture:**
    * Feature-based folder structure with separation of concerns (models, views,
      providers/controllers, services, widgets).
    * Uses Flutter Riverpod for state management.
    * Package-based modularization with Melos for managing multiple packages.

* **Key Features Implemented:**
    * Chart visualization for energy data
    * Interactive controls for selecting date ranges, metrics, and series
    * Responsive design for desktop and web platforms
    * Error handling for network requests and data parsing
    * Custom theming and styling for a polished UI
    * [e.g., "Dynamic data loading and rendering"]
    * [e.g., "Responsive UI for desktop and web"]

* **Core Libraries/Packages:**
    * `custom_charts`: The custom charting package developed as part of the task with coordination
      between multiple series, legends, and axes.
    * `flutter_riverpod`: For state management and dependency injection.
    * `dio`: For making network requests to fetch data.

* **Data Handling:**
    * Task One uses an api service to fetch data from the given data source:
      `https://api.energy-charts.info/`
    * Data is parsed into Dart models using `json_serializable`.
    * Error handling is implemented for network requests and data parsing.
    *

---

## 💡 Notes about Assumptions, Limitations, or Extra Work Done

* **Assumptions:**
    * Task One:
        * The data source is reliable and returns data in the expected format.
        * Date ranges are inclusive of the start and end dates.
        * The user will select valid date ranges (start date before end date).
        * For `total_power` metric, for some production types particularly "Hydro Pumped Storage
          consumption" and "Cross border electricity trading",
          negative values are possible and should be displayed as-is.
    * Task Two:
    * [e.g., "Assumed the target environment would be desktop/web, prioritizing responsive layout over mobile-specific gestures."]
* **Limitations:**
    * [e.g., "Currently, data refresh is manual; no real-time updates implemented."]
    * [e.g., "Error handling is basic for network requests."]
    * [e.g., "No extensive unit/integration tests are included due to time constraints."]
* **Extra Work Done:**
    * Implemented a custom theme to match a specific brand guide.
    * Designed a custom 404 error page
    * Created a custom package for charting with support from an LLM.

---

## ⏱️ Time Spent on Each Task

For your reference, here's an estimate of time spent on key tasks:

* **Project Setup & Environment Configuration:** `2.5 hours`
* **Core Chart Implementation:** `9 hours*`
* **Data Integration (Mock/API):** `6 hours`
* **UI/UX (Layout, Styling, Responsiveness):** `2.5 hours`
* **Error Handling & Edge Cases:** `1 hour*`
* **README Documentation:** `0.8 hours*`
* **Total Estimated Time:** `[e.g., 16.5 hours]`

---

## 🧩 New: Task One small widgets

The Task One view was refactored to extract three small, reusable widgets to make the charting UI
easier to test and maintain:

- `Controls` (lib/tasks/view/widgets/controls.dart)
    - Encapsulates user controls for the chart: date range picker, metric selector (total_power /
      price), bidding-zone dropdown for price, series selection chips, and the Update Chart button.
    - Designed to be UI-only: it receives the current `TaskOneChartState` and callback handlers for
      all interactions so the controller can remain the single source of truth.

- `ChartWithLegend` (lib/tasks/view/widgets/chart_with_legend.dart)
    - Renders the area chart and a vertical legend side-by-side.
    - Handles empty / loading / not-found states and delegates retry and series toggle actions back
      to the caller.

- `Legend` (lib/tasks/view/widgets/legend.dart)
    - A compact vertical legend listing series names, colours, and a checkbox to show/hide each
      series.

These widgets are small and intentionally focused on a single responsibility to improve readability
and testability. They are exported via `lib/tasks/widgets/widgets.dart`.

---

## 🧪 Performance tests (parsing) -- Copilot

A set of performance-focused tests live under `test/perf/parse_performance_test.dart`. These tests measure
how long it takes to parse large JSON responses into the project's `DatapointHierarchyNode` model. They
are separated from the fast unit tests so you can run them manually when you want reliable timing data.

What is measured
- jsonDecode (string -> Map/List) time.
- The generated `fromJson` model mapping time (Map -> `DatapointHierarchyNode`).

Test characteristics
- Each test runs a small warm-up phase to stabilize JIT/VM behavior.
- Each measurement runs multiple iterations and reports median and average timings to reduce noise.
- Timings are printed in human-friendly units (milliseconds/ms or seconds/s) for easier interpretation.

Included benchmarks
- Depth benchmark: measures parsing when JSON is very deep (single chain of nested children). Useful to
  check stack/recursion and per-node parsing costs.
- Width benchmark: measures parsing when JSON has many sibling nodes at one level (wide trees). Useful to
  check the impact of large payload sizes and many sibling objects.

How to run (Windows cmd.exe)
- Run only the performance tests (recommended):

```cmd
flutter test test\perf\parse_performance_test.dart -r expanded
```

- Run a single test file (same as above) or the whole test suite if you prefer.

Interpreting the outputs
- Each benchmark prints median and average timings for both the decode and fromJson stages.
- Timings are printed as either `XXX.X ms` or `Y.YYY s` depending on magnitude.
- Prefer the median for stability (less sensitive to outliers). You can use the average to understand total
  runtime across iterations.

Recommendations
- Run these perf tests on the same machine/environment when comparing results to avoid cross-machine variance.
- Run them manually (they are under `test/perf/`) rather than as part of CI unless you want a performance
  gating policy (in which case choose conservative thresholds).

Example output (abbreviated)
- Depth 100 decode median=1.2 ms avg=1.4 ms
- Depth 100 fromJson median=0.12 ms avg=0.14 ms
- Width 200 decode median=0.20 ms avg=0.19 ms
- Width 200 fromJson median=0.06 ms avg=0.06 ms

---

