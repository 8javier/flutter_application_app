import 'package:flutter/material.dart';
import 'package:flutter_application_app/modelos/provider/authProvider.dart';

class RegistrationProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  String _name = '';
  String _specialization = '';

  String get email => _email;
  String get password => _password;
  String get name => _name;
  String get specialization => _specialization;

  void setEmail(String? email) {
    _email = email ?? '';
    notifyListeners();
  }

  void setPassword(String? password) {
    _password = password ?? '';
    notifyListeners();
  }

  void setName(String? name) {
    _name = name ?? '';
    notifyListeners();
  }

  void setSpecialization(String? specialization) {
    _specialization = specialization ?? '';
    notifyListeners();
  }

  void reset() {
    _email = '';
    _password = '';
    _name = '';
    _specialization = '';
    notifyListeners();
  }

  void registerUser({required String email, required String password, required String name, required String specialization }){
      
  }
  // ADD METODO REGISTRO USER
}


 /*
En este ejemplo, el RegistrationProvider se utiliza para almacenar los datos de registro del usuario (email, contraseña, nombre, especialización). 
El provider tiene getters para cada uno de estos campos.
Los métodos setEmail(), setPassword(), setName(), setSpecialization() se utilizan para asignar los valores correspondientes a los campos del usuario.
Estos métodos notifican a los oyentes (como widgets que utilizan este provider) sobre los cambios en los valores.
El método reset() se utiliza para restablecer todos los campos a su valor inicial, generalmente después de completar el proceso de registro o al cancelarlo.
Recuerda que puedes ajustar el código según tus necesidades y agregar otros campos o métodos según los requisitos específicos de tu aplicación de registro.
  */