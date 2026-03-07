import 'package:flutter/material.dart';
import '../../core/injection.dart';
import '../../domain/entities/breed.dart';
import '../../domain/usecases/get_breeds_usecase.dart';
import 'widgets/error_view.dart';
import 'widgets/search_bar.dart';
import 'widgets/empty_state.dart';
import 'widgets/breed_card.dart';
import 'widgets/breed_details.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({super.key});

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  late final GetBreedsUseCase _getBreedsUseCase;

  late Future<List<Breed>>? _breedsFuture;
  List<Breed> _filteredBreeds = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _getBreedsUseCase = getIt<GetBreedsUseCase>();
    _loadBreeds();
    _searchController.addListener(_onSearch);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadBreeds() async {
    setState(() {
      _breedsFuture = _getBreedsUseCase.execute();
    });
  }

  void _onSearch() {
    final query = _searchController.text.toLowerCase();
    
    _breedsFuture?.then((breeds) {
      if (query.isEmpty) {
        setState(() {
          _filteredBreeds = breeds;
          _isSearching = false;
        });
      } else {
        setState(() {
          _filteredBreeds = breeds.where((breed) {
            return breed.name.toLowerCase().contains(query) ||
                (breed.origin?.toLowerCase().contains(query) ?? false) ||
                (breed.temperament?.toLowerCase().contains(query) ?? false);
          }).toList();
          _isSearching = true;
        });
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Cat Breeds',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder<List<Breed>>(
        future: _breedsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error!, onRetry: _loadBreeds);
          }

          final breeds = snapshot.data ?? [];
          final displayBreeds = _isSearching ? _filteredBreeds : breeds;

          return Column(
            children: [
              SearchBar(controller: _searchController, onClear: _clearSearch),
              if (displayBreeds.isEmpty && _isSearching)
                Expanded(child: EmptyState())
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: displayBreeds.length,
                    itemBuilder: (context, index) {
                      final breed = displayBreeds[index];
                      return BreedCard(
                        breed: breed,
                        onTap: () => BreedDetails(breed: breed)
                        );
                    },
                  ),
                ),
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.pets,
                      size: 18,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${displayBreeds.length} breeds found',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}