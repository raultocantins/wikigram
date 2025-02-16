import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wikigram/src/core/utils/string_constants.dart';
import 'package:wikigram/src/features/home/view/screens/choose_terms_screen.dart';
import 'package:wikigram/src/features/home/view/widgets/card_post_widget.dart';
import 'package:wikigram/src/features/home/view/widgets/language_widget.dart';
import 'package:wikigram/src/features/home/view_model/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  late HomeViewModel _controller;

  @override
  void initState() {
    super.initState();
    _controller = Provider.of<HomeViewModel>(context, listen: false);
    _controller.init(context);
    systemNavigationBarColor();
  }

  void systemNavigationBarColor() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final surface = Theme.of(context).colorScheme.surface;
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(
            systemNavigationBarColor: surface,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          StringConstants.appbarTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        forceMaterialTransparency: true,
        actions: [
          GestureDetector(
            onTap: () {
              _showTermsBottomSheet();
            },
            child: const Chip(
              label: Text(StringConstants.interests),
              visualDensity: VisualDensity.compact,
            ),
          ),
          IconButton(
            onPressed: () {
              _showLanguageBottomSheet();
            },
            icon: const Icon(Icons.language),
          ),
        ],
      ),
      body: SafeArea(
        child: Consumer<HomeViewModel>(
          builder: (context, _, child) {
            if ((_controller.isLoading ?? false) && _controller.posts.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return PageView.builder(
              controller: _pageController,
              onPageChanged: (value) {
                if (value == _controller.posts.length - 3) {
                  _controller.getPosts(context);
                }
              },
              scrollDirection: Axis.vertical,
              itemCount: _controller.posts.length,
              itemBuilder: (context, index) {
                return CardPostWidget(
                  post: _controller.posts[index],
                );
              },
            );
          },
        ),
      ),
    );
  }

  Future<void> _showLanguageBottomSheet() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) {
        return LanguageWidget(
          defaultLanguage: _controller.language,
          onChanged: (newLanguage) {
            _controller.changeLanguage(context, newLanguage);
          },
        );
      },
    );
  }

  Future<void> _showTermsBottomSheet() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return const ChooseTermsScreen();
      },
    );
  }
}
