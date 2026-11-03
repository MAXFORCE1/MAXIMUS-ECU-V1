
import 'package:flutter/material.dart';

void main() {
  runApp(const MaximusApp());
}

const red = Color(0xFFE32636);
const blue = Color(0xFF168BFF);
const bg = Color(0xFF080B12);
const panel = Color(0xFF111827);
const muted = Color(0xFF8B98AA);
const green = Color(0xFF21D07A);

class MaximusApp extends StatelessWidget {
  const MaximusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MAXIMUS ECU',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: blue,
          secondary: red,
          surface: panel,
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int page = 0;

  final names = const [
    'Dashboard',
    'Live Data',
    'DTC Diagnostics',
    'Sensor Test',
    'Data Log',
    'ECU Control',
    'Connection & Settings',
  ];

  final icons = const [
    Icons.dashboard,
    Icons.monitor_heart,
    Icons.warning_amber,
    Icons.sensors,
    Icons.show_chart,
    Icons.tune,
    Icons.bluetooth,
  ];

  final pages = const [
    DashboardPage(),
    LiveDataPage(),
    DiagnosticsPage(),
    SensorPage(),
    DataLogPage(),
    ControlPage(),
    ConnectionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        title: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'M',
                style: TextStyle(
                  color: red,
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'MAXIMUS',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(width: 5),
            const Text(
              'ECU',
              style: TextStyle(
                color: red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Icon(Icons.circle, color: Colors.orange, size: 9),
                SizedBox(width: 5),
                Text('OFFLINE', style: TextStyle(fontSize: 10)),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: panel,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Text(
                'MAXIMUS ECU',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                ),
              ),
              const Text(
                'MOBILE APP V1.0',
                style: TextStyle(color: muted, fontSize: 11),
              ),
              const Divider(height: 35),
              Expanded(
                child: ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (context, i) => ListTile(
                    leading: Icon(
                      icons[i],
                      color: page == i ? red : muted,
                    ),
                    title: Text(names[i]),
                    selected: page == i,
                    selectedTileColor: const Color(0xFF24354D),
                    onTap: () {
                      setState(() => page = i);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text(
                  'DEMO VERSION',
                  style: TextStyle(color: red, letterSpacing: 2),
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(index: page, children: pages),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        selectedIndex: page < 3 ? page : 3,
        onDestinationSelected: (i) {
          setState(() => page = i == 3 ? 6 : i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.monitor_heart_outlined),
            label: 'Live',
          ),
          NavigationDestination(
            icon: Icon(Icons.warning_amber_outlined),
            label: 'DTC',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

class PageLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget child;

  const PageLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: muted, fontSize: 11),
          ),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }
}

class BoxPanel extends StatelessWidget {
  final Widget child;

  const BoxPanel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFF29364A)),
      ),
      child: child,
    );
  }
}

class DataCard extends StatelessWidget {
  final String name;
  final String value;
  final String unit;

