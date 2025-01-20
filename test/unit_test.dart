import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  group("Tiger class test", () {
    group("Initialization and property tests", () {
      test("should create an instance of Tiger", () {
        final tiger = Tiger(name: "tiger", age: 10);
        expect(tiger, isA<Tiger>());
      });

      test("should have correct properties", () {
        final tiger = Tiger(name: "tiger", age: 10);
        expect(tiger.name, "tiger");
        expect(tiger.age, 10);
      });

      test("should allow nullable properties", () {
        final tiger = Tiger(name: null, age: null);
        expect(tiger.name, isNull);
        expect(tiger.age, isNull);
      });

      test("should maintain equality based on properties", () {
        final tiger1 = Tiger(name: "tiger", age: 10);
        final tiger2 = Tiger(name: "tiger", age: 10);
        final tiger3 = Tiger(name: "other", age: 5);

        expect(tiger1, equals(tiger2));
        expect(tiger1, isNot(equals(tiger3)));
      });
    });

    group("Behavioral tests", () {
      late MockLogger mockLogger;

      setUp(() {
        mockLogger = MockLogger();
      });

      test("should print 'jump' when jump is called", () {
        final tiger = Tiger(name: "tiger", age: 10, logger: mockLogger);
        tiger.jump();
        verify(mockLogger.log("jump"));
      });

      test("should print 'run' when run is called", () {
        final tiger = Tiger(name: "tiger", age: 10, logger: mockLogger);
        tiger.run();
        verify(mockLogger.log("run"));
      });

      test("should print 'swim' when swim is called", () {
        final tiger = Tiger(name: "tiger", age: 10, logger: mockLogger);
        tiger.swim();
        verify(mockLogger.log("swim"));
      });

      //   test("should not call any logger method without an action", () {
      //     final tiger = Tiger(name: "tiger", age: 10, logger: mockLogger);
      //     verifyNever(mockLogger.log(any));
      //   });
    });

    group("Edge cases", () {
      test("should handle large age values", () {
        final tiger = Tiger(name: "Ancient Tiger", age: 999999);
        expect(tiger.age, 999999);
      });

      test("should handle empty name", () {
        final tiger = Tiger(name: "", age: 5);
        expect(tiger.name, "");
      });

      test("should handle special characters in name", () {
        final tiger = Tiger(name: "Tïgêr#42!", age: 7);
        expect(tiger.name, "Tïgêr#42!");
      });
    });
  });
}

class DefaultLogger implements Logger {
  @override
  void log(String message) => print(message);
}

abstract class Logger {
  void log(String message);
}

class MockLogger extends Mock implements Logger {}

class Tiger extends Equatable {
  final String? name;
  final int? age;
  final Logger logger;

  Tiger({this.name, this.age, Logger? logger})
      : logger = logger ?? DefaultLogger();

  @override
  List<Object?> get props => [name, age];

  void jump() => logger.log("jump");
  void run() => logger.log("run");
  void swim() => logger.log("swim");
}
