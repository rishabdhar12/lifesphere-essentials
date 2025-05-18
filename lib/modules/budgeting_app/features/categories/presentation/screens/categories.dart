import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lifesphere_essentials/core/common/widgets/text.dart';
import 'package:lifesphere_essentials/core/constants/colors.dart';
import 'package:lifesphere_essentials/core/constants/route_names.dart';
import 'package:lifesphere_essentials/core/constants/strings.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_bloc.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_event.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_state.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    getCategories();
  }

  getCategories() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<CategoriesBloc>().add(GetCategoriesEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorCodes.buttonColor,
        onPressed: () {
          context.push(RouteNames.allocationScreen);
        },
        child: const Icon(Icons.arrow_forward_rounded),
      ),
      body: Padding(
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
              BlocBuilder<CategoriesBloc, CategoriesState>(
                builder: (context, state) {
                  if (state is CategoriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CategoriesFinishedState) {
                    final categories = state.categories;
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                                      return Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey.shade600,
                                            width: 0.5,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            6,
                                          ),
                                        ),
                                        child: textWidget(
                                          text: item,
                                          color: Colors.white,
                                          fontSize: 12,
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
                  } else if (state is CategoriesError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
