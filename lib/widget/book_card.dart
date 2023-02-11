import 'package:flutter/material.dart';
import 'package:physic/resoure/color.dart';




class CategoryCard extends StatelessWidget {
  
  final String imagePath;
  final String title;
  final Function press;
   // ignore: use_key_in_widget_constructors
   const CategoryCard({Key? key, 
    
    required this.imagePath,
    required this.title,
    required this.press,
    
  });  

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        ),
      shadowColor: Colors.black,
      elevation: 5,
      child: InkWell(
        onTap: (){press();},
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(10), 
                  topRight: Radius.circular(10)
                  ),
                color: Colors.white,
                image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill))
            ),
            ),
            
            Text(title, style:const TextStyle(color: secondaryColor, fontSize: 20, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
    
  }
}