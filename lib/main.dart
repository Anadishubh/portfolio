import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:potfolio/fontconstant.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  PortfolioPage({super.key});

  void _scrollToContactSection() {
    _scrollController.animateTo(
      900,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HeaderSection(onGetInTouch: _scrollToContactSection),
            const AboutMeSection(),
            const PortfolioSection(),
            const ContactSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}

// Header Section
class HeaderSection extends StatelessWidget {
  final VoidCallback onGetInTouch;
  const HeaderSection({super.key,required this.onGetInTouch});

  @override
  Widget build(BuildContext context) {
    // Get screen width to determine layout
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;
    final isTablet = screenWidth >= 600 && screenWidth < 900;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/giphy.gif'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: isMobile ? 30 : 60,
      ),
      child: isMobile
          ? _buildMobileLayout(context)
          : _buildDesktopLayout(context, isTablet),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, bool isTablet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 3,
          child: _buildTextContent(
            textScale: isTablet ? 0.8 : 1.0,
            maxWidth: isTablet ? 400.0 : 600.0,
          ),
        ),
        const SizedBox(width: 40),
        Flexible(
          flex: 2,
          child: Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              child: CircleAvatar(
                radius: isTablet ? 120 : 200,
                backgroundImage: const AssetImage('assets/2.jpg'),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 100,
          backgroundImage: const AssetImage('assets/2.jpg'),
          backgroundColor: Colors.transparent,
        ),
        const SizedBox(height: 30),
        _buildTextContent(
          textScale: 0.7,
          maxWidth: double.infinity,
          centered: true,
        ),
      ],
    );
  }

  Widget _buildTextContent({
    required double textScale,
    required double maxWidth,
    bool centered = false,
  }) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth),
      child: Column(
        crossAxisAlignment:
        centered ? CrossAxisAlignment.center : CrossAxisAlignment.start,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Hello, Welcome',
                textStyle: TextStyle(
                  fontFamily: 'CustomFont',
                  color: const Color(0xffFFb300),
                  fontSize: 28 * textScale,
                  fontWeight: FontWeight.w500,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'I am a Developer',
                textStyle: TextStyle(
                  fontFamily: 'CustomFont',
                  color: const Color(0xffFFb300),
                  fontSize: 28 * textScale,
                  fontWeight: FontWeight.w500,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'I am a Content Creator',
                textStyle: TextStyle(
                  fontFamily: 'CustomFont',
                  color: const Color(0xffFFb300),
                  fontSize: 28 * textScale,
                  fontWeight: FontWeight.w500,
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'I am an Explorer',
                textStyle: TextStyle(
                  fontFamily: 'CustomFont',
                  color: const Color(0xffFFb300),
                  fontSize: 28 * textScale,
                  fontWeight: FontWeight.w500,
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
            pause: const Duration(seconds: 1),
          ),
          const SizedBox(height: 10),
          Text(
            "I'm Anadi Singh",
            style: TextStyle(
              color: Colors.white,
              fontSize: 46 * textScale,
              fontWeight: FontWeight.bold,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 15),
          Text(
            "A passionate Flutter developer with a strong focus on creating high-performance, cross-platform mobile applications. I specialize in crafting intuitive user experiences and scalable solutions using the Dart programming language and Flutter framework.",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15 * textScale,
              height: 1.5,
            ),
            textAlign: centered ? TextAlign.center : TextAlign.start,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onGetInTouch,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: EdgeInsets.symmetric(
                horizontal: 25 * textScale,
                vertical: 15 * textScale,
              ),
            ).copyWith(
              overlayColor:
              WidgetStateProperty.all(Colors.black.withOpacity(0.1)),
            ),
            child: Text(
              "Get in Touch",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16 * textScale,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// About Me Section
class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  void _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600;

        return Container(
          decoration: const BoxDecoration(
            color: Color(0xffFFb300),
            image: DecorationImage(
              image: AssetImage('assets/back2.png'),
              fit: BoxFit.fill,
              opacity: 0.3,
            ),
          ),
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Center(
                child: Text(
                  "Me in a Nutshell",
                  style: TextStyle(
                    fontSize: isMobile ? 28 : 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "I’m a passionate Flutter developer and YouTube content creator with a talent for building high-performance, user-centric mobile apps. I specialize in transforming ideas into seamless cross-platform experiences by combining clean, scalable code with stunning, responsive designs. My expertise lies in delivering intuitive solutions that bridge creativity and functionality. When I’m not coding, I’m sharing my journey and gaming adventures on YouTube or exploring the latest tech trends to stay ahead of the curve. Let’s collaborate to bring your vision to life with innovation, precision, and creativity. Together, we can craft something truly extraordinary!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 50),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                runSpacing: 20,
                children: [
                  _socialButton(
                    'assets/linkd.png',
                        () => _launchURL('https://www.linkedin.com/in/anadi-singh-ba431a213/'),
                    scale: 12,
                  ),
                  _socialButton(
                    'assets/git.png',
                        () => _launchURL('https://github.com/Anadishubh'),
                    scale: 10,
                    color: Colors.black,
                  ),
                  _socialButton(
                    'assets/insta.png',
                        () => _launchURL('https://www.instagram.com/_anadi.singh_/'),
                    scale: 12,
                    color: Colors.black,
                  ),
                  _socialButton(
                    'assets/youtube.png',
                        () => _launchURL('https://www.youtube.com/@KennYuuma'),
                    scale: 10,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _socialButton(String asset, VoidCallback onPressed,
      {double scale = 10, Color? color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        padding: const EdgeInsets.symmetric(),
      ),
      child: Image.asset(
        asset,
        scale: scale,
        color: color,
      ),
    );
  }
}
// Portfolio Section
class PortfolioSection extends StatefulWidget {
  const PortfolioSection({super.key});

  @override
  _PortfolioSectionState createState() => _PortfolioSectionState();
}

class _PortfolioSectionState extends State<PortfolioSection> {
  final List<Map<String, dynamic>> portfolioItems = [
    {
      'image': 'assets/aci.png',
      'title': 'Adhar Repair',
      'color': const Color(0xFFeceff8),
      'description': [
        'Simple and efficient Flutter-based app for wall repair and maintenance',
        'Allows users to report issues like cracks, water leakage, or paint damage',
        'Submits details to repair professionals for quick assistance',
        'Features a clean interface with responsive design for all devices',
        'Built with GetX for efficient input handling and data sharing',
        'Practical and user-friendly solution for fast issue resolution',
      ],
      'link': 'https://github.com/Anadishubh/repair_demo_app',
    },
    {
      'image': 'assets/bms.png',
      'title': 'Book My Seva',
      'color': const Color(0xFFffe5e6),
      'description': [
        'Convenient Flutter app for bus travel planning and booking',
        'Search routes, view schedules, select seats, and make secure payments',
        'User-friendly design with seamless navigation between features',
        'Responsive layouts ensure a smooth experience on all devices',
        'Powered by GetX for fast and reliable performance',
        'Securely manages user data and transactions',
      ],
      'link': 'https://github.com/Anadishubh/bus_app',
    },
    {
      'image': 'assets/doctor.png',
      'title': 'Emotional',
      'color': const Color(0xFFeafcf0),
      'description': [
        'User-friendly Flutter app to help patients connect with doctors',
        'Browse doctor profiles, book appointments, and manage health records',
        'Clean interface and responsive design for smooth navigation',
        'Powered by GetX for fast performance and reliable interactions',
        'Includes features like appointment scheduling and reminders',
        'Protects user information with secure data handling',
      ],
      'link': 'https://github.com/Anadishubh/doctoro_get',
    },
    {
      'image': 'assets/devote.png',
      'title': 'Devotee',
      'color': const Color(0xFFfef3fb),
      'description': [
        'Intuitive Flutter app designed to help users find life partners',
        'Create profiles, set preferences, and view potential matches',
        'Communicate securely via in-app messaging',
        'Advanced filters and customizable preferences for better matching',
        'Powered by GetX for seamless performance',
        'Responsive design ensures a smooth experience across all devices',
      ],
      'link': 'https://example.com/devotee',
    },
  ];

  int _currentIndex = 0;
  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  double _responsiveFontSize(double screenWidth, double baseSize) {
    if (screenWidth < 600) {
      return baseSize * 0.85;
    } else if (screenWidth > 1200) {
      return baseSize * 1.2;
    }
    return baseSize;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;
    return LayoutBuilder(
      builder: (context, constraints) {
        double maxWidth = constraints.maxWidth > 1200 ? 1200 : constraints.maxWidth;
        return Center(
          child: Container(
            width: maxWidth,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/back3.png'),
                fit: BoxFit.cover,
                opacity: 0.3,
              ),
            ),
            padding: EdgeInsets.all(isMobile ? 20 : 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Journey so Far..",
                    style: TextStyle(
                      fontSize: _responsiveFontSize(screenWidth, 34),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                CarouselSlider(
                  items: portfolioItems.map((item) {
                    return Container(
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(isMobile ? 10 : 20),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: isMobile ? 20 : 40),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      item['title']!,
                                      style: TextStyle(
                                        fontSize: _responsiveFontSize(screenWidth, 28),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: (item['description'] as List).length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "• ",
                                                style: TextStyle(
                                                  fontSize: _responsiveFontSize(screenWidth, 16),
                                                  color: Colors.black54,
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  item['description'][index],
                                                  style: TextStyle(
                                                    fontSize: _responsiveFontSize(screenWidth, 14),
                                                    color: Colors.black87,
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: ElevatedButton(
                                      onPressed: () => _launchURL(item['link']),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 12,
                                        ),
                                      ),
                                      child: Text(
                                        "Know More",
                                        style: TextStyle(
                                          fontSize: _responsiveFontSize(screenWidth, 16),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              flex: 1,
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(item['image']!),
                                    fit: BoxFit.contain,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: isMobile ? 1.0 : 1.5,
                    viewportFraction: isMobile ? 0.9 : 0.8,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Contact Section
class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final TextEditingController _messageController = TextEditingController();
  final String email = 'anadisingh3217@gmail.com';
  final String phone = '8868014076';

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      query: _messageController.text.isNotEmpty
          ? 'body=${Uri.encodeComponent(_messageController.text)}'
          : null,
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not launch email client'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _handleSubmit() {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a message'),
          backgroundColor: Colors.amber,
        ),
      );
      return;
    }
    _launchEmail();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 600; // Mobile condition

        return Container(
          decoration: const BoxDecoration(
            color: Colors.black,
            image: DecorationImage(
              image: AssetImage('assets/down.gif'),
              fit: BoxFit.cover,
              opacity: 0.3,
            ),
          ),
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              // Contact Section: Row for large screens, Column for mobile
              Row(
                children: [
                  // Contact Details Column
                  Expanded(
                    flex: isMobile ? 1 : 2, // Adjust flex on mobile
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Contact Me",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => _launchEmail(),
                          child: Text(
                            "Email: $email",
                            style: FontConstant.styleMedium(
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "Phone no: $phone",
                          style: FontConstant.styleMedium(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Contact Form Column
                  const SizedBox(width: 20),
                  Expanded(
                    flex: isMobile ? 1 : 2, // Adjust flex on mobile
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: "Your Message",
                            filled: true,
                            fillColor: Colors.white10,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          maxLines: 5,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: _handleSubmit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            padding: isMobile
                                ? const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ) // Smaller padding for mobile
                                : const EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 15,
                            ), // Default padding for larger screens
                          ),
                          child: Text(
                            "Send Message",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: isMobile ? 14 : 16, // Smaller font size for mobile
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// Footer Section
class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0),
        child: Text(
          "© 2024 My Portfolio. All Rights Reserved to Anadi Singh",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70),
        ),
      ),
    );
  }
}
