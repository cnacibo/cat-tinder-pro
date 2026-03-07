import 'package:flutter/material.dart';
import '../../core/injection.dart'; 
import '../../core/analytics/analytics_service.dart';
import '../cat_details/cat_details_screen.dart';
import '../auth/auth_screen.dart';
import '../../domain/entities/cat_image.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/get_random_cat_usecase.dart';
import '../../domain/usecases/get_likes_count_usecase.dart';
import '../../domain/usecases/like_cat_usecase.dart';
import '../../domain/usecases/reset_likes_usecase.dart';
import 'widgets/cat_card.dart';
import 'widgets/error_view.dart';
import 'widgets/action_buttons.dart';

class CatsScreen extends StatefulWidget {
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  late final GetRandomCatUseCase _getRandomCat;
  late final GetLikesCountUseCase _getLikesCount;
  late final LikeCatUseCase _likeCat;
  late final ResetLikesUseCase _resetLikes;

  Future<CatImage>? _catFuture;
  int _likesCount = 0;
  String? _currentCatImageUrl;

  @override
  void initState() {
    super.initState();
    _getRandomCat = getIt<GetRandomCatUseCase>();
    _getLikesCount = getIt<GetLikesCountUseCase>();
    _likeCat = getIt<LikeCatUseCase>();
    _resetLikes = getIt<ResetLikesUseCase>();
    _loadRandomCat();
    _loadLikes();
  }

  Future<void> _showLogoutDialog() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
    if (shouldLogout == true) {
      await _signOut();
    }
  }

  Future<void> _signOut() async {
    final authRepo = getIt<AuthRepository>();
    final result = await authRepo.signOut();
    if (!result) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logout failed')),
        );
    } else {
      await AnalyticsService.logLogout();
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AuthScreen()),
        );
    }
  }

  Widget _buildLogoutButton() {
    return IconButton(
      icon: const Icon(Icons.logout, color: Colors.white),
      onPressed: _showLogoutDialog,
      tooltip: 'Sign Out',
    );
  }

  Future<void> _loadLikes() async {
    final count = await _getLikesCount.execute();
    if (mounted) {
      setState(() => _likesCount = count);
    }
  }

  Future<void> _loadRandomCat() async {
    setState(() {
      _catFuture = _getRandomCat.execute();
      _currentCatImageUrl = _generateCatUrl();
    });
  }

  void _handleSwipe(bool isRight) async {
    if (isRight) {
      await _likeCat.execute();
      await _loadLikes();
    }
    _loadRandomCat();
  }

  void _resetLikesCounter() async {
    await _resetLikes.execute();
    await _loadLikes();
  }

  String _generateCatUrl() {
    return 'https://cataas.com/cat?type=square&timestamp=${DateTime.now().millisecondsSinceEpoch}';
  }

  Widget _buildLikesCounter() {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Row(
        children: [
          const Icon(Icons.favorite_border, color: Colors.white),
          const SizedBox(width: 4),
          Text('$_likesCount', style: TextStyle(fontSize: 18, color: Theme.of(context).colorScheme.onPrimary)),
          IconButton(
            icon: const Icon(Icons.restart_alt, size: 18, color: Colors.white70),
            onPressed: _resetLikesCounter,
            tooltip: 'Reset counter',
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(CatImage catImage) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: CatCard(
              catImage: catImage,
              currentImageUrl: _currentCatImageUrl,
              onSwipe: _handleSwipe,
              onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CatDetailsScreen(
                        breed: catImage.breeds.first,
                        catImageUrl: _currentCatImageUrl ?? _generateCatUrl(),
                      ),
                    ),
                  );
                },
              onRetry: _loadRandomCat,
              )
            ),
          const SizedBox(height: 20),
          ActionButtons(
            onDislike: () => _handleSwipe(false),
            onLike: () => _handleSwipe(true),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Cat Tinder',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary, 
          ),
        ),
        centerTitle: true,
        actions: [_buildLogoutButton(),_buildLikesCounter()],
      ),
      body: FutureBuilder<CatImage>(
        future: _catFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error ?? 'Unknown error', onRetry: _loadRandomCat);
          }

          if (snapshot.hasData) {
            return _buildMainContent(snapshot.data!);
          }

          return ErrorView(error: Exception('No data for this cat!'), onRetry: _loadRandomCat);
        },
      ),
    );
  }
}
