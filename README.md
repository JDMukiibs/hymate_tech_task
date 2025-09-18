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

* **Architecture:** Briefly describe the architectural pattern used (e.g., MVVM, BLoC, Provider,
  Riverpod, simple stateful widgets).
* **Key Features Implemented:**
    * [List major features, e.g., "Chart visualization for energy data"]
    * [e.g., "Dynamic data loading and rendering"]
    * [e.g., "Responsive UI for desktop and web"]
* **Core Libraries/Packages:**
    * `package_name_1`: [Briefly describe its use]
    * `package_name_2`: [Briefly describe its use]
* **Data Handling:
  ** [How is data fetched, parsed, and managed? e.g., "Uses a mock API service for data fetching."]

---

## 💡 Notes about Assumptions, Limitations, or Extra Work Done

* **Assumptions:**
    * [e.g., "Assumed data would be available in a specific JSON format."]
    * [e.g., "Assumed the target environment would be desktop/web, prioritizing responsive layout over mobile-specific gestures."]
* **Limitations:**
    * [e.g., "Currently, data refresh is manual; no real-time updates implemented."]
    * [e.g., "Error handling is basic for network requests."]
    * [e.g., "No extensive unit/integration tests are included due to time constraints."]
* **Extra Work Done:**
    * [e.g., "Implemented a custom theme to match a specific brand guide."]
    * [e.g., "Created a reusable chart component that can be easily extended."]
    * [e.g., "Designed a custom 404 error page (referencing the one we made earlier!)."]

---

## ⏱️ Time Spent on Each Task

For your reference, here's an estimate of time spent on key tasks:

* **Project Setup & Environment Configuration:** `2.5 hours`
* **Core Chart Implementation:** `1.5 hours*`
* **Data Integration (Mock/API):** `[e.g., 3 hours]`
* **UI/UX (Layout, Styling, Responsiveness):** `[e.g., 4 hours]`
* **Error Handling & Edge Cases:** `[e.g., 1 hour]`
* **README Documentation:** `[e.g., 0.5 hours]`
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
