import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/shirt_model.dart';
import 'package:mobile/Data_Layer/Models/user_model.dart';
import 'package:mobile/Presentation/Router/functionality_router.dart';

class FeaturedShirts extends StatefulWidget {
  final double imageHeight;
  final List<Shirt> shirtlist;
  final double imageWidth;
  final String title;
  final Profile profile;

  FeaturedShirts({
    required this.profile,
    required this.title,
    required this.imageWidth,
    required this.shirtlist,
    required this.imageHeight,
    Key? key,
  }) : super(key: key);

  @override
  _FeaturedShirtsState createState() => _FeaturedShirtsState();
}

class _FeaturedShirtsState extends State<FeaturedShirts> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Altrue Collection Of The Week',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
              ),
              GestureDetector(
                onTap: () => {},
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.black54,
                  size: 28,
                ),
              )
            ],
          ),
        ),
        Container(
          height: widget.imageHeight,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.shirtlist.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/ShirtDetail',
                        arguments: ShirtDetailArguments(
                            shirt: widget.shirtlist[index],
                            profile: widget.profile));
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    width: widget.imageWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.white,
                              offset: Offset(0, 4),
                              blurRadius: 6),
                        ]),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        image:
                            NetworkImage(widget.shirtlist[index].shirtImage!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
