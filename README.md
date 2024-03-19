# users

A new Flutter project.

## Getting Started
```
git clone [this one]
flutter get
```

## using @JsonSerializable()
1. add annotation on class
    ```dart
    @JsonSerializable()
    class User {
      final int id;
      final String name;
      final String email;
      // ...
    }
    ```
2. `pubspec.yaml`, add package `json_serializable`
    ```yaml
    dependencies:
      # ...others
      json_serializable: any
    ```
3. then fetch packages
    ```shell
    flutter pub get
    ```
4. add package `build_runner` to `dev_dependencies`
    ```yaml
    dependencies:
      # ...others
      json_serializable: any
    
    dev_dependencies:
      # ...others
      build_runner:
    ```
5. then do this, it will generate a `user.g.dart` for you
    ```shell
    flutter pub run build_runner build
    ```

6. add methods
    ```dart
    part 'user.g.dart';
    @JsonSerializable()
    class User {
      factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
    
      Map<String, dynamic> toJson() => _$UserToJson(this);
    

7. Now you don't need to extract and assign properties one by one from the JSON. 