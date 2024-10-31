import '../../../../global_import.dart';
import '../controllers/home_controller.dart';

var menu = [
  {
    "title": "Home",
    "icon": "icon.png".asset,
  },
];

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    final offlineData = homeController.offlineData;
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            InkWell(
              child: Container(
                width: double.infinity,
                height: 183,
                decoration: const BoxDecoration(color: Color(0xFFFCEBEC)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: ShapeDecoration(
                          color: AppColor.colorBrand,
                          shape: const OvalBorder(),
                        ),
                      ),
                      const ColumnSpace(
                        space: 16,
                      ),
                      Text(
                        "NonditoSoft Demo",
                        style: TextStyle(
                          color: Color(0xFF1C1C20),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const ColumnSpace(
                        space: 0,
                      ),
                      Text(
                        "eve.holt@reqres.in",
                        style: TextStyle(
                          color: Color(0xFF9E9E9E),
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: ListView(
                children: [
                  ColumnSpace(
                    space: 32,
                  ),
                  ...menu.map((menuItem) => DrawerMenuItem(
                        title: menuItem['title'],
                        icon: menuItem['icon'],
                        onTap: () {
                          Get.back();
                          Get.toNamed(menuItem['route'] ?? Routes.HOME,
                              preventDuplicates: true);
                        },
                      ))
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(
                left: 0,
                bottom: 48,
              ),
              child: InkWell(
                onTap: () {
                  offlineData.setToken("");
                  offlineData.setSession({});
                  Get.toNamed(Routes.LOGIN);
                },
                child: Container(
                  decoration: ShapeDecoration(
                    color: AppColor.colorBrand,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x33FE724C),
                        blurRadius: 30,
                        offset: Offset(0, 10),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(),
                          child: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                        const RowSpace(
                          space: 4,
                        ),
                        const Text(
                          'Log Out',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageLogo extends StatelessWidget {
  const ImageLogo({
    super.key,
    this.size,
    this.asset,
    this.color,
  });

  final double? size;
  final String? asset;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 24,
      height: size ?? 24,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(),
      child: ImageIcon(
        AssetImage(asset ?? "fuudy_icon.png".asset),
        color: color ?? AppColor.colorPrimary,
      ),
    );
  }
}

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    super.key,
    this.title,
    this.icon,
    this.onTap,
  });

  final String? title;
  final String? icon;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            children: [
              ImageLogo(
                asset: icon,
              ),
              const RowSpace(
                space: 16,
              ),
              Text(
                title ?? 'Home',
                style: const TextStyle(
                  color: Color(0xFF2D2D2D),
                  fontSize: 16,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              )
            ],
          ),
          const ColumnSpace(
            space: 32,
          )
        ],
      ),
    );
  }
}