  const DataCard({
    super.key,
    required this.name,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return BoxPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(color: muted, fontSize: 11),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: const TextStyle(color: blue, fontSize: 11),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'Dashboard',
      subtitle: 'ENGINE MANAGEMENT SYSTEM',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BoxPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('SYSTEM STATUS'),
                    Text(
                      '● OFFLINE',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'MAXIMUS',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                  ),
                ),
                const Text(
                  'ENGINE CONTROL UNIT',
                  style: TextStyle(color: blue, letterSpacing: 2),
                ),
                const SizedBox(height: 20),
                const Divider(color: muted),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _Info(label: 'ECU LINK', value: 'OFFLINE'),
                    _Info(label: 'VERSION', value: 'V1.0'),
                    _Info(label: 'MODE', value: 'DEMO'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const Text('ENGINE DATA', style: TextStyle(color: muted)),
          const SizedBox(height: 10),
          const GridData(),
          const SizedBox(height: 20),
          const Text(
            'All displayed values are demonstration data.',
            style: TextStyle(color: muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String label;
  final String value;

  const _Info({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: muted, fontSize: 9)),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}

class GridData extends StatelessWidget {
  const GridData({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ('RPM', '1250', 'rpm'),
      ('AFR', '14.7', ':1'),
      ('TPS', '3.2', '%'),
      ('ECT', '82', '°C'),
      ('MAP', '98', 'kPa'),
      ('IAT', '31', '°C'),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1.65,
      ),
      itemBuilder: (context, i) {
        final item = items[i];
        return DataCard(
          name: item.$1,
          value: item.$2,
          unit: item.$3,
        );
      },
    );
  }
}

class LiveDataPage extends StatelessWidget {
  const LiveDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Live Data',
      subtitle: 'ENGINE REAL-TIME MONITOR',
      child: Column(
        children: [
          DataCard(name: 'ENGINE RPM', value: '1250', unit: 'rpm'),
          SizedBox(height: 10),
          DataCard(name: 'AIR FUEL RATIO', value: '14.7', unit: ':1'),
          SizedBox(height: 10),
          DataCard(name: 'THROTTLE POSITION', value: '3.2', unit: '%'),
          SizedBox(height: 10),
          DataCard(name: 'COOLANT TEMP', value: '82', unit: '°C'),
          SizedBox(height: 10),
          DataCard(name: 'MANIFOLD PRESSURE', value: '98', unit: 'kPa'),
          SizedBox(height: 10),
          DataCard(name: 'BATTERY VOLTAGE', value: '13.8', unit: 'V'),
        ],
      ),
    );
  }
}

class DiagnosticsPage extends StatelessWidget {
  const DiagnosticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      title: 'DTC Diagnostics',
      subtitle: 'DIAGNOSTIC TROUBLE CODES',
      child: Column(
        children: [
          const BoxPanel(
            child: Row(
              children: [
                Icon(Icons.health_and_safety, color: blue, size: 30),
                SizedBox(width: 12),
                Expanded(child: Text('ECU CONNECTION REQUIRED')),
              ],
            ),
          ),
          const SizedBox(height: 15),
          for (final code in [
            'P0115 - Coolant Temperature Circuit',
            'P0120 - Throttle Position Sensor',
            'P0105 - MAP Sensor Circuit',
          ])
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: BoxPanel(
                child: Row(
                  children: [
                    const Icon(Icons.warning_amber, color: red),
                    const SizedBox(width: 10),
                    Expanded(child: Text(code)),
                    const Text('DEMO', style: TextStyle(color: blue)),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 10),
          const Text(
            'Example codes only. No real ECU scan has been performed.',
            style: TextStyle(color: muted, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class SensorPage extends StatelessWidget {
  const SensorPage({super.key});

  @override
  Widget build(BuildContext context) {
    const sensors = [
      ('TPS', '3.2 %'),
      ('ECT', '82 °C'),
      ('IAT', '31 °C'),
      ('MAP', '98 kPa'),
      ('AFR', '14.7 :1'),
      ('Battery', '13.8 V'),
    ];

    return PageLayout(
      title: 'Sensor Test',
      subtitle: 'SENSOR STATUS MONITOR',
      child: Column(
        children: [
          for (final sensor in sensors)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: BoxPanel(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(sensor.$1),
                    Text(
                      sensor.$2,
                      style: const TextStyle(
                        color: blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class DataLogPage extends StatelessWidget {
  const DataLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Data Log',
      subtitle: 'RECORD ENGINE PERFORMANCE',
      child: Column(
        children: [
          BoxPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('RECORDING STATUS'),
                SizedBox(height: 10),
                Text(
                  'IDLE',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text('No recording session active.'),
              ],
            ),
          ),
          SizedBox(height: 15),
          BoxPanel(
            child: Row(
              children: [
                Icon(Icons.insert_chart, color: blue),
                SizedBox(width: 10),
                Text('No saved log sessions'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ControlPage extends StatelessWidget {
  const ControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'ECU Control',
      subtitle: 'ENGINE CONTROL PANEL',
      child: Column(
        children: [
          BoxPanel(
            child: Row(
              children: [
                Icon(Icons.lock, color: red, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'CONTROL LOCKED — HARDWARE COMMANDS ARE NOT ENABLED.',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15),
          _ControlItem('Engine Parameters'),
          _ControlItem('Calibration'),
          _ControlItem('Reset ECU'),
          _ControlItem('Write Configuration'),
        ],
      ),
    );
  }
}

class _ControlItem extends StatelessWidget {
  final String title;

  const _ControlItem(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: BoxPanel(
        child: Row(
          children: [
            const Icon(Icons.tune, color: blue),
            const SizedBox(width: 12),
            Expanded(child: Text(title)),
            const Text('LOCKED', style: TextStyle(color: red, fontSize: 10)),
          ],
        ),
      ),
    );
  }
}

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageLayout(
      title: 'Connection',
      subtitle: 'BLUETOOTH & WI-FI SETTINGS',
      child: Column(
        children: [
          BoxPanel(
            child: Row(
              children: [
                Icon(Icons.circle, color: Colors.orange, size: 10),
                SizedBox(width: 10),
                Text('ECU NOT CONNECTED'),
              ],
            ),
          ),
          SizedBox(height: 15),
          _ConnectionItem(
            icon: Icons.bluetooth,
            title: 'Bluetooth / BLE',
            subtitle: 'Bluetooth connection setup',
          ),
          SizedBox(height: 10),
          _ConnectionItem(
            icon: Icons.wifi,
            title: 'Wi-Fi',
            subtitle: 'Wireless ECU connection setup',
          ),
          SizedBox(height: 10),
          _ConnectionItem(
            icon: Icons.settings,
            title: 'Application Settings',
            subtitle: 'Language and application information',
          ),
        ],
      ),
    );
  }
}

class _ConnectionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ConnectionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return BoxPanel(
      child: Row(
        children: [
          Icon(icon, color: blue, size: 25),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: muted, fontSize: 10),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: muted),
        ],
      ),
    );
  }
}
