
import 'package:flutter/material.dart';

void main() {
  runApp(const MaximusApp());
}

const Color bg = Color(0xFF080D18);
const Color panel = Color(0xFF111B2B);
const Color red = Color(0xFFE53945);
const Color cyan = Color(0xFF00D5FF);
const Color blue = Color(0xFF438CFF);
const Color green = Color(0xFF00D084);
const Color muted = Color(0xFF8493A8);

class MaximusApp extends StatelessWidget {
  const MaximusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MAXIMUS ECU',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.dark(
          primary: red,
          secondary: cyan,
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
  int selectedIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    LiveDataPage(),
    DiagnosticsPage(),
    SensorTestPage(),
    DataLogPage(),
    EcuControlPage(),
    SettingsPage(),
  ];

  final List<String> titles = const [
    'DASHBOARD',
    'LIVE DATA',
    'DTC DIAGNOSTICS',
    'SENSOR TEST',
    'DATA LOG',
    'ECU CONTROL',
    'CONNECTION',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg,
        titleSpacing: 18,
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
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
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MAXIMUS',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2,
                  ),
                ),
                Text(
                  'ENGINE MANAGEMENT',
                  style: TextStyle(
                    color: muted,
                    fontSize: 8,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: const Row(
              children: [
                Icon(Icons.circle, color: Colors.orange, size: 9),
                SizedBox(width: 6),
                Text(
                  'DEMO',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              color: panel,
              child: Text(
                titles[selectedIndex],
                style: const TextStyle(
                  color: cyan,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
            Expanded(child: pages[selectedIndex]),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: panel,
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard, color: red),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.speed),
            selectedIcon: Icon(Icons.speed, color: red),
            label: 'Live',
          ),
          NavigationDestination(
            icon: Icon(Icons.warning_amber),
            selectedIcon: Icon(Icons.warning, color: red),
            label: 'DTC',
          ),
          NavigationDestination(
            icon: Icon(Icons.sensors),
            selectedIcon: Icon(Icons.sensors, color: red),
            label: 'Sensor',
          ),
          NavigationDestination(
            icon: Icon(Icons.show_chart),
            selectedIcon: Icon(Icons.show_chart, color: red),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune),
            selectedIcon: Icon(Icons.tune, color: red),
            label: 'Control',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings, color: red),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// DASHBOARD

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const StatusCard(),
        const SizedBox(height: 16),
        const SectionTitle('ENGINE OVERVIEW'),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: ValueTile(
                label: 'RPM',
                value: '3,250',
                unit: 'rpm',
                icon: Icons.rotate_right,
                color: cyan,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ValueTile(
                label: 'AFR',
                value: '14.7',
                unit: ':1',
                icon: Icons.track_changes,
                color: green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: ValueTile(
                label: 'TPS',
                value: '24.5',
                unit: '%',
                icon: Icons.speed,
                color: blue,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ValueTile(
                label: 'Coolant',
                value: '86',
                unit: '°C',
                icon: Icons.thermostat,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Expanded(
              child: ValueTile(
                label: 'Battery',
                value: '13.8',
                unit: 'V',
                icon: Icons.battery_charging_full,
                color: green,
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: ValueTile(
                label: 'MAP',
                value: '98',
                unit: 'kPa',
                icon: Icons.air,
                color: cyan,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const SectionTitle('SYSTEM STATUS'),
        const SizedBox(height: 10),
        const InfoRow(
          icon: Icons.memory,
          title: 'ECU System',
          value: 'Demo Mode',
          color: Colors.orange,
        ),
        const InfoRow(
          icon: Icons.bluetooth,
          title: 'Bluetooth',
          value: 'Not Connected',
          color: muted,
        ),
        const InfoRow(
          icon: Icons.wifi,
          title: 'Wi-Fi',
          value: 'Not Connected',
          color: muted,
        ),
      ],
    );
  }
}

// LIVE DATA

class LiveDataPage extends StatelessWidget {
  const LiveDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const StatusCard(),
        const SizedBox(height: 16),
        const SectionTitle('REAL-TIME ENGINE DATA'),
        const SizedBox(height: 12),
        const DataTile(
          label: 'Engine RPM',
          value: '3,250',
          unit: 'rpm',
          icon: Icons.rotate_right,
          color: cyan,
        ),
        const DataTile(
          label: 'Air Fuel Ratio',
          value: '14.7',
          unit: ':1',
          icon: Icons.track_changes,
          color: green,
        ),
        const DataTile(
          label: 'Throttle Position',
          value: '24.5',
          unit: '%',
          icon: Icons.speed,
          color: blue,
        ),
        const DataTile(
          label: 'Coolant Temperature',
          value: '86',
          unit: '°C',
          icon: Icons.thermostat,
          color: Colors.orange,
        ),
        const DataTile(
          label: 'Manifold Pressure',
          value: '98',
          unit: 'kPa',
          icon: Icons.air,
          color: cyan,
        ),
        const DataTile(
          label: 'Battery Voltage',
          value: '13.8',
          unit: 'V',
          icon: Icons.battery_charging_full,
          color: green,
        ),
        const DataTile(
          label: 'Intake Air Temperature',
          value: '32',
          unit: '°C',
          icon: Icons.device_thermostat,
          color: blue,
        ),
        const DataTile(
          label: 'Ignition Timing',
          value: '15.0',
          unit: '°',
          icon: Icons.flash_on,
          color: Colors.orange,
        ),
      ],
    );
  }
}

// DTC DIAGNOSTICS

class DiagnosticsPage extends StatelessWidget {
  const DiagnosticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('DIAGNOSTIC TROUBLE CODES'),
        const SizedBox(height: 14),
        const CardPanel(
          child: Column(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: green,
                size: 48,
              ),
              SizedBox(height: 10),
              Text(
                'NO ACTIVE FAULTS',
                style: TextStyle(
                  color: green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Demo diagnostic status',
                style: TextStyle(color: muted, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const SectionTitle('DIAGNOSTIC TOOLS'),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.search,
          title: 'Scan ECU',
          subtitle: 'Scan diagnostic trouble codes',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.delete_outline,
          title: 'Clear Fault Codes',
          subtitle: 'Clear stored diagnostic codes',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.history,
          title: 'Fault History',
          subtitle: 'View previous diagnostic records',
          onTap: () => showDemoMessage(context),
        ),
      ],
    );
  }
}

// SENSOR TEST

class SensorTestPage extends StatelessWidget {
  const SensorTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('SENSOR MONITOR'),
        const SizedBox(height: 12),
        const SensorRow(name: 'TPS Sensor', value: '24.5%', status: 'NORMAL'),
        const SensorRow(name: 'MAP Sensor', value: '98 kPa', status: 'NORMAL'),
        const SensorRow(name: 'Coolant Sensor', value: '86 °C', status: 'NORMAL'),
        const SensorRow(name: 'IAT Sensor', value: '32 °C', status: 'NORMAL'),
        const SensorRow(name: 'O2 / AFR Sensor', value: '14.7 :1', status: 'NORMAL'),
        const SensorRow(name: 'Battery Sensor', value: '13.8 V', status: 'NORMAL'),
        const SizedBox(height: 18),
        const SectionTitle('SENSOR TEST TOOLS'),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.refresh,
          title: 'Refresh Sensors',
          subtitle: 'Update demo sensor values',
          onTap: () => showDemoMessage(context),
        ),
      ],
    );
  }
}

