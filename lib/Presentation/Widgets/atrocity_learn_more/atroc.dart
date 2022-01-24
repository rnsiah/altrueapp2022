import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/atrocity_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AtroLearn extends StatelessWidget {
  final Atrocity atrocity;

  AtroLearn({Key? key, required this.atrocity}) : super(key: key);

  _launchURL(var url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return (atrocity.links != null)
        ? Container(
            child: ListView.builder(
                itemCount: atrocity.links!.length,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                          onTap: () => _launchURL(atrocity.links![index].link),
                          subtitle: Text(
                            atrocity.links![index].publication,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          title: Text(
                            atrocity.links![index].title,
                            style: TextStyle(fontSize: 20),
                          )),
                    )),
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                atrocity.title + ' has no relevent links at the moment',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
            ),
          );
  }
}
