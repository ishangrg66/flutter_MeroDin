import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mero_din_app/core/constants/api_constants.dart';
import 'package:mero_din_app/core/services/auth_service.dart';
import '../models/schedule_model.dart';

abstract class ScheduleRemoteDataSource {
  Future<List<ScheduleModel>> getSchedules();
  Future<void> addSchedule(ScheduleModel schedule);
}

class ScheduleRemoteDataSourceImpl implements ScheduleRemoteDataSource {
  final Dio dio;
  final AuthService authService;
  ScheduleRemoteDataSourceImpl(this.dio, this.authService);

  @override
  Future<void> addSchedule(ScheduleModel schedule) async {
    try {
      final token = authService.token ?? '';
      final payload = {
        "title": schedule.title,
        "endTime": schedule.endTime,
        "scheduleDate": schedule.scheduleDate,
        "scheduleTime": schedule.scheduleTime,
        "guest": schedule.guest,
        "priority": schedule.priority,
        "visibility": schedule.visibility,
        "description": schedule.description,
      };

      final response = await dio.post(
        '${ApiConstants.baseUrl}${ApiConstants.scheduleInfo}',
        data: payload,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('✅ Schedule added successfully: ${response.data}');
      } else {
        throw Exception(
          'Failed to add schedule (Status: ${response.statusCode})',
        );
      }
    } on DioException catch (dioError) {
      debugPrint(' Dio error: ${dioError.message}');
      if (dioError.response != null) {
        debugPrint('Response data: ${dioError.response?.data}');
        debugPrint('Status code: ${dioError.response?.statusCode}');
      }
      throw Exception('Failed to add schedule: ${dioError.message}');
    } catch (e) {
      debugPrint(' Unexpected error: $e');
      throw Exception('Failed to add schedule: $e');
    }
  }

  @override
  Future<List<ScheduleModel>> getSchedules() async {
    final token = authService.token ?? '';
    final payload = {
      "id": 0,
      "title": "string",
      "scheduleDateFrom": "2025-10-19T08:55:01.432Z",
      "scheduleDateTo": "2025-10-19T08:55:01.432Z",
    };
    final response = await dio.get(
      '${ApiConstants.baseUrl}${ApiConstants.getAllscheduleInfo}',
      // data: payload,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    if (response.statusCode == 200) {
      // Since response.data is a List, map it properly
      final List<dynamic> jsonList = response.data;
      return jsonList.map((e) => ScheduleModel.fromJson(e)).toList();
    }
    throw Exception('Failed to load schedules');
  }
}