// DATA LOG

class DataLogPage extends StatelessWidget {
  const DataLogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('DATA LOGGER'),
        const SizedBox(height: 12),
        const CardPanel(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'RECORDING STATUS',
                style: TextStyle(color: muted, fontSize: 11),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.circle, color: red, size: 10),
                  SizedBox(width: 8),
                  Text(
                    'STOPPED',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                '00:00:00',
                style: TextStyle(
                  color: cyan,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ActionTile(
          icon: Icons.fiber_manual_record,
          title: 'Start Recording',
          subtitle: 'Start recording engine data',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.stop_circle_outlined,
          title: 'Stop Recording',
          subtitle: 'Stop current data recording',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.folder_open,
          title: 'Saved Logs',
          subtitle: 'View saved data log files',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.download,
          title: 'Export Data',
          subtitle: 'Export recorded data',
          onTap: () => showDemoMessage(context),
        ),
      ],
    );
  }
}

// ECU CONTROL

class EcuControlPage extends StatelessWidget {
  const EcuControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('ECU CONTROL PANEL'),
        const SizedBox(height: 12),
        const CardPanel(
          child: Column(
            children: [
              Icon(Icons.memory, size: 42, color: cyan),
              SizedBox(height: 10),
              Text(
                'ECU CONTROL',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Demo interface - no ECU commands are sent',
                textAlign: TextAlign.center,
                style: TextStyle(color: muted, fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        ActionTile(
          icon: Icons.power_settings_new,
          title: 'ECU Power',
          subtitle: 'ECU power control interface',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.tune,
          title: 'Engine Parameters',
          subtitle: 'Engine parameter settings',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.speed,
          title: 'Idle Control',
          subtitle: 'Idle speed control interface',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.restart_alt,
          title: 'Reset ECU',
          subtitle: 'ECU reset interface',
          onTap: () => showDemoMessage(context),
        ),
      ],
    );
  }
}

// CONNECTION & SETTINGS

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const SectionTitle('CONNECTION SETTINGS'),
        const SizedBox(height: 12),
        const InfoRow(
          icon: Icons.bluetooth,
          title: 'Bluetooth',
          value: 'Disconnected',
          color: muted,
        ),
        const InfoRow(
          icon: Icons.wifi,
          title: 'Wi-Fi',
          value: 'Disconnected',
          color: muted,
        ),
        const SizedBox(height: 16),
        const SectionTitle('APP SETTINGS'),
        const SizedBox(height: 10),
        ActionTile(
          icon: Icons.bluetooth_searching,
          title: 'Search Devices',
          subtitle: 'Find available ECU devices',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.language,
          title: 'Language',
          subtitle: 'English',
          onTap: () => showDemoMessage(context),
        ),
        ActionTile(
          icon: Icons.palette_outlined,
          title: 'Display Theme',
          subtitle: 'MAXIMUS Dark Tech',
          onTap: () => showDemoMessage(context),
        ),
        const SizedBox(height: 20),
        const Center(
          child: Column(
            children: [
              Text(
                'MAXIMUS ECU',
                style: TextStyle(
                  color: red,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'MOBILE APP V1.0',
                style: TextStyle(color: muted, fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// REUSABLE WIDGETS

class StatusCard extends StatelessWidget {
  const StatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF172B42), Color(0xFF101827)],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: cyan.withOpacity(0.35)),
      ),
      child: const Row(
        children: [
          Icon(Icons.speed, color: cyan, size: 34),
          SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ENGINE STATUS',
                  style: TextStyle(color: muted, fontSize: 10),
                ),
                SizedBox(height: 5),
                Text(
                  'SYSTEM READY',
                  style: TextStyle(
                    color: green,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.circle, color: green, size: 11),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: cyan,
        fontSize: 12,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.4,
      ),
    );
  }
}

class ValueTile extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const ValueTile({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    this.color = cyan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 17),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(color: muted, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  unit,
                  style: const TextStyle(color: muted, fontSize: 10),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataTile extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;
  final Color color;

  const DataTile({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    this.color = cyan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: muted),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 5),
          Text(unit, style: const TextStyle(color: muted, fontSize: 11)),
        ],
      ),
    );
  }
}

class CardPanel extends StatelessWidget {
  final Widget child;

  const CardPanel({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: Colors.white10),
      ),
      child: child,
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.color = cyan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(fontSize: 12)),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class SensorRow extends StatelessWidget {
  final String name;
  final String value;
  final String status;

  const SensorRow({
    super.key,
    required this.name,
    required this.value,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 9),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: panel,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Icon(Icons.sensors, color: cyan, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 5),
                Text(
                  status,
                  style: const TextStyle(
                    color: green,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: cyan,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: panel,
      margin: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        leading: Icon(icon, color: cyan),
        title: Text(
          title,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: muted, fontSize: 10),
        ),
        trailing: const Icon(Icons.chevron_right, color: muted),
        onTap: onTap,
      ),
    );
  }
}

void showDemoMessage(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Demo Mode: ECU connection is not active.'),
      duration: Duration(seconds: 2),
    ),
  );
}
