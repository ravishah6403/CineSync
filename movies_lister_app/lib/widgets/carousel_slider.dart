import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movies_lister_app/api/api.dart';
import 'package:movies_lister_app/pages/details_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class TrendingSlider extends StatelessWidget {
  const TrendingSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: snapshot.data.length,
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 300,
        autoPlay: true,
        viewportFraction: 0.5,
      ),
      itemBuilder: (context, itemIndex, pageViewIndex) {
        return GestureDetector(
          onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
              screen: DetailsPage(
                movie: snapshot.data[itemIndex],
              ),
              withNavBar: false),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: SizedBox(
              width: 200,
              child: snapshot.data[itemIndex].posterPath.isEmpty
                  ? Image.asset(
                      'assets/imgs/video-movie-placeholder-image-grey_vertical.png')
                  : Image.network(
                      '${API.imgPath}${snapshot.data[itemIndex].posterPath}',
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        );
      },
    );
  }
}
