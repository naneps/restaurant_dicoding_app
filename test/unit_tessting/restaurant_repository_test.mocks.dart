// Mocks generated by Mockito 5.4.5 from annotations
// in restaurant_dicoding_app/test/unit_tessting/restaurant_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:http/http.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:restaurant_dicoding_app/services/restaurant_service.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeResponse_0 extends _i1.SmartFake implements _i2.Response {
  _FakeResponse_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [RestaurantService].
///
/// See the documentation for Mockito's code generation for more information.
class MockRestaurantService extends _i1.Mock implements _i3.RestaurantService {
  MockRestaurantService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl =>
      (super.noSuchMethod(
            Invocation.getter(#baseUrl),
            returnValue: _i4.dummyValue<String>(
              this,
              Invocation.getter(#baseUrl),
            ),
          )
          as String);

  @override
  set baseUrl(String? _baseUrl) => super.noSuchMethod(
    Invocation.setter(#baseUrl, _baseUrl),
    returnValueForMissingStub: null,
  );

  @override
  Map<String, String> get defaultHeaders =>
      (super.noSuchMethod(
            Invocation.getter(#defaultHeaders),
            returnValue: <String, String>{},
          )
          as Map<String, String>);

  @override
  bool get enableLogging =>
      (super.noSuchMethod(Invocation.getter(#enableLogging), returnValue: false)
          as bool);

  @override
  set enableLogging(bool? _enableLogging) => super.noSuchMethod(
    Invocation.setter(#enableLogging, _enableLogging),
    returnValueForMissingStub: null,
  );

  @override
  _i5.Future<_i2.Response> addReview({
    required String? id,
    dynamic name,
    dynamic review,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#addReview, [], {
              #id: id,
              #name: name,
              #review: review,
            }),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(
                this,
                Invocation.method(#addReview, [], {
                  #id: id,
                  #name: name,
                  #review: review,
                }),
              ),
            ),
          )
          as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> getRestaurant(String? id) =>
      (super.noSuchMethod(
            Invocation.method(#getRestaurant, [id]),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(this, Invocation.method(#getRestaurant, [id])),
            ),
          )
          as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> getRestaurants() =>
      (super.noSuchMethod(
            Invocation.method(#getRestaurants, []),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(this, Invocation.method(#getRestaurants, [])),
            ),
          )
          as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> searchRestaurants(String? value) =>
      (super.noSuchMethod(
            Invocation.method(#searchRestaurants, [value]),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(
                this,
                Invocation.method(#searchRestaurants, [value]),
              ),
            ),
          )
          as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> delete(
    String? endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #delete,
              [endpoint],
              {#headers: headers, #queryParameters: queryParameters},
            ),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(
                this,
                Invocation.method(
                  #delete,
                  [endpoint],
                  {#headers: headers, #queryParameters: queryParameters},
                ),
              ),
            ),
          )
          as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> get(
    String? endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #get,
              [endpoint],
              {#headers: headers, #queryParameters: queryParameters},
            ),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(
                this,
                Invocation.method(
                  #get,
                  [endpoint],
                  {#headers: headers, #queryParameters: queryParameters},
                ),
              ),
            ),
          )
          as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> post(
    String? endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #post,
              [endpoint],
              {
                #headers: headers,
                #body: body,
                #queryParameters: queryParameters,
              },
            ),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(
                this,
                Invocation.method(
                  #post,
                  [endpoint],
                  {
                    #headers: headers,
                    #body: body,
                    #queryParameters: queryParameters,
                  },
                ),
              ),
            ),
          )
          as _i5.Future<_i2.Response>);

  @override
  _i5.Future<_i2.Response> put(
    String? endpoint, {
    Map<String, String>? headers,
    dynamic body,
    Map<String, dynamic>? queryParameters,
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #put,
              [endpoint],
              {
                #headers: headers,
                #body: body,
                #queryParameters: queryParameters,
              },
            ),
            returnValue: _i5.Future<_i2.Response>.value(
              _FakeResponse_0(
                this,
                Invocation.method(
                  #put,
                  [endpoint],
                  {
                    #headers: headers,
                    #body: body,
                    #queryParameters: queryParameters,
                  },
                ),
              ),
            ),
          )
          as _i5.Future<_i2.Response>);
}
