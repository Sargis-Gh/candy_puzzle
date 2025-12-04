import 'package:candy_puzzle/core/theme/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/widgets/game_background.dart';
import '../../core/theme/app_colors.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _validateInput(String value) {
    setState(() {
      _isValid = value.trim().isNotEmpty;
    });
  }

  Future<void> _saveUsername() async {
    if (!_isValid) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _controller.text.trim());
    await prefs.setBool('isFirstLaunch', false);

    if (mounted) {
      context.go('/menu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.img6),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 38),
                padding: const EdgeInsets.only(
                  top: 25,
                  left: 25,
                  right: 25,
                  bottom: 70,
                ),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.nameBackground),
                    fit: BoxFit.contain,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      'Enter your name',
                      style: TextStyle(
                        fontSize: 35.27,
                        fontWeight: FontWeight.w600,
                        color: AppColors.background,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      height: 58,
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: AppColors.grayBackground,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: TextField(
                          cursorColor: AppColors.background,
                          cursorHeight: 30,
                          controller: _controller,
                          onChanged: _validateInput,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: AppColors.background.withValues(alpha: 0.5),
                          ),
                          decoration: InputDecoration(
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w600,
                              color: AppColors.background.withValues(
                                alpha: 0.5,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              GestureDetector(
                onTap: _isValid ? _saveUsername : () {},
                child: SizedBox(
                  width: 164,
                  height: 68,
                  child: Image.asset(AppAssets.nextButton),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
