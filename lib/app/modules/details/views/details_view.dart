import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nondito_soft_demo/app/core/ui/future_widget.dart';
import 'package:nondito_soft_demo/app/core/ui/widgets.dart';
import 'package:nondito_soft_demo/app/data/user.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/theme.dart';
import '../controllers/details_controller.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    int id = controller.args["id"] ?? 1;
    return Scaffold(
      appBar: AppBar(),
      body: PageContainer(
        child: FutureWidget(
          shimmer: const Center(child: LoaderView()),
          future: controller.api.getUserById(id: id),
          buildWidget: (data) {
            NonditoUser user = data ?? NonditoUser();
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 140,
                    height: 140,
                    decoration: ShapeDecoration(
                      color: AppColor.colorBrand,
                      shape: const CircleBorder(),
                    ),
                    child: Center(
                        child: Text(
                      "${user.name?.substring(0, 1)}",
                      style: TextStyle(
                          color: AppColor.colorSuccessBg,
                          fontSize: 56,
                          fontWeight: FontWeight.w500),
                    )),
                  ),
                ),
                Text(user.name ?? "Full Name",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                Text(
                  "@${user.username ?? "username"}",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 12),
                ),
                Text(user.company?.bs ?? "abcdef@examplemail.com",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w300, fontSize: 13)),
                Text(user.company?.catchPhrase ?? "abcdef@examplemail.com",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400, fontSize: 13)),
                ColumnSpace(),
                ThemeTextField(
                  onTap: () async {
                    await launchUrl(Uri(
                        scheme: 'tel',
                        path: user.phone ?? "+880 12345 677 89"));
                  },
                  suffixIcon: Icon(Icons.phone),
                  readOnly: true,
                  labelText: "Phone",
                  initialValue: user.phone ?? "+880 12345 677 89",
                ),
                ThemeTextField(
                  onTap: () {
                    launchUrl(Uri(
                        scheme: 'mailto',
                        path: user.email ?? "smnadim@example.com"));
                  },
                  suffixIcon: Icon(Icons.email),
                  readOnly: true,
                  labelText: "Email",
                  initialValue: user.email ?? "smnadim@example.com",
                ),
                ThemeTextField(
                  onTap: () {
                    launchUrl(Uri(
                        scheme: 'https',
                        path: user.website ?? "www.example.com"));
                  },
                  suffixIcon: Icon(Icons.web_asset),
                  readOnly: true,
                  labelText: "Website",
                  initialValue: user.website ?? "www.example.com",
                ),
                ColumnSpace(),
                Text("Company Information",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                ColumnSpace(),
                ThemeTextField(
                  suffixIcon: Icon(Icons.location_city),
                  readOnly: true,
                  labelText: "Company name",
                  initialValue: user.company?.name ?? "xyz Ltd",
                ),
                ColumnSpace(),
                Text("Address",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600)),
                ColumnSpace(),
                ThemeTextField(
                  readOnly: true,
                  labelText: "Street",
                  initialValue: user.address?.street ?? "Hakaluki Street",
                ),
                ThemeTextField(
                  readOnly: true,
                  labelText: "Suite",
                  initialValue: user.address?.suite ?? "APT. 555",
                ),
                ThemeTextField(
                  readOnly: true,
                  labelText: "City",
                  initialValue: user.address?.city ?? "APT. City",
                ),
                ThemeTextField(
                  readOnly: true,
                  labelText: "Zip code",
                  initialValue: user.address?.zipcode ?? "2200",
                ),
                ThemeButton(
                  onPressed: () {
                    launchUrl(Uri.parse(
                        "geo:0,0?q=${user.address?.geo?.lat},${user.address?.geo?.lng}"));
                  },
                  child: Row(
                    children: [
                      Spacer(),
                      Text("View on Map"),
                      RowSpace(
                        space: 4,
                      ),
                      Icon(
                        Icons.assistant_navigation,
                        color: Colors.white,
                      ),
                      Spacer()
                    ],
                  ),
                ),
                ColumnSpace()
              ],
            );
          },
        ),
      ),
    );
  }
}
