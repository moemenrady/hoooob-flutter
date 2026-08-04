import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hoooob_app/common_widgets/category_widget.dart';
import 'package:hoooob_app/features/home/controllers/category_controller.dart';
import 'package:hoooob_app/features/home/widgets/category_shimmer.dart';
import 'package:hoooob_app/features/parcel/screens/parcel_screen.dart';
import 'package:hoooob_app/util/dimensions.dart';
import 'package:hoooob_app/util/images.dart';
import 'package:hoooob_app/util/styles.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (categoryController) {
      return SizedBox(
        height: 100,
        width: Get.width,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: [
            categoryController.categoryList != null
                ? categoryController.categoryList!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoryController.categoryList!.length,
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.horizontal,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return CategoryWidget(
                              index: index,
                              category:
                                  categoryController.categoryList![index]);
                        })
                    : const SizedBox()
                : const CategoryShimmer(),
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: InkWell(
                onTap: () => Get.to(() => const ParcelScreen()),
                child: Container(
                  width: 100,
                  height: 70,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.06),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(1, 6), // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).cardColor,
                  ),
                  margin: const EdgeInsets.only(bottom: 5),
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          Images.parcel,
                          height: 50,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text('parcel'.tr,
                            style: textSemiBold.copyWith(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color!
                                  .withOpacity(0.8),
                              fontSize: Dimensions.fontSizeSmall,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
