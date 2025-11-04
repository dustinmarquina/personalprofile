import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const PersonalProfileApp());
}

class PersonalProfileApp extends StatefulWidget {
  const PersonalProfileApp({Key? key}) : super(key: key);

  @override
  State<PersonalProfileApp> createState() => _PersonalProfileAppState();
}

class _PersonalProfileAppState extends State<PersonalProfileApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Profile',
      theme:
          _isDark ? ThemeData.dark() : ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Personal Profile'),
          actions: [
            IconButton(
              icon: Icon(_isDark ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => setState(() => _isDark = !_isDark),
              tooltip: 'Toggle theme',
            )
          ],
        ),
        body: LayoutBuilder(builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    BoxConstraints(maxWidth: isWide ? 800 : double.infinity),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: isWide
                            ? Row(
                                children: _buildHeaderChildren(isWide),
                              )
                            : Column(
                                children: _buildHeaderChildren(isWide),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildSkills(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      elevation: 2,
                      child: Column(
                        children: _buildSocialLinks(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  List<Widget> _buildHeaderChildren(bool isWide) {
    // Use a network placeholder avatar by default. If you prefer a local asset,
    // add it to `pubspec.yaml` under `flutter.assets` and replace the
    // NetworkImage below with AssetImage('assets/profile.jpg').
    final avatar = CircleAvatar(
      radius: 48,
      // Use a bundled asset if available; fallback to the network avatar on error.
      child: ClipOval(
        child: Image.asset(
          'assets/profile.jpg',
          width: 96,
          height: 96,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Image.network(
            'https://i.pravatar.cc/300',
            width: 96,
            height: 96,
            fit: BoxFit.cover,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
    );

    final infoContent = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Your Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text('Mobile / Web Developer • Flutter Enthusiast'),
          SizedBox(height: 8),
          Text(
              'A short bio goes here. Talk about your interests, experience, and what you build.'),
        ],
      ),
    );

    // When wide, place the info in an Expanded so it shares space with the avatar in a Row.
    // When narrow (vertical layout inside a Column/ScrollView) do not use Expanded because
    // the parent may provide an unbounded height.
    final info = isWide ? Expanded(child: infoContent) : infoContent;

    return isWide ? [avatar, info] : [avatar, const SizedBox(height: 12), info];
  }

  List<Widget> _buildSkills() {
    final skills = ['Flutter', 'Dart', 'Firebase', 'UI/UX', 'Git'];
    return [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Skills',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      Wrap(
        spacing: 8,
        runSpacing: 8,
        children: skills
            .map((s) => Chip(
                  label: Text(s),
                ))
            .toList(),
      ),
    ];
  }

  List<Widget> _buildSocialLinks() {
    final links = {
      'Website': 'https://example.com',
      'GitHub': 'https://github.com/dustinmarquina',
      'LinkedIn': 'https://www.linkedin.com/iamhniht',
      'Email': 'giathinh824@gmail.com'
    };

    return links.entries
        .map((e) => ListTile(
              leading: _iconForLabel(e.key),
              title: Text(e.key),
              subtitle: Text(e.value),
              onTap: () => _launchUrl(e.value),
            ))
        .toList();
  }

  Icon _iconForLabel(String label) {
    switch (label) {
      case 'GitHub':
        return const Icon(Icons.code);
      case 'LinkedIn':
        return const Icon(Icons.business);
      case 'Email':
        return const Icon(Icons.email);
      default:
        return const Icon(Icons.link);
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Could not open $url')));
    }
  }
}
