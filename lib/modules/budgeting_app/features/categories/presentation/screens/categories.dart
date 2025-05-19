import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lifesphere_essentials/core/common/widgets/text.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';
import 'package:lifesphere_essentials/core/constants/route_names.dart';
import 'package:lifesphere_essentials/core/constants/strings.dart';
import 'package:lifesphere_essentials/core/utils/snackbar.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_bloc.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_event.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_state.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/dto/add_categories_dto.dart';
import 'package:uuid/uuid.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final Uuid _uuid = const Uuid();

  String selectedCategory = "";

  List<String> selectedCategories = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  void _loadInitialData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CategoriesBloc>().add(GetCategoriesEvent());
    });
  }

  void _addCategory({required String categoryName}) {
    final id = _uuid.v4();
    selectedCategory = categoryName;

    context.read<CategoriesBloc>().add(
      AllocateCategoriesEvent(
        addCategoriesDto: AddCategoriesDto(
          id: id,
          name: categoryName,
          desc: "",
          amount: 0.00,
          duration: "Monthly",
          txnHistory: [],
          totalDeducted: 0.00,
          amountLeft: 0.00,
          stateDate: DateTime.now().toString(),
          reset: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorCodes.buttonColor,
        onPressed: () => context.push(RouteNames.allocationScreen),
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      body: BlocConsumer<CategoriesBloc, CategoriesState>(
        listener: (context, state) {
          if (state is CategoriesAllocatedState) {
            // showSnackBar(context, message: "${state.message} allocated successfully");
            selectedCategories.add(selectedCategory);
          }

          if (state is CategoriesError) {
            showSnackBar(context, message: state.message, isError: true);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 50),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textWidget(
                    text: AppStrings.categoriesText1,
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  const SizedBox(height: 8),
                  textWidget(
                    text: AppStrings.categoriesText2,
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                  const SizedBox(height: 10),
                  _buildCategoriesList(state),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoriesList(CategoriesState state) {
    if (state is CategoriesLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CategoriesFinishedState) {
      final categories = state.categories;

      if (categories.isEmpty) {
        return Center(
          child: Column(
            children: [
              const Icon(Icons.category_outlined, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              textWidget(
                text: 'No categories found',
                color: Colors.grey,
                fontSize: 16,
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: _loadInitialData,
                child: const Text('Refresh'),
              ),
            ],
          ),
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget(
                  text: category.categoryName ?? '',
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children:
                      category.items?.map((item) {
                        return InkWell(
                          onTap: () {
                            if (selectedCategories.contains(item)) {
                              setState(() {});
                            } else {
                              _addCategory(categoryName: item);
                              setState(() {});
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 6,
                              horizontal: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade600,
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: textWidget(
                              text: item,
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList() ??
                      [],
                ),
              ],
            ),
          );
        },
      );
    }

    if (state is CategoriesError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            textWidget(text: state.message, color: Colors.red, fontSize: 16),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadInitialData,
              child: const Text('Try Again'),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
