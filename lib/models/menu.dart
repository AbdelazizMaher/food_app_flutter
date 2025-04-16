import 'rive_model.dart';

class Menu {
  final String title;
  final RiveModel rive;

  Menu({required this.title, required this.rive});
}

List<Menu> bottomNavItems = [
  Menu(
      title: "Home",
      rive: RiveModel(
      src: "assets/rive/icons.riv",
      artboard: "HOME",
      stateMachineName: "HOME_interactivity"),
  ),
  Menu(
    title: "Favorites",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "LIKE/STAR",
        stateMachineName: "STAR_Interactivity"),
  ),
  Menu(
    title: "Profile",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "USER",
        stateMachineName: "USER_Interactivity"),
  ),
  Menu(
    title: "Notification",
    rive: RiveModel(
        src: "assets/rive/icons.riv",
        artboard: "BELL",
        stateMachineName: "BELL_Interactivity"),
  ),
];