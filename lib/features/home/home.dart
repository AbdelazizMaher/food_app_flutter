import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app_lab/features/home/widgets/btm_nav_item.dart';
import 'package:food_app_lab/features/home/widgets/custom_search_bar.dart';
import 'package:food_app_lab/features/home/widgets/section_header.dart';
import 'package:rive/rive.dart' as rive;
import '../../models/meal_model.dart' ;
import '../../models/menu.dart';
import '../../utils/rive_utils.dart';
import 'widgets/category_items_view.dart';
import 'widgets/restaurants_items_view.dart';
import 'widgets/special_offer_items_view.dart';

class Home extends StatefulWidget {
   const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>
  with SingleTickerProviderStateMixin {
  bool isSideBarOpen = false;

  Menu selectedBottonNav = bottomNavItems.first;

  late rive.SMIBool isMenuOpenInput;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }

  late AnimationController _animationController;
  late Animation<double> scalAnimation;
  late Animation<double> animation;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
            () {
          setState(() {});
        },
      );
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  String category = "Beef";
  List<MealDetails>? selectedId;

  FlutterSecureStorage storage = const FlutterSecureStorage();
  void logOut() async {
    await storage.write(key: 'isLoggedIn', value: 'false');
    Navigator.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: 40,
            width: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: IconButton(
              onPressed: (){},
              icon: Image.asset(
                'assets/icons/list.png',
                height: 36,
                width: 36,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0, right: 16.0),
            child: Badge(
              label: const Text(
                "2",
                style: TextStyle(color: Colors.white),
              ),
              child: GestureDetector(
                onTap: () {
                  logOut();
                },
                child: Image.asset(
                  'assets/images/person.png',
                  fit: BoxFit.cover,
                  scale: 0.1,
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Deliver to", style: TextStyle(fontSize: 18, color: Colors.grey, fontWeight: FontWeight.bold)),
                Image.asset(
                  'assets/icons/location.png',
                  height: 24,
                  width: 24,
                ),
              ]
            ),
            Text("387  Merdina", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))
          ]
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0,),
            sliver: SliverList(delegate: SliverChildListDelegate([
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFFE724D), Color(0xFFFFA057)],
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: const Text(
                  "Good Afternoon!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              CustomSearchBar(),
              const SizedBox(height: 16),
              CategoryListView(
                onCategorySelected: (newCategory) {
                  setState(() {
                    category = newCategory;
                  });
                },
              ),
              const SizedBox(height: 16),
              SectionHeader(title: "Special Offers", onViewAll: () {}),
              const SizedBox(height: 16),
              SpecialOfferListView(selectedCategory: category),
              const SizedBox(height: 16),
              SectionHeader(title: "Restaurants", onViewAll: () {}),
              const SizedBox(height: 16),
              RestaurantsItemListView(),
            ]))
        ),
        ]
      ),
      bottomNavigationBar: Transform.translate(
          offset: Offset(0, 100 * animation.value),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SafeArea(
            child: Container(
            padding:
            const EdgeInsets.only(left: 12, top: 12, right: 12, bottom: 12),
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
            color: Color(0xFF242731),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF242731),
                offset: const Offset(0, 20),
                blurRadius: 20,
              ),
            ],
                    ),
                    child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavItems.length,
                    (index) {
                  Menu navBar = bottomNavItems[index];
                  return BtmNavItem(
                    navBar: navBar,
                    press: () {
                      RiveUtils.chnageSMIBoolState(navBar.rive.status!);
                      updateSelectedBtmNav(navBar);
                    },
                    riveOnInit: (artboard) {
                      navBar.rive.status = RiveUtils.getRiveInput(artboard,
                          stateMachineName: navBar.rive.stateMachineName);
                    },
                    selectedNav: selectedBottonNav,
                  );
                },
              ),
            ],
                    ),
                ),
                ),
          ),
      )
    );
  }
}
