/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/jwt_refresh_endpoint.dart' as _i2;
import '../auth/telegram_auth_endpoint.dart' as _i3;
import '../greetings/greeting_endpoint.dart' as _i4;
import '../history/workout_history_endpoint.dart' as _i5;
import '../schedule/training_schedule_endpoint.dart' as _i6;
import 'package:backend_server/src/generated/history/workout_record_dto.dart'
    as _i7;
import 'package:backend_server/src/generated/schedule/training_schedule_dto.dart'
    as _i8;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i9;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i10;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'jwtRefresh': _i2.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'telegramAuth': _i3.TelegramAuthEndpoint()
        ..initialize(
          server,
          'telegramAuth',
          null,
        ),
      'greeting': _i4.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'workoutHistory': _i5.WorkoutHistoryEndpoint()
        ..initialize(
          server,
          'workoutHistory',
          null,
        ),
      'trainingSchedule': _i6.TrainingScheduleEndpoint()
        ..initialize(
          server,
          'trainingSchedule',
          null,
        ),
    };
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i2.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['telegramAuth'] = _i1.EndpointConnector(
      name: 'telegramAuth',
      endpoint: endpoints['telegramAuth']!,
      methodConnectors: {
        'authenticate': _i1.MethodConnector(
          name: 'authenticate',
          params: {
            'initData': _i1.ParameterDescription(
              name: 'initData',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['telegramAuth'] as _i3.TelegramAuthEndpoint)
                  .authenticate(
                    session,
                    params['initData'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i4.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    connectors['workoutHistory'] = _i1.EndpointConnector(
      name: 'workoutHistory',
      endpoint: endpoints['workoutHistory']!,
      methodConnectors: {
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workoutHistory'] as _i5.WorkoutHistoryEndpoint)
                      .list(session),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'record': _i1.ParameterDescription(
              name: 'record',
              type: _i1.getType<_i7.WorkoutRecordDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workoutHistory'] as _i5.WorkoutHistoryEndpoint)
                      .save(
                        session,
                        params['record'],
                      ),
        ),
      },
    );
    connectors['trainingSchedule'] = _i1.EndpointConnector(
      name: 'trainingSchedule',
      endpoint: endpoints['trainingSchedule']!,
      methodConnectors: {
        'get': _i1.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingSchedule']
                          as _i6.TrainingScheduleEndpoint)
                      .get(session),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'schedule': _i1.ParameterDescription(
              name: 'schedule',
              type: _i1.getType<_i8.TrainingScheduleDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingSchedule']
                          as _i6.TrainingScheduleEndpoint)
                      .save(
                        session,
                        params['schedule'],
                      ),
        ),
        'delete': _i1.MethodConnector(
          name: 'delete',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingSchedule']
                          as _i6.TrainingScheduleEndpoint)
                      .delete(session),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i9.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i10.Endpoints()
      ..initializeEndpoints(server);
  }
}
