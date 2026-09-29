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
import '../friends/friends_endpoint.dart' as _i4;
import '../greetings/greeting_endpoint.dart' as _i5;
import '../history/workout_history_endpoint.dart' as _i6;
import '../progress/progress_endpoint.dart' as _i7;
import '../schedule/training_schedule_endpoint.dart' as _i8;
import 'package:backend_server/src/generated/history/workout_record_dto.dart'
    as _i9;
import 'package:backend_server/src/generated/schedule/training_schedule_dto.dart'
    as _i10;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i11;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i12;

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
      'friends': _i4.FriendsEndpoint()
        ..initialize(
          server,
          'friends',
          null,
        ),
      'greeting': _i5.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'workoutHistory': _i6.WorkoutHistoryEndpoint()
        ..initialize(
          server,
          'workoutHistory',
          null,
        ),
      'progress': _i7.ProgressEndpoint()
        ..initialize(
          server,
          'progress',
          null,
        ),
      'trainingSchedule': _i8.TrainingScheduleEndpoint()
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
            'utcOffsetMinutes': _i1.ParameterDescription(
              name: 'utcOffsetMinutes',
              type: _i1.getType<int?>(),
              nullable: true,
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
                    utcOffsetMinutes: params['utcOffsetMinutes'],
                  ),
        ),
      },
    );
    connectors['friends'] = _i1.EndpointConnector(
      name: 'friends',
      endpoint: endpoints['friends']!,
      methodConnectors: {
        'createInvite': _i1.MethodConnector(
          name: 'createInvite',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['friends'] as _i4.FriendsEndpoint)
                  .createInvite(session),
        ),
        'redeemInvite': _i1.MethodConnector(
          name: 'redeemInvite',
          params: {
            'code': _i1.ParameterDescription(
              name: 'code',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['friends'] as _i4.FriendsEndpoint).redeemInvite(
                    session,
                    params['code'],
                  ),
        ),
        'list': _i1.MethodConnector(
          name: 'list',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['friends'] as _i4.FriendsEndpoint).list(session),
        ),
        'accept': _i1.MethodConnector(
          name: 'accept',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['friends'] as _i4.FriendsEndpoint).accept(
                session,
                params['userId'],
              ),
        ),
        'decline': _i1.MethodConnector(
          name: 'decline',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['friends'] as _i4.FriendsEndpoint).decline(
                session,
                params['userId'],
              ),
        ),
        'remove': _i1.MethodConnector(
          name: 'remove',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['friends'] as _i4.FriendsEndpoint).remove(
                session,
                params['userId'],
              ),
        ),
        'setSharing': _i1.MethodConnector(
          name: 'setSharing',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'stats': _i1.ParameterDescription(
              name: 'stats',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'history': _i1.ParameterDescription(
              name: 'history',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['friends'] as _i4.FriendsEndpoint).setSharing(
                    session,
                    params['userId'],
                    stats: params['stats'],
                    history: params['history'],
                  ),
        ),
        'getProgress': _i1.MethodConnector(
          name: 'getProgress',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'period': _i1.ParameterDescription(
              name: 'period',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['friends'] as _i4.FriendsEndpoint).getProgress(
                    session,
                    params['userId'],
                    period: params['period'],
                  ),
        ),
        'getHistory': _i1.MethodConnector(
          name: 'getHistory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['friends'] as _i4.FriendsEndpoint).getHistory(
                    session,
                    params['userId'],
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
              ) async => (endpoints['greeting'] as _i5.GreetingEndpoint).hello(
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
                  (endpoints['workoutHistory'] as _i6.WorkoutHistoryEndpoint)
                      .list(session),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'record': _i1.ParameterDescription(
              name: 'record',
              type: _i1.getType<_i9.WorkoutRecordDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['workoutHistory'] as _i6.WorkoutHistoryEndpoint)
                      .save(
                        session,
                        params['record'],
                      ),
        ),
      },
    );
    connectors['progress'] = _i1.EndpointConnector(
      name: 'progress',
      endpoint: endpoints['progress']!,
      methodConnectors: {
        'get': _i1.MethodConnector(
          name: 'get',
          params: {
            'period': _i1.ParameterDescription(
              name: 'period',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'utcOffsetMinutes': _i1.ParameterDescription(
              name: 'utcOffsetMinutes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['progress'] as _i7.ProgressEndpoint).get(
                session,
                period: params['period'],
                utcOffsetMinutes: params['utcOffsetMinutes'],
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
                          as _i8.TrainingScheduleEndpoint)
                      .get(session),
        ),
        'save': _i1.MethodConnector(
          name: 'save',
          params: {
            'schedule': _i1.ParameterDescription(
              name: 'schedule',
              type: _i1.getType<_i10.TrainingScheduleDto>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['trainingSchedule']
                          as _i8.TrainingScheduleEndpoint)
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
                          as _i8.TrainingScheduleEndpoint)
                      .delete(session),
        ),
      },
    );
    modules['serverpod_auth_core'] = _i11.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _i12.Endpoints()
      ..initializeEndpoints(server);
  }
}
