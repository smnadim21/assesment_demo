import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nondito_soft_demo/app/core/theme/theme.dart';
import 'package:nondito_soft_demo/app/core/ui/future_widget.dart';
import 'package:nondito_soft_demo/app/core/ui/widgets.dart';
import 'package:nondito_soft_demo/app/data/user.dart';
import 'package:nondito_soft_demo/app/modules/home/views/drawer.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          return Visibility(
            visible: controller.search.isFalse,
            replacement: TextFormField(
                controller: controller.searchC,
                cursorColor: AppColor.colorPrimary,
                onChanged: (str) {
                  controller.filterUser(str);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColor.colorPrimary,
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  hintText: 'Search Name, Phone, Email',
                )),
            child: const Text("User List"),
          );
        }),
        actions: [
          Obx(() {
            return Visibility(
                visible: controller.search.isFalse,
                replacement: IconButton(
                    onPressed: () {
                      if (controller.searchC.text.isEmpty) {
                        controller.search.value = false;
                      }
                      {
                        controller.searchC.clear();
                        controller.filterUser("");
                      }
                    },
                    icon: const Icon(Icons.clear)),
                child: IconButton(
                    onPressed: () {
                      controller.search.value = true;
                    },
                    icon: const Icon(Icons.search)));
          })
        ],
      ),
      body: PageContainer(
        child: Obx(
          () => Visibility(
            visible: controller.reload.isFalse,
            replacement: ShimmerList(
                child: UserCard(
                  user: NonditoUser(),
                  isShimmer: true,
                )),
            child: FutureWidget(
              future: controller.api.getUsers(),
              shimmer: ShimmerList(
                  child: UserCard(
                user: NonditoUser(),
                isShimmer: true,
              )),
              errorWidget: (snapshot, data) => Center(
                child: Column(
                  children: [
                    Spacer(),
                    const Text(
                      "An Error Occurred",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const ColumnSpace(),
                    ThemeButton(
                      onPressed: () async {
                        await controller.retry();
                      },
                      text: "Retry",
                      wrap: true,
                    ),
                    Spacer()
                  ],
                ),
              ),
              buildWidget: (data) {
                controller.setListData(data);
                return Obx(() {
                  List<NonditoUser> userList = controller.uList;
                  return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (BuildContext context, int index) {
                      NonditoUser user = userList[index];
                      return InkWell(
                        child: UserCard(user: user),
                        onTap: () {
                          Get.toNamed(Routes.DETAILS,
                              arguments: {"id": user.id});
                        },
                      );
                    },
                  );
                });
              },
            ),
          ),
        ),
      ),
      drawer: DrawerMenu(homeController: controller),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
    this.isShimmer = false,
  });

  final NonditoUser user;
  final bool isShimmer;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: isShimmer ? Colors.transparent : Get.theme.cardColor,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 60,
                height: 60,
                decoration: ShapeDecoration(
                  color: AppColor.colorBrand,
                  shape: const OvalBorder(),
                ),
                child: Center(
                    child: Text(
                  "${user.name?.substring(0, 1)}",
                  style: TextStyle(
                      color: AppColor.colorSuccessBg,
                      fontSize: 36,
                      fontWeight: FontWeight.w500),
                )),
              ),
            ),
            RowSpace(
              space: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.name ?? "Full Name",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600)),
                  ColumnSpace(
                    space: 3,
                  ),
                  Text(
                    "@${user.username ?? "username"}",
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 12),
                  ),
                  ColumnSpace(
                    space: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      RowSpace(
                        space: 4,
                      ),
                      Text(user.email ?? "abcdef@examplemail.com",
                          style: const TextStyle(
                              fontWeight: FontWeight.w300, fontSize: 13)),
                    ],
                  ),
                  ColumnSpace(
                    space: 2,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 16,
                        color: Colors.grey.shade500,
                      ),
                      RowSpace(
                        space: 4,
                      ),
                      Text(user.phone ?? "+880 12345 677 89"),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
