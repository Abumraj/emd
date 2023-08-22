import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uniapp/models/userModel.dart';
import 'package:uniapp/repository/apiRepository.dart';
import 'package:uniapp/repository/apiRepositoryimplementation.dart';
import 'package:uniapp/widgets/theme_helper.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ApiRepository _apiRepository = Get.put(ApiRepositoryImplementation());
  bool isLoading = true;
  String role = 'Lecturer';
  User detail = User();

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  _getDetails() async {
    setState(() {
      isLoading = true;
    });
    await _apiRepository.getMyDetails().then((value) {
      print(value);
      setState(() {
        detail = value;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_ios_sharp)),
        title: Text("Profile", style: Theme.of(context).textTheme.headline4),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(color: Colors.purple),
            )
          : SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    /// -- IMAGE
                    Stack(
                      children: [
                        SizedBox(
                          width: 120,
                          height: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CircleAvatar(
                                foregroundImage: NetworkImage(detail.imageUrl!),
                              )),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 1,
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.purple),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text("${detail.title} ${detail.fullName}",
                        style: Theme.of(context).textTheme.headline4),
                    Text(detail.matricNo!,
                        style: Theme.of(context).textTheme.bodyText2),
                    const SizedBox(height: 20),

                    /// -- BUTTON
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () => Get.to(() {}),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            side: BorderSide.none,
                            shape: const StadiumBorder()),
                        child: const Text("EditProfile",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(),
                    const SizedBox(height: 10),

                    /// -- MENU
                    ProfileMenuWidget(
                        title: "${detail.department}",
                        icon: Icons.class_,
                        onPress: () {}),
                    ProfileMenuWidget(
                        title: "${detail.email}",
                        icon: Icons.email,
                        onPress: () {}),
                    ProfileMenuWidget(
                        title: "+${detail.phoneNo}",
                        icon: Icons.phone,
                        onPress: () {}),
                    ProfileMenuWidget(
                        title: "${detail.level} level",
                        icon: Icons.leaderboard,
                        onPress: () {}),
                    ProfileMenuWidget(
                        title: detail.sex!.toLowerCase() == "f"
                            ? "Female"
                            : "Male",
                        icon: Icons.person,
                        onPress: () {}),
                    const Divider(),
                    const SizedBox(height: 10),
                    ProfileMenuWidget(
                        title: "Information", icon: Icons.info, onPress: () {}),
                    ProfileMenuWidget(
                        title: "Logout",
                        icon: Icons.signpost_outlined,
                        textColor: Colors.red,
                        endIcon: false,
                        onPress: () {
                          Get.defaultDialog(
                            title: "LOGOUT",
                            titleStyle: const TextStyle(fontSize: 20),
                            content: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 15.0),
                              child: Text("Are you sure, you want to Logout?"),
                            ),
                            confirm: Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    side: BorderSide.none),
                                child: const Text("Yes"),
                              ),
                            ),
                            cancel: OutlinedButton(
                                onPressed: () => Get.back(),
                                child: const Text("No")),
                          );
                        }),
                  ],
                ),
              ),
            ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Colors.purple : Colors.purple;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child:
                  const Icon(Icons.ac_unit, size: 18.0, color: Colors.purple))
          : null,
    );
  }
}
