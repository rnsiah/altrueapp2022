import 'package:flutter/material.dart';
import 'package:mobile/Data_Layer/Models/category_model.dart';

class CauseDetails extends StatelessWidget {
  final Category cause;
  const CauseDetails({Key? key, required this.cause}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: Image(
          image: AssetImage('images/Altrue Logo White.png'),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 300,
                          width: 250,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: NetworkImage(cause.image))),
                        ),
                        Text(
                          cause.name,
                          style: TextStyle(
                            fontSize: 42,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          'Altrue Cause',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.w300),
                          textAlign: TextAlign.left,
                        )
                      ],
                    ),
                  ),

                  Divider(
                    color: Colors.black38,
                  ),
                  SizedBox(height: 30),
                  RichText(
                      softWrap: true,
                      text: TextSpan(
                          text: cause.information,
                          style:
                              TextStyle(fontSize: 20, color: Colors.black54))),
//                  Text(causes.causeInformation ?? '', style: TextStyle(
//                    fontSize: 20, color: Colors.black45, fontWeight: FontWeight.w500
//                  ),
//                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Text(
                    'Gallery',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w300),
                  ),

                  Container(

                      // child: ListView.builder(
                      //   itemCount: ,
                      //   itemBuilder: (context, index) {
                      //   return Card(child: Image.asset(null)
                      //
                      //   );
                      // },),
                      )
                ],
              ),
            ),
//            Positioned(
//              right: -60,
//              child: Container(
//                height: 300,
//                width: 250,
//                decoration: BoxDecoration(
//                    image:DecorationImage(fit: BoxFit.contain,
//                  image: AssetImage(causes.causeImage)
//                )),
//              ),
//            )
          ],
        ),
      ),
    );
  }
}
