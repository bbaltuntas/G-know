import 'package:cloud_firestore/cloud_firestore.dart';
import 'main.dart';

class AdviceFirestore {
  CollectionReference advices = FirebaseFirestore.instance.collection('advices');

  Future getAdvices() async {
    List adviceList = [];

    try {
      await advices.get().then((value) {
        print("Advices Found");
        value.docs.forEach((element) {
          adviceList.add(element.data());
        });
      });
      return adviceList;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fetchAdvicesFirestore() async {
    dynamic resultant = await getAdvices();

    if (resultant == null) {
      print('Unable to retrieve');
    } else {
      MyApp.adviceList = resultant;
    }
  }
}
