# Base Flutter Project for Cuppertino look and feel

This project is a starting point for a Flutter application with a Cupertino look and feel.

## Getting Starte

cd cupertino_base
flutter clean
flutter create . --platforms=macos

## Clone and create a different project

For example to create a new GitHub project named FT04-Stacks

With a Flutter project named 'stacks'

``` bash
git clone https://github.com/optimisme/DAM-FlutterCupertinoBase
mv DAM-FlutterCupertinoBase FT04-Stacks
cd FT04-Stacks
mv cupertino_base stacks
git remote set-url origin https://github.com/GITHUB-USERNAME/FT04-Stacks.git
git push -u origin main

```

Ensure that 'pubspec.yaml' contains the correct project name

## Download and install dependencies

``` bash
cd stacks
flutter create --project-name stacks .
flutter pub get
flutter run
```