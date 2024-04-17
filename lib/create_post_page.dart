

import 'package:flutter/material.dart';

class LostFoundForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
          child: Text(
            'Create Post',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700),),)],),


      body:SingleChildScrollView(
        child:Padding(
        padding: EdgeInsets.all(27),
        child: Column(

          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [

            Container(
              height: 44,
              child:TextFormField(
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Location',labelStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                fillColor: Colors.grey[900],
              ),
            ) ,
            ),
            

            SizedBox(height: 40,),


            Container(
              height: 44,
              child:TextFormField(
                maxLines: 2,
              decoration: InputDecoration(
                labelText: 'Time:',labelStyle: TextStyle(color: Colors.black45),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
            ),
            

            SizedBox(height: 40,),

            TextFormField(
              maxLines: 7, // adjust the number of lines here
              decoration: InputDecoration(
                labelText: 'Description',
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
              ),
            ),
          
            SizedBox(height: 30,),

            AttachImageButton(),

            SizedBox(height: 30,),
            
            ElevatedButton(
              onPressed: () {
              },
              child: Text('Post'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 7, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )
                
              ),
            ),
          ],
        ),
      ),
      )
      
    );
  }
}

class AttachImageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // TODO: Implement image attach logic
      },
      icon: Icon(Icons.add),
      label: Text('Attach an image'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.blue,
        side: BorderSide(width: 1.0, color: Colors.blue,),
        padding: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15))
      ),
    );
  }
}