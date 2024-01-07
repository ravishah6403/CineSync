import 'package:flutter/material.dart';
import 'package:movies_lister_app/api/api.dart';
import 'package:movies_lister_app/pages/details_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ListSlider extends StatelessWidget {
  const ListSlider({super.key, required this.snapshot});

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => PersistentNavBarNavigator.pushNewScreen(context,
              screen: DetailsPage(
                movie: snapshot.data[index],
              ),
              withNavBar: false),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox(
                  width: 160,
                  child: snapshot.data[index].posterPath.isEmpty
                      ? Image.asset(
                          'assets/imgs/video-movie-placeholder-image-grey_vertical.png')
                      : Image.network(
                          '${API.imgPath}${snapshot.data[index].posterPath}',
                          fit: BoxFit.cover,
                        )),
            ),
          ),
        );
      },
    );
  }
}
