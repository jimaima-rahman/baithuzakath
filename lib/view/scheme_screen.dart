import 'package:baithuzakath_app/models/scheme_model.dart';
import 'package:baithuzakath_app/providers/scheme_provider.dart';
import 'package:baithuzakath_app/view/apply_scheme_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SchemesListScreen extends StatefulWidget {
  const SchemesListScreen({super.key});

  @override
  State<SchemesListScreen> createState() => _SchemesListScreenState();
}

class _SchemesListScreenState extends State<SchemesListScreen> {
  final ScrollController _scrollController = ScrollController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Fetch schemes when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SchemeProvider>().fetchSchemes(refresh: true);
    });

    // Add scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<SchemeProvider>().loadMoreSchemes(
        category: _selectedCategory,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schemes'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.filter_list),
            onSelected: (category) {
              setState(() {
                _selectedCategory = category == 'All' ? null : category;
              });
              if (_selectedCategory == null) {
                context.read<SchemeProvider>().refreshSchemes();
              } else {
                context.read<SchemeProvider>().filterByCategory(
                  _selectedCategory!,
                );
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'All', child: Text('All Categories')),
              const PopupMenuItem(value: 'Education', child: Text('Education')),
              const PopupMenuItem(
                value: 'Healthcare',
                child: Text('Healthcare'),
              ),
              const PopupMenuItem(value: 'Housing', child: Text('Housing')),
              const PopupMenuItem(
                value: 'Employment',
                child: Text('Employment'),
              ),
              const PopupMenuItem(value: 'Financial', child: Text('Financial')),
            ],
          ),
        ],
      ),
      body: Consumer<SchemeProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.schemes.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage != null && provider.schemes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${provider.errorMessage}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () => provider.refreshSchemes(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.schemes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No schemes available',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () =>
                provider.refreshSchemes(category: _selectedCategory),
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount:
                  provider.schemes.length + (provider.hasMoreData ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.schemes.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final scheme = provider.schemes[index];
                return SchemeCard(
                  scheme: scheme,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplySchemeScreen(scheme: scheme),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class SchemeCard extends StatelessWidget {
  final SchemeResponse scheme;
  final VoidCallback onTap;

  const SchemeCard({Key? key, required this.scheme, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      scheme.data.scheme.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (scheme.data.scheme.category.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getCategoryColor(scheme.data.scheme.category),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        scheme.data.scheme.category,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              if (scheme.data.scheme.description.isNotEmpty)
                Text(
                  scheme.data.scheme.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (scheme.data.scheme.benefits.amount
                      .toString()
                      .isNotEmpty) ...[
                    Icon(
                      Icons.currency_rupee,
                      size: 16,
                      color: Colors.green[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '₹${scheme.data.scheme.benefits.amount}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[700],
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                  if (scheme.data.scheme.daysRemaining
                      .toString()
                      .isNotEmpty) ...[
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: Colors.orange[700],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Deadline: ${_formatDate(scheme.data.scheme.daysRemaining.toString())}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward, size: 16),
                  label: const Text('Apply Now'),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'education':
        return Colors.blue;
      case 'healthcare':
        return Colors.red;
      case 'housing':
        return Colors.green;
      case 'employment':
        return Colors.orange;
      case 'financial':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
