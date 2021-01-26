import 'package:flutter/material.dart';

class TermsOfServices extends StatefulWidget {
  @override
  _TermsOfServicesState createState() => _TermsOfServicesState();
}

class _TermsOfServicesState extends State<TermsOfServices> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Services'),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(screenSize / 20),
                    child: Text(
                      'A. Definitions',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                  Text(
                    "Short version: We use these basic terms throughout the agreement, and they have specific meanings. You should know what we mean when we use each of the terms. There's not going to be a test on it, but it's still useful information.",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: screenSize/20),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam scelerisque nisi vitae nibh laoreet, vitae iaculis mi placerat. Curabitur non lectus eu lorem vestibulum finibus sed nec neque. Nullam lobortis interdum nunc vel tempus. Sed aliquet felis nec rhoncus bibendum. Donec et massa vel velit ullamcorper hendrerit eu in mi. Praesent a malesuada dui, in sodales libero. Vivamus rutrum diam non mauris bibendum euismod. Aliquam erat volutpat. Proin volutpat ex non ligula fermentum, nec tincidunt libero facilisis. Vivamus nibh risus, condimentum vitae gravida et, consectetur et diam. Integer auctor felis a urna eleifend, eget consequat orci hendrerit. Curabitur at semper orci, eu vestibulum lectus."
                      "Nunc a risus molestie, hendrerit mauris vel, fringilla urna. Ut non fringilla leo, sit amet venenatis elit. Integer non dolor vulputate, pharetra metus ut, pulvinar erat. Mauris ac tempor dolor. Ut id nisi ut nibh maximus aliquet feugiat eget turpis. Curabitur congue finibus leo eget efficitur. Quisque porta mi at ornare imperdiet. Donec feugiat sagittis vestibulum. Donec quis risus ultricies, maximus purus a, accumsan libero. Integer elementum eros sed aliquet fringilla."
                      "In dui felis, bibendum at ipsum eu, lobortis sollicitudin orci. Cras placerat tempor purus accumsan rhoncus. Vestibulum lectus felis, lobortis sit amet eleifend sit amet, aliquet pharetra magna. Phasellus eu ex id elit vehicula vehicula. Vivamus dignissim augue sed magna faucibus, ut blandit lorem tristique. Vestibulum lacinia non risus eleifend posuere. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam sodales finibus augue. Donec tincidunt ultrices dictum. Donec tristique elit a dolor laoreet ullamcorper. Etiam egestas libero quis lacus dapibus consequat. Aliquam euismod malesuada odio sed congue. Suspendisse mauris libero, malesuada eget consequat sit amet, vestibulum vel lacus."
                      "Curabitur bibendum eros magna, et iaculis lectus lobortis sit amet. Nulla facilisi. Mauris turpis orci, auctor sit amet eleifend ac, cursus vitae enim. Morbi id eros nibh. Suspendisse aliquam gravida mauris, ut consequat ipsum. Aliquam condimentum congue sollicitudin. Cras eu feugiat nisi. In vehicula sagittis posuere. Sed eu nunc a diam bibendum aliquam in in ante. Integer euismod nunc et eros mattis, sed sagittis mauris convallis. Aenean nec justo sit amet purus venenatis elementum sed vitae urna. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed consectetur nisi elit, eu sodales elit pellentesque ac."
                      "Pellentesque maximus mattis aliquet. Proin vel arcu congue augue ultrices euismod. Donec et enim congue, scelerisque nisl non, hendrerit magna. Nam mi lectus, egestas eget sodales in, sollicitudin sit amet metus. In sit amet leo nibh. Nam ut nisi sagittis leo sollicitudin ultricies sit amet at nulla. Duis imperdiet lobortis neque eget molestie. Duis convallis et velit eu sodales. Nunc dui nulla, elementum et porttitor in, euismod at elit. Vivamus vitae consectetur neque, ac scelerisque justo. Suspendisse gravida massa accumsan ante interdum rhoncus.",
                      textAlign: TextAlign.justify
                  ),
                  Padding(
                    padding: EdgeInsets.all(screenSize / 20),
                    child: Text(
                      'B. Account Terms',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent),
                    ),
                  ),
                  Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam scelerisque nisi vitae nibh laoreet, vitae iaculis mi placerat. Curabitur non lectus eu lorem vestibulum finibus sed nec neque. Nullam lobortis interdum nunc vel tempus. Sed aliquet felis nec rhoncus bibendum. Donec et massa vel velit ullamcorper hendrerit eu in mi. Praesent a malesuada dui, in sodales libero. Vivamus rutrum diam non mauris bibendum euismod. Aliquam erat volutpat. Proin volutpat ex non ligula fermentum, nec tincidunt libero facilisis. Vivamus nibh risus, condimentum vitae gravida et, consectetur et diam. Integer auctor felis a urna eleifend, eget consequat orci hendrerit. Curabitur at semper orci, eu vestibulum lectus."
                      "Nunc a risus molestie, hendrerit mauris vel, fringilla urna. Ut non fringilla leo, sit amet venenatis elit. Integer non dolor vulputate, pharetra metus ut, pulvinar erat. Mauris ac tempor dolor. Ut id nisi ut nibh maximus aliquet feugiat eget turpis. Curabitur congue finibus leo eget efficitur. Quisque porta mi at ornare imperdiet. Donec feugiat sagittis vestibulum. Donec quis risus ultricies, maximus purus a, accumsan libero. Integer elementum eros sed aliquet fringilla."
                      "In dui felis, bibendum at ipsum eu, lobortis sollicitudin orci. Cras placerat tempor purus accumsan rhoncus. Vestibulum lectus felis, lobortis sit amet eleifend sit amet, aliquet pharetra magna. Phasellus eu ex id elit vehicula vehicula. Vivamus dignissim augue sed magna faucibus, ut blandit lorem tristique. Vestibulum lacinia non risus eleifend posuere. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Aliquam sodales finibus augue. Donec tincidunt ultrices dictum. Donec tristique elit a dolor laoreet ullamcorper. Etiam egestas libero quis lacus dapibus consequat. Aliquam euismod malesuada odio sed congue. Suspendisse mauris libero, malesuada eget consequat sit amet, vestibulum vel lacus."
                      "Curabitur bibendum eros magna, et iaculis lectus lobortis sit amet. Nulla facilisi. Mauris turpis orci, auctor sit amet eleifend ac, cursus vitae enim. Morbi id eros nibh. Suspendisse aliquam gravida mauris, ut consequat ipsum. Aliquam condimentum congue sollicitudin. Cras eu feugiat nisi. In vehicula sagittis posuere. Sed eu nunc a diam bibendum aliquam in in ante. Integer euismod nunc et eros mattis, sed sagittis mauris convallis. Aenean nec justo sit amet purus venenatis elementum sed vitae urna. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed consectetur nisi elit, eu sodales elit pellentesque ac."
                      "Pellentesque maximus mattis aliquet. Proin vel arcu congue augue ultrices euismod. Donec et enim congue, scelerisque nisl non, hendrerit magna. Nam mi lectus, egestas eget sodales in, sollicitudin sit amet metus. In sit amet leo nibh. Nam ut nisi sagittis leo sollicitudin ultricies sit amet at nulla. Duis imperdiet lobortis neque eget molestie. Duis convallis et velit eu sodales. Nunc dui nulla, elementum et porttitor in, euismod at elit. Vivamus vitae consectetur neque, ac scelerisque justo. Suspendisse gravida massa accumsan ante interdum rhoncus.",
                      textAlign: TextAlign.justify
                  ),
                ],
              ),
            ),

          ),

        ],
      ),
    );
  }
}
