import 'dart:io';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nudge/core/extension/extensions.dart';
import 'package:nudge/features/onboarding/presentation/controllers/onboarding_controller.dart';

class UploadPhotoScreen extends StatefulWidget {
  const UploadPhotoScreen({super.key});

  @override
  State<UploadPhotoScreen> createState() => _UploadPhotoScreenState();
}

class _UploadPhotoScreenState extends State<UploadPhotoScreen> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final controller = Get.find<OnboardingController>();

    Future<XFile> cropImage(XFile pickedImage) async {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.primary400,
            toolbarWidgetColor: Colors.white,
            aspectRatioPresets: [
              CropAspectRatioPreset.ratio16x9,
              CropAspectRatioPreset.square,
            ],
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
            ],
          ),
        ],
      );
      if (croppedFile == null) {
        return pickedImage;
      } else {
        return XFile(croppedFile.path);
      }
    }

    Future<void> captureImage() async {
      UiHelper.showloaderdialog(context);
      var photo = await picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        photo = await cropImage(photo);
        setState(() {
          controller.selectedImage.value = photo;
        });
      }
      Navigator.pop(Get.overlayContext!);
    }

    return WillPopScope(
      onWillPop: () async {
        controller.moveToPreviousPage();
        return false;
      },
      child: AppGradientScaffold(
        backgroundColor: AppColors.white,
        child: Scaffold(
          backgroundColor: AppColors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  VerticalSpacing(10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Upload a Live Photo',
                        style: context.text.displaySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.color120D26,
                        ),
                      ),
                      VerticalSpacing(12),
                      Text(
                        'For security and authenticity, please take a live photo of yourself. Gallery uploads are not allowed. This helps ensure real, meaningful connections.',
                        style: context.text.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.neutral600,
                        ),
                      ),
                      VerticalSpacing(30),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            captureImage();
                          },
                          child: Container(
                            height: 167,
                            width: 167,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(color: AppColors.colorE7E9EC),
                            ),
                            child: Obx(() {
                              final selectedImage =
                                  controller.selectedImage.value;
                              if (selectedImage != null) {
                                return ClipOval(
                                  child: Image.file(
                                    File(selectedImage.path),
                                    width: 167,
                                    height: 167,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(60),
                                  // adjust padding to control icon size
                                  child: SvgPicture.asset(
                                    Assets.images.galleryAdd.path,
                                    fit: BoxFit.contain,
                                  ),
                                );
                              }
                            }),
                          ),
                        ),
                      ),
                      VerticalSpacing(30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Obx(
                            () => Center(
                              child: AppOutlinedButtonWithArrow(
                                onPressed:
                                    controller.isFormValid.value
                                        ? () {
                                          controller.moveToNextPage(
                                            controller
                                                .pageController
                                                .value
                                                .page!
                                                .toInt(),
                                          );
                                        }
                                        : null,
                                isLoading: false,
                                backgroundColor: AppColors.purpleButton,
                                textColor: Colors.green,
                                text: 'CONTINUE',
                                textStyle: context.text.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.white,
                                ),
                                height: 58,
                                width: 271,
                              ),
                            ),
                          ),
                          VerticalSpacing(30),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed(AppRoutes.loginPage);
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8),
                                child: RichText(
                                  text: TextSpan(
                                    style: context.text.titleMedium?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.color120D26,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: 'Already have an account? ',
                                      ),
                                      TextSpan(
                                        text: 'Sign In',
                                        style: context.text.titleMedium
                                            ?.copyWith(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.signupTextBtn,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
