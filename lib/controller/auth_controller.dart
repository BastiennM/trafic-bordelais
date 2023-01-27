import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trafic_bordeaux/models/user_model.dart';
import 'package:trafic_bordeaux/ui/widgets/custom_progress_indicator.dart';

class AuthController extends GetxController {
  static AuthController to = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  final RxBool admin = false.obs;
  CustomProgressIndicator customProgressIndicator = const CustomProgressIndicator();
  @override
  void onReady() async {
    //run every time auth state changes
    ever(firebaseUser, handleAuthChanged);

    firebaseUser.bindStream(user);

    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  handleAuthChanged(_firebaseUser) async {
    //get user data from firestore
    if (_firebaseUser?.uid != null) {
      firestoreUser.bindStream(streamFirestoreUser());
      update();
    }

    if (_firebaseUser == null) {
      print('Send to signin');
      //TODO : Add sign in screen
      //Get.offAll(SignInUI());
    } else {
      print("send to register");
      //TODO: Add register screen
      //Get.offAll(HomeUI());
    }
  }

  // Firebase user one-time fetch
  Future<User> get getUser async => _auth.currentUser!;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  //Streams the firestore user from the firestore collection
  Stream<UserModel> streamFirestoreUser() {
    print('streamFirestoreUser()');

    return _db
        .doc('/users/${firebaseUser.value!.uid}')
        .snapshots()
        .map((snapshot) => UserModel.fromMap(snapshot.data()!));
  }

  //get the firestore user from the firestore collection
  Future<UserModel> getFirestoreUser() {
    return _db.doc('/users/${firebaseUser.value!.uid}').get().then(
            (documentSnapshot) => UserModel.fromMap(documentSnapshot.data()!));
  }

  //Method to handle user sign in using email and password
  signInWithEmailAndPassword(BuildContext context) async {
    customProgressIndicator.show();
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
      customProgressIndicator.close();
    } catch (error) {
      customProgressIndicator.close();
      Get.snackbar('auth.signInErrorTitle'.tr, 'auth.signInError'.tr,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 7),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  // User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
    customProgressIndicator.show();
    try {
      await _auth
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((result) async {
        print('uID: ${result.user!.uid}');
        print('email: ${result.user!.email}');

        //create the new user object
        UserModel newUser = UserModel(
            uid: result.user!.uid,
            email: result.user!.email!,
            name: nameController.text
        );
        //create the user in firestore
        _createUserFirestore(newUser, result.user!);
        emailController.clear();
        passwordController.clear();
        customProgressIndicator.close();
      });
    } on FirebaseAuthException catch (error) {
      customProgressIndicator.close();
      Get.snackbar('auth.signUpErrorTitle'.tr, error.message!,
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 10),
          backgroundColor: Get.theme.snackBarTheme.backgroundColor,
          colorText: Get.theme.snackBarTheme.actionTextColor);
    }
  }

  //create the firestore user in users collection
  void _createUserFirestore(UserModel user, User _firebaseUser) {
    _db.doc('/users/${_firebaseUser.uid}').set(user.toJson());
    update();
  }

  // Sign out
  Future<void> signOut() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    return _auth.signOut();
  }
}