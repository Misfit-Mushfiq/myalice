import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoDataFound extends StatelessWidget {
  final String title;
  const NoDataFound({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
                  child: Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top:100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.copy,
                            size: 150,
                            color: Colors.grey,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(title,style: TextStyle(fontSize: 16),),
                          )
                        ],
                      ),
                    ),
                  ),
                );
  }
}
