import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const PresentationApp());
}

class PresentationApp extends StatelessWidget {
  const PresentationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Presentation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1565C0)),
          headlineMedium: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const PresentationScreen(),
      },
    );
  }
}

class PresentationScreen extends StatefulWidget {
  const PresentationScreen({super.key});

  @override
  State<PresentationScreen> createState() => _PresentationScreenState();
}

class _PresentationScreenState extends State<PresentationScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<SlideData> _slides;

  @override
  void initState() {
    super.initState();
    _slides = _generateSlides();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List<SlideData> _generateSlides() {
    return [
      // Slide 1: Title
      SlideData(
        title: '',
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.show_chart, size: 100, color: Color(0xFF1E88E5)),
              SizedBox(height: 24),
              Text(
                'Q3 Annual Review',
                style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Company Performance & Future Outlook',
                style: TextStyle(fontSize: 24, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),

      // Slide 2: Agenda
      SlideData(
        title: 'Agenda',
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBulletPoint('1. Executive Summary'),
            _buildBulletPoint('2. Market Expansion (Images)'),
            _buildBulletPoint('3. Revenue Growth (Bar Chart)'),
            _buildBulletPoint('4. Product Updates'),
            _buildBulletPoint('5. Market Share (Pie Chart)'),
            _buildBulletPoint('6. Performance Metrics (Line Chart)'),
            _buildBulletPoint('7. Team Overview'),
            _buildBulletPoint('8. Q&A Session'),
          ],
        ),
      ),

      // Slide 3: Image - Market Expansion
      SlideData(
        title: 'Global Market Expansion',
        content: Column(
          children: [
            const Text(
              'We have successfully expanded our operations into 3 new continents this quarter.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/seed/worldmap/800/400',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // Slide 4: Graph - Bar Chart
      SlideData(
        title: 'Revenue Growth (YTD)',
        content: Column(
          children: [
            const Text(
              'Consistent month-over-month revenue growth exceeding targets.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: SimpleBarChart(
                data: const [
                  ChartData('Jan', 40),
                  ChartData('Feb', 55),
                  ChartData('Mar', 45),
                  ChartData('Apr', 70),
                  ChartData('May', 85),
                  ChartData('Jun', 110),
                ],
              ),
            ),
          ],
        ),
      ),

      // Slide 5: Product Updates
      SlideData(
        title: 'Key Product Updates',
        content: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2.5,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildFeatureCard(Icons.speed, 'Performance', '50% faster load times'),
            _buildFeatureCard(Icons.security, 'Security', 'Enterprise-grade encryption'),
            _buildFeatureCard(Icons.cloud_sync, 'Cloud Sync', 'Real-time data synchronization'),
            _buildFeatureCard(Icons.analytics, 'Analytics', 'Advanced reporting dashboard'),
          ],
        ),
      ),

      // Slide 6: Graph - Pie Chart
      SlideData(
        title: 'Market Share Distribution',
        content: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildLegendItem('North America', Colors.blue),
                  _buildLegendItem('Europe', Colors.green),
                  _buildLegendItem('Asia Pacific', Colors.orange),
                  _buildLegendItem('Latin America', Colors.purple),
                ],
              ),
            ),
            const Expanded(
              flex: 2,
              child: SimplePieChart(
                values: [45, 25, 20, 10],
                colors: [Colors.blue, Colors.green, Colors.orange, Colors.purple],
              ),
            ),
          ],
        ),
      ),

      // Slide 7: Image - Office/Culture
      SlideData(
        title: 'New Headquarters',
        content: Column(
          children: [
            const Text(
              'Our new state-of-the-art facility designed for collaboration.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://picsum.photos/seed/office/800/400',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      // Slide 8: Graph - Line Chart
      SlideData(
        title: 'Active User Engagement',
        content: Column(
          children: [
            const Text(
              'Daily Active Users (DAU) trend over the last 7 days.',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 40),
            const Expanded(
              child: SimpleLineChart(
                points: [
                  Point(0, 20),
                  Point(1, 35),
                  Point(2, 30),
                  Point(3, 50),
                  Point(4, 45),
                  Point(5, 70),
                  Point(6, 85),
                ],
              ),
            ),
          ],
        ),
      ),

      // Slide 9: Team
      SlideData(
        title: 'Executive Team',
        content: Center(
          child: Wrap(
            spacing: 40,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _buildTeamMember('https://picsum.photos/seed/ceo/200/200', 'Jane Doe', 'CEO'),
              _buildTeamMember('https://picsum.photos/seed/cto/200/200', 'John Smith', 'CTO'),
              _buildTeamMember('https://picsum.photos/seed/cfo/200/200', 'Alice Johnson', 'CFO'),
              _buildTeamMember('https://picsum.photos/seed/cmo/200/200', 'Bob Brown', 'CMO'),
            ],
          ),
        ),
      ),

      // Slide 10: Conclusion
      SlideData(
        title: '',
        content: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Thank You!',
                style: TextStyle(fontSize: 56, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)),
              ),
              const SizedBox(height: 24),
              const Text(
                'Any Questions?',
                style: TextStyle(fontSize: 32, color: Colors.black87),
              ),
              const SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: () {
                  _pageController.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
                },
                icon: const Icon(Icons.restart_alt),
                label: const Text('Restart Presentation', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              )
            ],
          ),
        ),
      ),
    ];
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 28, color: Color(0xFF1E88E5))),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 24, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 32, color: const Color(0xFF1E88E5)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(width: 20, height: 20, color: color),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 20)),
        ],
      ),
    );
  }

  Widget _buildTeamMember(String imageUrl, String name, String role) {
    return Column(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(imageUrl),
          backgroundColor: Colors.grey[200],
        ),
        const SizedBox(height: 16),
        Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(role, style: const TextStyle(fontSize: 18, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              // Presentation Content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_slides[index].title.isNotEmpty) ...[
                            Text(
                              _slides[index].title,
                              style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 40),
                            ),
                            const Divider(height: 40, thickness: 2),
                          ],
                          Expanded(child: _slides[index].content),
                        ],
                      ),
                    );
                  },
                ),
              ),
              
              // Controls & Progress
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
                  border: Border(top: BorderSide(color: Colors.grey[200]!)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: _currentPage > 0 ? _previousPage : null,
                      color: _currentPage > 0 ? const Color(0xFF1E88E5) : Colors.grey,
                    ),
                    Text(
                      'Slide ${_currentPage + 1} of ${_slides.length}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: _currentPage < _slides.length - 1 ? _nextPage : null,
                      color: _currentPage < _slides.length - 1 ? const Color(0xFF1E88E5) : Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Models
class SlideData {
  final String title;
  final Widget content;

  SlideData({required this.title, required this.content});
}

class ChartData {
  final String label;
  final double value;

  const ChartData(this.label, this.value);
}

// Custom Bar Chart Widget
class SimpleBarChart extends StatelessWidget {
  final List<ChartData> data;

  const SimpleBarChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final double maxValue = data.map((e) => e.value).reduce(max);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: data.map((item) {
        final heightFactor = item.value / maxValue;
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('\$${item.value.toInt()}k', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Flexible(
              child: FractionallySizedBox(
                heightFactor: heightFactor,
                child: Container(
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E88E5),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(item.label, style: const TextStyle(fontSize: 16)),
          ],
        );
      }).toList(),
    );
  }
}

