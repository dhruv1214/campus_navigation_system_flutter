import 'package:flutter/material.dart';

class DonateForm extends StatefulWidget {
  const DonateForm({Key? key}) : super(key: key);

  static const String routeName = '/donate';

  @override
  _DonateFormState createState() => _DonateFormState();
}

class _DonateFormState extends State<DonateForm> {
  final _detailsFormKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  final _paymentFormKey = GlobalKey<FormState>();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  static const _decoration = InputDecoration(
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(10)),
    ),
    contentPadding: EdgeInsets.all(10),
    fillColor: Colors.white,
    filled: true,
  );

  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  void onClickNext() {
    if (_currentStep == 0) {
      if (_detailsFormKey.currentState!.validate()) {
        setState(() {
          _currentStep++;
        });
      }
    } else if (_currentStep == 1) {
      if (_addressFormKey.currentState!.validate()) {
        setState(() {
          _currentStep++;
        });
      }
    } else if (_currentStep == 2) {
      if (_paymentFormKey.currentState!.validate()) {
        onFormVerified();
      }
    }
  }

  void onFormVerified() {
    // Thank you dialog with amount donated
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Thank you!'),
          content: Text('You donated \$${_amountController.text}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donate'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Stepper(
            currentStep: _currentStep,
            physics: const BouncingScrollPhysics(),
            controlsBuilder: (context, controlDetail) {
              return Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: controlDetail.onStepContinue,
                      child: const Text('Next'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: controlDetail.onStepCancel,
                      child: const Text('Back'),
                    ),
                  ],
                ),
              );
            },
            onStepContinue: onClickNext,
            onStepCancel: () {
              setState(() {
                if (_currentStep > 0) {
                  _currentStep--;
                } else {
                  _currentStep = 0;
                }
              });
            },
            steps: [
              Step(
                title: const Text('Details'),
                content: Form(
                  key: _detailsFormKey,

                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: _decoration.copyWith(
                                labelText: 'First Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }

                                if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                  return 'Please enter a valid name';
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: _decoration.copyWith(
                                labelText: 'Last Name',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                
                                if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                  return 'Please enter a valid name';
                                }

                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: _decoration.copyWith(
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }

                          if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _amountController,
                        decoration: _decoration.copyWith(
                          labelText: 'Amount',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }

                          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Please enter a valid amount';
                          }

                          return null;
                        },
                      ),
                      // Add more personal details fields here
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Address'),
                content: Form(
                  key: _addressFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _addressController,
                        decoration: _decoration.copyWith(
                          labelText: 'Address',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _cityController,
                              decoration: _decoration.copyWith(
                                labelText: 'City',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your city';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _stateController,
                              decoration: _decoration.copyWith(
                                labelText: 'State',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your state';
                                }



                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _zipController,
                        decoration: _decoration.copyWith(
                          labelText: 'Postal Code',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your postal code';
                          }

                          //check for canadian postal code
                          if (!RegExp(r'^[A-Za-z]\d[A-Za-z][ -]?\d[A-Za-z]\d$')
                              .hasMatch(value)) {
                            return 'Please enter a valid postal code';
                          }
                          return null;
                        },
                      ),
                      // Add more address fields here
                    ],
                  ),
                ),
              ),
              Step(
                title: const Text('Payment Info'),
                content: Form(
                  key: _paymentFormKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _cardNumberController,
                        decoration: _decoration.copyWith(
                          labelText: 'Card Number',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your card number';
                          }

                          if(!RegExp(r'^[0-9]+$').hasMatch(value)){
                            return 'Please enter a valid card number';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _cardHolderController,
                        decoration: _decoration.copyWith(
                          labelText: 'Card Holder',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the card holder name';
                          }

                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                            return 'Please enter a valid name';
                          }

                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _expiryDateController,
                              decoration: _decoration.copyWith(
                                labelText: 'Expiry Date',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the expiry date';
                                }

                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Please enter a valid expiry date';
                                }

                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _cvvController,
                              decoration: _decoration.copyWith(
                                labelText: 'CVV',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the CVV';
                                }

                                if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                  return 'Please enter a valid CVV';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      // Add more payment info fields here
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
