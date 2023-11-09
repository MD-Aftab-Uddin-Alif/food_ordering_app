import 'package:ePolli/app/core/theme/app_color.dart';
import 'package:ePolli/app/core/widgets/constant.dart';
import 'package:ePolli/app/modules/cart/cart_controller.dart';
import 'package:ePolli/app/modules/more/more_controller.dart';
import 'package:ePolli/app/modules/profile/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  int _currentStep = 0;
  List<Step> _formSteps = [];
  bool _obscureText = true;

  final GlobalKey<FormState> _formKeyForPersonalDetails = GlobalKey();
  final GlobalKey<FormState> _formKeyForBankDetails = GlobalKey();
  final GlobalKey<FormState> _formKeyForNomineeDetails = GlobalKey();

  final ProfileController profileController = Get.put(ProfileController());
  final CartController cartController = Get.put(CartController());

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nidController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _bankBranchNameController =
      TextEditingController();
  final TextEditingController _accountHolderNameController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _nomineeNameController = TextEditingController();
  final TextEditingController _nomineeRelationController =
      TextEditingController();
  final TextEditingController _nomineePhoneNumberController =
      TextEditingController();
  final TextEditingController _nomineeNidNumberController =
      TextEditingController();

  @override
  void initState() {
    // * controllers of personal details
    _fullNameController.text = profileController.investorInfo.value.fullName;
    _phoneNumberController.text =
        profileController.investorInfo.value.phoneNumber;
    _emailController.text = profileController.investorInfo.value.email ?? '';
    _addressController.text =
        profileController.investorInfo.value.address ?? '';
    _passwordController.text = profileController.investorInfo.value.password;
    _nidController.text = profileController.investorInfo.value.nidNumber ?? '';

// * controllers of bank details
    _bankNameController.text =
        profileController.investorInfo.value.bankName ?? '';
    _bankBranchNameController.text =
        profileController.investorInfo.value.bankBranchName ?? '';
    _accountHolderNameController.text =
        profileController.investorInfo.value.accountHolderName ?? '';
    _accountNumberController.text =
        profileController.investorInfo.value.accountNumber ?? '';

    // * controllers of nominee details
    _nomineeNameController.text =
        profileController.investorInfo.value.nomineeName ?? '';
    _nomineeRelationController.text =
        profileController.investorInfo.value.relationship ?? '';
    _nomineePhoneNumberController.text =
        profileController.investorInfo.value.nomineePhoneNumber ?? '';
    _nomineeNidNumberController.text =
        profileController.investorInfo.value.nomineeNidNumber ?? '';
    _formSteps = [
      Step(
        title: Text('Step 1'.tr),
        content: personalDetailsForm(),
      ),
      Step(
        title: Text('Step 2'.tr),
        content: bankDetailsFrom(),
      ),
      Step(
        title: Text('Step 3'.tr),
        content: nomineeDetailsFrom(),
      ),
    ];

    super.initState();
  }

  Container personalDetailsForm() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeyForPersonalDetails,
        child: Column(
          children: [
            TextFormField(
              textInputAction: TextInputAction.next,
              controller: _fullNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Full Name'.tr,
                hintText: 'Enter your name'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
            TextFormField(
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              controller: _phoneNumberController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Phone Number'.tr,
                hintText: 'Enter your phone number'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your phone number'.tr;
                }
                return null;
              },
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Email'.tr,
                hintText: 'Enter your email'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _passwordController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Password'.tr,
                hintText: 'Enter your password'.tr,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _addressController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Address'.tr,
                hintText: 'Enter your address'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your address'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _nidController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'NID Number'.tr,
                hintText: 'Enter NID Number'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter NID number'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
            Constant.sbHFifteen,
          ],
        ),
      ),
    );
  }

  Container nomineeDetailsFrom() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeyForNomineeDetails,
        child: Column(
          children: [
            Constant.sbHTwenty,
            TextFormField(
              controller: _nomineeNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Nominee Name'.tr,
                hintText: 'Enter Nominee name'.tr,
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter nominee name';
              //   }
              //   return null;
              // },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _nomineeRelationController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Relationship'.tr,
                hintText: 'Enter your relation with nominee'.tr,
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter your relation with nominee';
              //   }
              //   return null;
              // },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _nomineePhoneNumberController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Nominee Phone Number'.tr,
                hintText: 'Enter Nominee Phone Number'.tr,
              ),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'Please enter nominee phone number';
              //   }
              //   return null;
              // },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _nomineeNidNumberController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Nominee NID Number'.tr,
                hintText: 'Enter Nominee NID Number'.tr,
              ),
              // validator: (value) {
              //   if (value != null || value.isEmpty) {
              //     return 'Please enter nominee NID number';
              //   }
              //   return null;
              // },
            ),
            Constant.sbHFifteen,
          ],
        ),
      ),
    );
  }

  Container bankDetailsFrom() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKeyForBankDetails,
        child: Column(
          children: [
            Constant.sbHFifteen,
            TextFormField(
              controller: _bankNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Bank Name'.tr,
                hintText: 'Enter your Bank Name'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your bank name'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _bankBranchNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Bank Branch Name'.tr,
                hintText: 'Enter your Bank Branch Name'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your bank branch name'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _accountHolderNameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Account Holder Name'.tr,
                hintText: 'Enter your Account Holder Name'.tr,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your account holder name'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
            TextFormField(
              controller: _accountNumberController,
              obscureText: _obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Account Number'.tr,
                hintText: 'Enter your Account Number'.tr,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your account number'.tr;
                }
                return null;
              },
            ),
            Constant.sbHFifteen,
          ],
        ),
      ),
    );
  }

  void uploadPersonalInfos() {
    profileController
        .updateInvestorPersonalInfo(
      name: _fullNameController.text,
      phoneNumber: _phoneNumberController.text,
      email: _emailController.text,
      password: _passwordController.text,
      address: _addressController.text,
      nidNUmber: _nidController.text,
    )
        .then((value) {
      MoreController moreController = Get.put(MoreController());
      moreController.isPersonalDetailsComplete();
    });
  }

 

  

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    _nidController.dispose();
    _bankNameController.dispose();
    _bankBranchNameController.dispose();
    _accountHolderNameController.dispose();
    _accountNumberController.dispose();
    _nomineeNameController.dispose();
    _nomineeRelationController.dispose();
    _nomineePhoneNumberController.dispose();
    _nomineeNidNumberController.dispose();
    profileController.isProfileComplete();
    super.dispose();
  }

  void _goToNextStep() {
    if (_currentStep == 0 &&
        _formKeyForPersonalDetails.currentState!.validate()) {
      uploadPersonalInfos();
      setState(() {
        _currentStep < _formSteps.length - 1
            ? _currentStep++
            : _currentStep = 0;
      });
    } 
  }

  void _goToPreviousStep() {
    setState(() {
      // _currentStep == 0
      //     ? _currentStep = _formSteps.length - 1
      //     : _currentStep > 0
      //         ? _currentStep--
      //         : _currentStep = _formSteps.length - 1;
      _currentStep > 0 ? _currentStep-- : _currentStep = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondary,
        title: Text('Complete Profile'.tr),
      ),
      body: Column(
        children: [
          LinearProgressIndicator(
            value: (_currentStep + 1) / _formSteps.length,
            color: AppColor.secondary,
            backgroundColor: Colors.grey.shade300,
          ),
          Expanded(
            child: Stepper(
              currentStep: _currentStep,
              steps: _formSteps,
              onStepContinue: _goToNextStep,
              onStepCancel: _goToPreviousStep,
              controlsBuilder: (BuildContext context, ControlsDetails details) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (details.onStepCancel != null)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          onPressed: details.onStepCancel,
                          child: Text('Back'.tr),
                        ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: details.onStepContinue,
                        child: _currentStep == _formSteps.length - 1
                            ? Text('Submit'.tr)
                            : Text('Next'.tr),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
