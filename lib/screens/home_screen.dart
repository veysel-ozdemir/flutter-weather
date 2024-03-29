import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/bloc/weather_bloc_bloc.dart';
import 'package:weatherapp/utils/utils.dart';
import 'package:weatherapp/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String greetingMessage(int time) {
    switch (time) {
      case >= 5 && <= 9:
        return 'Good Morning';
      case >= 10 && <= 13:
        return 'Good Day';
      case >= 14 && <= 17:
        return 'Good Afternoon';
      case >= 18 && <= 23:
      case >= 0 && <= 4:
        return 'Good Night';
      default:
        return '';
    }
  }

  Widget weatherIcon(int code) {
    switch (code) {
      case >= 200 && <= 232:
        return Image.asset('assets/thunderstorm.png');
      case >= 300 && <= 321:
        return Image.asset('assets/drizzle.png');
      case >= 500 && <= 531:
        return Image.asset('assets/rain.png');
      case >= 600 && <= 622:
        return Image.asset('assets/snow.png');
      case >= 701 && <= 762:
        return Image.asset('assets/fog.png');
      case 771:
      case 781:
        return Image.asset('assets/wind.png');
      case 800:
        return Image.asset('assets/clear.png');
      case 801:
      case 802:
        return Image.asset('assets/partly_cloudy.png');
      case 803:
      case 804:
        return Image.asset('assets/cloud.png');
      default:
        return Image.asset('assets/clear.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: deviceSize.height,
          child: Stack(
            children: [
              const HomeScreenBackground(),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  return state is WeatherBlocSuccess
                      ? SizedBox(
                          height: deviceSize.height,
                          width: deviceSize.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📍 ${state.weather.areaName}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              const Gap(8),
                              Text(
                                greetingMessage(
                                  int.parse(
                                    DateFormat.H().format(state.weather.date!),
                                  ),
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              weatherIcon(state.weather.weatherConditionCode!),
                              Center(
                                child: Text(
                                  '${state.weather.temperature!.celsius!.round()}°C',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 55,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  state.weather.weatherMain!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Gap(5),
                              Center(
                                child: Center(
                                  child: Text(
                                    DateFormat('EEEE dd  |  ')
                                        .add_jm()
                                        .format(state.weather.date!),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              const Gap(30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/day.png',
                                        scale: 8,
                                      ),
                                      const Gap(5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Sunrise',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const Gap(3),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunrise!),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/night.png',
                                        scale: 8,
                                      ),
                                      const Gap(5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Sunset',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const Gap(3),
                                          Text(
                                            DateFormat()
                                                .add_jm()
                                                .format(state.weather.sunset!),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 0.5),
                                child: Divider(
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/max_temp.png',
                                        scale: 8,
                                      ),
                                      const Gap(5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Temp Max',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const Gap(3),
                                          Text(
                                            '${state.weather.tempMax!.celsius!.round()}°C',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/min_temp.png',
                                        scale: 8,
                                      ),
                                      const Gap(5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Temp Min',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          const Gap(3),
                                          Text(
                                            '${state.weather.tempMin!.celsius!.round()}°C',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
