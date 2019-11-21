# example

Kopo Example

```dart
import 'package:kopo/kopo.dart';

MaterialButton(
  child: Text('find Korea Postal address'),
  onPressed: () async {
    KopoModel model = await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Kopo(),
      ),
    );
  },
),
```