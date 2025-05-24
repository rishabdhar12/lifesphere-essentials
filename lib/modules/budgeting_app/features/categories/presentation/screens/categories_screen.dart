import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lifesphere_essentials/core/common/widgets/text.dart';
import 'package:lifesphere_essentials/core/constants/strings.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_bloc.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/blocs/categories_state.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/controller/categories_controller.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final categoriesController = CategoriesController();

  @override
  void initState() {
    super.initState();
    categoriesController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: SizedBox(
        height: 60,
        width: 60,
        child: FloatingActionButton(
          onPressed: () {},
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Icon(CupertinoIcons.arrow_right, size: 30),
        ),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 50.0,
            ),
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
                  const SizedBox(height: 8),
                  if (state is CategoriesLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (state is CategoriesError)
                    Center(
                      child: textWidget(
                        text: state.message,
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  if (state is CategoriesFinishedState)
                    ListView.separated(
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 20),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textWidget(
                              text: category.categoryName ?? 'Unnamed Category',
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
                                        categoriesController
                                            .addOrRemoveCategories(item);
                                        setState(() {});
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 6,
                                          horizontal: 10,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              categoriesController.categoryNames
                                                      .contains(item)
                                                  ? Colors.purple.shade200
                                                  : Colors.transparent,

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
                                          color:
                                              categoriesController.categoryNames
                                                      .contains(item)
                                                  ? Colors.black
                                                  : Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }).toList() ??
                                  [],
                            ),
                          ],
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
