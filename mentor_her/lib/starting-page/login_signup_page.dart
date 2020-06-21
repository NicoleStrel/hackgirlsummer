import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginSignupPage extends StatefulWidget {
  LoginSignupPage({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;
  

  @override
  State<StatefulWidget> createState() => new _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _formKey = new GlobalKey<FormState>();
  final databaseReference = Firestore.instance;

  String _email;
  String _password;
  String _errorMessage; //collects all the error messages from the functions
  String _fname;
  String _lastname;
  String _location;
  String _specialisation;
  String _cname;
  String _desc;
  String _category;

  bool _isMentor;
  bool _isLoginForm;
  bool _isLoading;

  //dropdown
  String _selectedCategory; 
  List<String> _categories = ['Creative', 'Technology','Digital Marketing', 'Consulting', 'Tax Preparation', 'Public Relations'];
  List<String> _specialities = ['Finance', 'Technology', 'Marketing', 'Human Resources', 'Entrepreneurship'];



  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      //_isLoading = true;
    });
    if (validateAndSave()) {
          //if new user:
    
      if (!_isLoginForm ){
        createRecord();
    }
      String userId = "";
      //createRecord();
      try {
        if (_isLoginForm) {
          userId = await widget.auth.signIn(_email, _password);
          print('Signed in: $userId');
        } else {
          userId = await widget.auth.signUp(_email, _password);
          print('Signed up user: $userId');
        }
        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null && _isLoginForm) {
          widget.loginCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = e.message;
          _formKey.currentState.reset();
        });
      }
    }

    
  }

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    _isLoginForm = true;
    _isMentor =false;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  void toggleFormMode() {
    resetForm();
    setState(() {
      _isLoginForm = !_isLoginForm;
    });
  }
  void toggleAccountMode(){
    resetForm();
    setState(() {
      _isMentor =!_isMentor;
    });
  }
  void createRecord() async {
    if (_isMentor){
      await databaseReference.collection("mentors")
        .document(_email)
        .setData({
          'email': _email,
          'fname': _fname,
          'lastname': _lastname,
          'location': _location,
          'specialisation': _specialisation,
        });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Mentor Profile created successfully"),
        duration: Duration(seconds: 3),
      ));
    }
    else{
        await databaseReference.collection("organisations")
        .document(_email)
        .setData({
          'Cname': _cname,
          'desc': _desc,
          'email': _email,
          'location': _location,
          'category': _category,
          'mentors': FieldValue.arrayUnion([""]),
        });
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Company Profile created successfully"),
          duration: Duration(seconds: 3),
        ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        
        body: Stack(
          children: <Widget>[
            _showForm(), //form 
            _showCircularProgress(), //progress after
          ],
        ));
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  Widget _showForm() {
    return new Container(
        padding: EdgeInsets.all(16.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            shrinkWrap: true,
            children: _isLoginForm ? <Widget>[
              showLogo(),
              showProfileChoice(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ] : <Widget>[
              showLogo(),
              showProfileChoice(),
              showNameInput(),
              showDescInput(),
              showCategoryInput(),
              showLocationInput(),
              showEmailInput(),
              showPasswordInput(),
              showPrimaryButton(),
              showSecondaryButton(),
              showErrorMessage(),
            ],
              
          ),
        ));
  }
  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget showLogo() {
    return new Hero(
      tag: 'hero',
      child: Padding(
        padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: Image.asset('assets/havemyback-logo.png'),
        ),
      ),
    );
  }
  Widget showProfileChoice(){
      return new Container(
        margin: new EdgeInsets.only(left: 70.0,right: 70.0, top:5.0),

        child:new FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
                side: BorderSide(color: Colors.red[400])
            ),
            padding: EdgeInsets.only(left:2, right:2, top:5, bottom:5),
            textColor: Colors.black,
            child: new Text(
                _isMentor ? 'Account Type: Mentor' : 'Account Type: Company',
                style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300, color: Colors.red[400])),
            onPressed: toggleAccountMode
          )
      );
  }

  Widget showEmailInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.emailAddress,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.red[200],
            )),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value.trim(),
      ),
    );
  }
  
  Widget showNameInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: _isMentor ? 'First Name' : 'Company Name',
            icon: new Icon(
              _isMentor ? IconData(59389, fontFamily: 'MaterialIcons'): IconData(59387, fontFamily: 'MaterialIcons'),
              color: Colors.red[200],
            )),
        validator: (value) => value.isEmpty ? _isMentor ? 'First Name can\'t be empty' : 'Company name can\'t be empty' : null,
        onSaved: (value) => _isMentor ? _fname=value.trim() : _cname = value.trim(),
      ),
    );
  }
  Widget showDescInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: _isMentor ? 'Last Name' : 'Short Description',
            icon: new Icon(
              _isMentor ? IconData(59389, fontFamily: 'MaterialIcons'): IconData(57680, fontFamily: 'MaterialIcons'),
              color: Colors.red[200],
            )),
        validator: (value) => value.isEmpty ? _isMentor ? 'Last Name can\'t be empty' : 'Description can\'t be empty' : null,
        onSaved: (value) => _isMentor ? _lastname=value.trim() : _desc = value.trim(),
      ),
    );
  }
  Widget showLocationInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.text,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Location',
            icon: new Icon(
              IconData(58741, fontFamily: 'MaterialIcons'),
              color: Colors.red[200],
            )),
        validator: (value) => value.isEmpty ? 'Location can\'t be empty' : null,
        onSaved: (value) =>  _location = value.trim(),
      ),
    );
  }
  Widget showCategoryInput(){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: Stack(
        children:<Widget>[
          Container(
            padding: EdgeInsets.only(left: 40.0),
            child: new Container(
              decoration: BoxDecoration( //need margin left to match
                border: Border(bottom: BorderSide(color:Colors.grey)),
              ),
              padding: new EdgeInsets.only(top: 3),
              child:DropdownButtonFormField<String>(
                isExpanded: true,
                hint: Text(
                  _isMentor ? 'Specialisation':'Category',
                ),
                items: _isMentor ?
                    _specialities.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList() :
                  _categories.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _selectedCategory,
                onChanged: (value) =>
                  setState(() => {
                    _selectedCategory = value,
                    _specialisation=_selectedCategory,
                    _category = _selectedCategory,
                }),
                validator: (value) => value == null ? _isMentor ? 'Specialisation can\'t be empty' : 'Category can\'t be empty' : null,
              )
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10.0),
            child: Icon(
              IconData(58306, fontFamily: 'MaterialIcons'),
              color: Colors.red[200],
              //size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
 
  Widget showPasswordInput() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      child: new TextFormField(
        maxLines: 1,
        obscureText: true,
        autofocus: false,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.red[200],
            )),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value.trim(),
      ),
    );
  }

  Widget showSecondaryButton() {
    return new FlatButton(
        child: new Text(
            _isLoginForm ? 'Create an account' : 'Have an account? Sign in',
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300)),
        onPressed: toggleFormMode
    );
  }

  Widget showPrimaryButton() {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
        child: SizedBox(
          height: 40.0,
          child: new RaisedButton(
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
            color: Colors.redAccent,
            child: new Text(_isLoginForm ? 'Login' : 'Create account',
                style: new TextStyle(fontSize: 20.0, color: Colors.white)),
            onPressed:() {
               validateAndSubmit(); //submit to firebase
            }, 
          ),
        ));
  }
}

