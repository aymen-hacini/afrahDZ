import 'package:afrahdz/controllers/homepage/homepage_controller.dart';
import 'package:afrahdz/core/constants/color.dart';
import 'package:afrahdz/core/constants/size.dart';
import 'package:afrahdz/views/screens/details/ad_detail.dart';
import 'package:afrahdz/views/widgets/homepage/full_details.dart';
import 'package:afrahdz/views/widgets/homepage/searchfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class SearchProducts extends GetView<HomePageController> {
  const SearchProducts({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomePageController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
          child: Container(
        height: AppSize.appheight,
        width: AppSize.appwidth,
        color: Colors.white,
        child: ListView(
          children: [
            SizedBox(
              height: AppSize.appwidth * .02,
            ),
            Center(
                child: SizedBox(
                     width: AppSize.appwidth * .27,
                          height: AppSize.appheight * .03,
                    child: SvgPicture.asset('assets/svg/logo2.svg'))),
            SizedBox(
              height: AppSize.appwidth * .03,
            ),
            Row(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: AppSize.appwidth * .045),
                  child: InkWell(
                    onTap: () => Get.back(),
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                          shape: const CircleBorder(eccentricity: 0),
                          gradient: Appcolors.backbuttonGradient),
                      child: const Icon(
                        Icons.arrow_back_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Searchfield(
                    prefixIcon: const Icon(Icons.search_outlined),
                    hint: "SearchHint".tr,
                    search: (name) {
                      controller.searchinAllCats(name);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: AppSize.appheight * .02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "NormalTitleText".tr,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: AppSize.appheight * .02),
            Obx(
              () {
                if (controller.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Appcolors.primaryColor,
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      controller.normalAds.length,
                      (i) {
                        final ad = controller.normalAds[i];
                        return GestureDetector(
                          onTap: () => Get.to(
                              () => AdDetail(
                                    adId: ad.id,
                                  ),
                              arguments: {"id": ad.id},
                              transition: Transition.rightToLeftWithFade),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FullDetails(
                              selectedad: ad,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            )
          ],
        ),
      )),
    );
  }
}
