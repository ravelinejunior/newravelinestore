import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newravelinestore/src/components/custom_text_field.dart';
import 'package:newravelinestore/src/utils/app_data.dart' as app_data;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final filteringPhone = [
      FilteringTextInputFormatter.digitsOnly,
      TelefoneInputFormatter()
    ];
    final filteringCpf = [
      FilteringTextInputFormatter.digitsOnly,
      CpfInputFormatter()
    ];
    final user = app_data.genUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        children: [
          CustomTextField(
            initialValue: user.email,
            icon: Icons.email,
            label: 'Email',
            inputAction: TextInputAction.next,
            readOnly: true,
          ),
          CustomTextField(
            initialValue: user.name,
            icon: Icons.person,
            label: 'Name',
            inputAction: TextInputAction.next,
          ),
          CustomTextField(
            initialValue: user.phone,
            icon: Icons.phone,
            label: 'Phone',
            inputFormatters: filteringPhone,
            inputAction: TextInputAction.next,
          ),
          CustomTextField(
            initialValue: user.cpf,
            icon: Icons.file_copy_outlined,
            label: 'CPF',
            inputFormatters: filteringCpf,
            inputAction: TextInputAction.done,
            readOnly: true,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.greenAccent,
              minimumSize: const Size(50, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(
                  color: Colors.teal,
                  style: BorderStyle.solid,
                  width: 1,
                ),
              ),
            ),
            onPressed: () async {
              await updatePassword(context);
            },
            child: Text(
              "Update Password",
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Password Update",
                  style: GoogleFonts.lato(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const CustomTextField(
                icon: Icons.lock_sharp,
                label: "Current Password",
                isSelected: true,
              ),
              const CustomTextField(
                icon: Icons.lock_outline,
                label: "New Password",
                isSelected: true,
              ),
              const CustomTextField(
                icon: Icons.lock_outline,
                label: "Confirm Password",
                isSelected: true,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shadowColor: Colors.greenAccent,
                  minimumSize: const Size(50, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: Colors.teal,
                      style: BorderStyle.solid,
                      width: 0.6,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                  "Confirm",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.teal,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                  shadowColor: Colors.white,
                  minimumSize: const Size(50, 36),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(
                      color: Colors.white,
                      style: BorderStyle.solid,
                      width: 0.6,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
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
