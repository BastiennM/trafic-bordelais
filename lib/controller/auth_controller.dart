import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trafic_bordeaux/models/frequent_itinerary.dart';
import 'package:trafic_bordeaux/models/user_model.dart';
import 'package:trafic_bordeaux/ui/widgets/custom_progress_indicator.dart';
import 'package:trafic_bordeaux/ui/widgets/loading.dart';
import 'package:trafic_bordeaux/ui/widgets/snackbar.dart';

enum AuthType { register, login }

class AuthController extends GetxController {
  static AuthController to = Get.find();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  RxBool isConnected = false.obs;
  Rxn<UserModel> firestoreUser = Rxn<UserModel>();
  final RxBool admin = false.obs;
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
      isConnected.value = true;
      update();
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
    try {
      await _auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      emailController.clear();
      passwordController.clear();
      print(isConnected);
      Get.toNamed('/home');
    } catch (error) {
      CustomSnackbar().buildSnackbar('Erreur', 'Erreur lors du login', TypeMessage.error);
    }
  }

  // User registration using email and password
  registerWithEmailAndPassword(BuildContext context) async {
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
            name: nameController.text,
        );

        print(newUser);
        //create the user in firestore
        _createUserFirestore(newUser, result.user!);
        signInWithEmailAndPassword(context);
        emailController.clear();
        passwordController.clear();
      });
    } on FirebaseAuthException catch (error) {
      CustomSnackbar().buildSnackbar('Erreur', error.message ?? "", TypeMessage.error);
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
    isConnected.value = false;
    return _auth.signOut();
  }


}