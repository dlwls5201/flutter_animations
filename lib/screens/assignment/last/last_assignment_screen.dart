import 'package:flutter/material.dart';
import 'package:flutter_animations_masterclass/screens/assignment/last/constant.dart';

class LastAssignmentScreen extends StatefulWidget {
  const LastAssignmentScreen({super.key});

  @override
  State<LastAssignmentScreen> createState() => _LastAssignmentScreenState();
}

class _LastAssignmentScreenState extends State<LastAssignmentScreen>
    with SingleTickerProviderStateMixin {
  final PageController _thumbnailPageController = PageController();

  final PageController _infoPageController = PageController(
    viewportFraction: 0.9,
  );

  late final AnimationController _arrowUpController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  final Curve _arrowUpCurve = Curves.easeInOutCubic;

  late final Animation<Offset> _backgroundOffset = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, -0.05),
  ).animate(
    CurvedAnimation(
      parent: _arrowUpController,
      curve: _arrowUpCurve,
    ),
  );

  late final Animation<Offset> _thumbnailOffset = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 1),
  ).animate(
    CurvedAnimation(
      parent: _arrowUpController,
      curve: _arrowUpCurve,
    ),
  );

  late final Animation<Offset> _infoOffset = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 0.7),
  ).animate(
    CurvedAnimation(
      parent: _arrowUpController,
      curve: _arrowUpCurve,
    ),
  );

  late final Animation<Offset> _arrowOffset = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(0, 0.88),
  ).animate(
    CurvedAnimation(
      parent: _arrowUpController,
      curve: _arrowUpCurve,
    ),
  );

  late final Animation<double> _bgInfoOpacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _arrowUpController,
      curve: _arrowUpCurve,
    ),
  );

  @override
  void initState() {
    super.initState();
    _thumbnailPageController.addListener(() {
      var pixel = _thumbnailPageController.position.pixels;
      _infoPageController.animateTo(
        pixel,
        duration: const Duration(milliseconds: 100),
        curve: Curves.linear,
      );
    });
  }

  @override
  void dispose() {
    _thumbnailPageController.dispose();
    _infoPageController.dispose();
    _arrowUpController.dispose();
    super.dispose();
  }

  int _currentPage = 0;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  bool _isArrowTop = true;

  void _onArrowUpTap() {
    setState(() {
      _isArrowTop = false;
    });
    _arrowUpController.forward();
  }

  void _onArrowDownTap() {
    setState(() {
      _isArrowTop = true;
    });
    _arrowUpController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          SlideTransition(
            position: _backgroundOffset,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.teal,
                key: ValueKey(_currentPage),
                child: Image.network(
                  Movie.values[_currentPage].bgImageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          FadeTransition(
            opacity: _bgInfoOpacity,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Text(
                          Movie.values[_currentPage].title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Official Rating",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var i = 0; i < 5; i++)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 3),
                                child: Icon(
                                  Icons.star,
                                  color: i < 3 ? Colors.orange : Colors.white,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Divider(
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                        Image.asset(
                          "assets/covers/nomad_coders.png",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Divider(
                          height: 2,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Description",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          Movie.values[_currentPage].longScript,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: IgnorePointer(
                    child: Container(
                      width: size.width,
                      height: 300,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0),
                            Colors.black.withOpacity(1),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SlideTransition(
            position: _infoOffset,
            child: PageView.builder(
              itemCount: Movie.values.length,
              controller: _infoPageController,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 0,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 200,
                        ),
                        Container(
                          width: 360,
                          height: 400,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 240,
                                ),
                                Text(
                                  "\"${Movie.values[index].title}\"",
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                                Text(Movie.values[index].description),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: 360,
                          height: 80,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                            color: Colors.blue,
                          ),
                          child: const Text(
                            "Add to cart +",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SlideTransition(
            position: _thumbnailOffset,
            child: PageView.builder(
              controller: _thumbnailPageController,
              onPageChanged: _onPageChanged,
              itemCount: Movie.values.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      width: 260,
                      height: 320,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: const Offset(0, 9),
                          ),
                        ],
                        image: DecorationImage(
                          image: AssetImage(Movie.values[index].assetPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SlideTransition(
            position: _arrowOffset,
            child: Align(
              alignment: Alignment.topCenter,
              child: IconButton(
                onPressed: _isArrowTop ? _onArrowUpTap : _onArrowDownTap,
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(
                  _isArrowTop ? Icons.keyboard_arrow_up_sharp : Icons.keyboard_arrow_down_sharp,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
