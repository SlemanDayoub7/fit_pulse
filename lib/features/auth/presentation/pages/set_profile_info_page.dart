import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gym_app/core/helpers/validators.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/core/theme/app_text.dart';
import 'package:gym_app/core/widgets/app_button.dart';
import 'package:gym_app/core/widgets/custom_text_field.dart';
import 'package:gym_app/core/widgets/generic_refresh_indicator.dart';
import 'package:gym_app/features/auth/data/models/response_models/user_profile_model.dart';
import 'package:gym_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:gym_app/generated/codegen_loader.g.dart';
import 'package:gym_app/core/constants/shared_pref_keys.dart';
// Import your SharedPrefHelper
import 'package:gym_app/core/helpers/shared_pref_helper.dart';

class SetProfileInfoPage extends StatefulWidget {
  const SetProfileInfoPage({Key? key}) : super(key: key);

  @override
  State<SetProfileInfoPage> createState() => _SetProfileInfoPageState();
}

class _SetProfileInfoPageState extends State<SetProfileInfoPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _goalWeightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  Uint8List? _userImageBytes;
  final ImagePicker _picker = ImagePicker();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(GetProfileInfo());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    _loadUserImage();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _weightController.dispose();
    _goalWeightController.dispose();
    _heightController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadUserImage() async {
    Uint8List? savedImageBytes = await SharedPrefHelper.getUserProfileImage();
    if (savedImageBytes != null) {
      setState(() {
        _userImageBytes = savedImageBytes;
      });
    }
  }

  Future<void> _pickUserImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final bytes = await imageFile.readAsBytes();
      await SharedPrefHelper.saveUserProfileImage(imageFile);
      setState(() {
        _userImageBytes = bytes;
      });
    }
  }

  Widget _buildUserImageWidget() {
    return Center(
      child: InkWell(
        onTap: _pickUserImage,
        child: ClipOval(
          child: _userImageBytes == null
              ? Container(
                  width: 150.r,
                  height: 150.r,
                  color: Colors.grey[300],
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(Icons.camera_alt,
                          size: 100.r, color: Colors.white70),
                    ],
                  ),
                )
              : Image.memory(
                  _userImageBytes!,
                  width: 150.r,
                  height: 150.r,
                  fit: BoxFit.cover,
                ),
        ),
      ),
    );
  }

  void _updateProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthBloc>().add(UpdateProfileInfoEvent(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            weight: _weightController.text,
            goalWeight: _goalWeightController.text,
            height: int.parse(_heightController.text),
          ));
    }
  }

  void _populateControllers(UserProfileModel userProfile) {
    _firstNameController.text = userProfile.firstName ?? '';
    _lastNameController.text = userProfile.lastName ?? '';
    _weightController.text = (userProfile.weight?.toInt()).toString() ?? '';
    _goalWeightController.text =
        (userProfile.goalWeight?.toInt()).toString() ?? '';
    _heightController.text = (userProfile.height?.toInt()).toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GenericRefreshIndicator(
      onRefresh: () async {
        context.read<AuthBloc>().add(GetProfileInfo());
      },
      builder: (context) {
        return BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is ProfileInfoUpdated) {
              _populateControllers(state.userProfileModel);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم تحديث الملف الشخصي بنجاح')),
              );
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is GetProfileInfoSuccess) {
              _populateControllers(state.userProfileModel);
            }
          },
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 20.h),
                          _buildUserImageWidget(),
                          SizedBox(height: 20.h),
                          CustomTextField(
                            controller: _firstNameController,
                            hintText: LocaleKeys.first_name.tr(),
                            validator: Validator.firstNameValidator,
                          ),
                          SizedBox(height: 15.h),
                          CustomTextField(
                            controller: _lastNameController,
                            hintText: LocaleKeys.last_name.tr(),
                            validator: Validator.lastNameValidator,
                          ),
                          SizedBox(height: 15.h),
                          CustomTextField(
                            controller: _weightController,
                            hintText: LocaleKeys.weight.tr(),
                            validator: Validator.weightValidator,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 15.h),
                          CustomTextField(
                            controller: _goalWeightController,
                            hintText: LocaleKeys.target_weight.tr(),
                            validator: Validator.goalWeightValidator,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 15.h),
                          CustomTextField(
                            controller: _heightController,
                            hintText: LocaleKeys.height.tr(),
                            validator: Validator.heightValidator,
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(height: 25.h),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              final isLoading = state is UpdatingProfileInfo ||
                                  state is AuthLoading;
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                                height: 50.h,
                                child: AppButton(
                                  title: LocaleKeys.update.tr(),
                                  enabled: !isLoading,
                                  onPressed: _updateProfile,
                                  child: isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 3,
                                          ),
                                        )
                                      : null,
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
