import 'package:api_series/pages/show_details_page.dart';
import 'package:flutter/material.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard(
      {Key? key,
      required this.id,
      required this.name,
      required this.imageThumbnailPath,
      })
      : super(key: key);

  final int id;
  final String name;
  final String imageThumbnailPath;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: ListTile(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShowDetailsPage(
                    id: id,
                  ),
                ),
              );
            },
            title: Text(
              name,
              style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.black),
            ),
            leading: 
             Container(
                    width: 50,
                    height: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(imageThumbnailPath),
                      ),
                    ),
            ),
        
          ),
       
    )
    ]);
    }}
    
    