// Custom Pie Chart Widget
class SimplePieChart extends StatelessWidget {
  final List<double> values;
  final List<Color> colors;

  const SimplePieChart({super.key, required this.values, required this.colors});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: PieChartPainter(values: values, colors: colors),
      child: const SizedBox(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<double> values;
  final List<Color> colors;

  PieChartPainter({required this.values, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final double total = values.reduce((a, b) => a + b);
    double startAngle = -pi / 2;

    final Rect rect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: min(size.width, size.height) * 0.8,
      height: min(size.width, size.height) * 0.8,
    );

    for (int i = 0; i < values.length; i++) {
      final sweepAngle = (values[i] / total) * 2 * pi;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Custom Line Chart Widget
class SimpleLineChart extends StatelessWidget {
  final List<Point<double>> points;

  const SimpleLineChart({super.key, required this.points});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LineChartPainter(points: points),
      child: const SizedBox(
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}

class LineChartPainter extends CustomPainter {
  final List<Point<double>> points;

  LineChartPainter({required this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (points.isEmpty) return;

    final double maxX = points.map((p) => p.x).reduce(max);
    final double maxY = points.map((p) => p.y).reduce(max);

    final paint = Paint()
      ..color = const Color(0xFF1E88E5)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round;

    final dotPaint = Paint()
      ..color = const Color(0xFF0D47A1)
      ..style = PaintingStyle.fill;

    final path = Path();

    for (int i = 0; i < points.length; i++) {
      final x = (points[i].x / maxX) * size.width;
      final y = size.height - ((points[i].y / maxY) * size.height);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      
      canvas.drawCircle(Offset(x, y), 6, dotPaint);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
