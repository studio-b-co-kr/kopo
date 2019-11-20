![](https://salondecode.github.io/kopo/assets/kopo_logo.gif)

find Korea Postal address

![](https://salondecode.github.io/kopo/assets/kopo_video.gif)

## Getting Started
You should ensure that you add the router as a dependency in your flutter project.
```yaml
dependencies:
 kopo: "^0.1.0"
```

## Example
```dart
MaterialButton(
  child: Text('find Korea Postal address'),
  onPressed: () async {
    KopoModel model =
        KopoModel.fromJson(jsonDecode(await Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => Kopo(),
      ),
    )));
  },
),
```