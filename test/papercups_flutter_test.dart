import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:papercups_flutter/models/models.dart';
import 'package:papercups_flutter/utils/utils.dart';

import 'package:flutter_test/flutter_test.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  final props = Props(accountId: 'account_id');
  final customer = PapercupsCustomer();
  group("Props", () {
    Props props;
    test('default values', () {
      props = Props(
        accountId: "this-is-an-account-id",
      );

      expect(props.accountId, "this-is-an-account-id");
      //expect(props.agentAvailableText, null);
      expect(props.baseUrl, "app.papercups.io");
      //expect(props.agentUnavailableText, null);
      expect(props.companyName, "Bot");
      expect(props.newMessagePlaceholder, "Start typing...");
      expect(props.primaryColor, null);
      expect(props.requireEmailUpfront, false);
      expect(props.scrollEnabled, true);
      expect(props.customer, null);
      expect(props.primaryGradient, null);
      expect(props.subtitle, "How can we help you?");
      expect(props.title, "Welcome!");
      expect(props.greeting, null);
    });
    test('are loaded correctly', () {
      props = Props(
          accountId: "this-is-an-account-id",
          //agentAvailableText: "test",
          //agentUnavailableText: "unavailable",
          baseUrl: "app.papercups.io",
          companyName: "name",
          greeting: "greeting",
          newMessagePlaceholder: "placeHolder",
          primaryColor: Color(0xffffff),
          requireEmailUpfront: true,
          scrollEnabled: true,
          customer: CustomerMetadata());

      expect(props.accountId, "this-is-an-account-id");
      //expect(props.agentAvailableText, "test");
      expect(props.baseUrl, "app.papercups.io");
      //expect(props.agentUnavailableText, "unavailable");
      expect(props.companyName, "name");
      expect(props.newMessagePlaceholder, "placeHolder");
      expect(props.primaryColor, Color(0xffffff));
      expect(props.requireEmailUpfront, true);
      expect(props.scrollEnabled, true);
      expect(props.customer.toJsonString(),
          '{"name":null,"email":null,"external_id":null}');
      expect(props.primaryGradient, null);
      expect(props.subtitle, "How can we help you?");
      expect(props.title, "Welcome!");
      expect(props.greeting, "greeting");
    });
  });

  group("Customer Metadata", () {
    CustomerMetadata cm;
    test('default values', () {
      cm = CustomerMetadata();

      expect(cm.email, null);
      expect(cm.externalId, null);
      expect(cm.name, null);
      expect(cm.otherMetadata, null);
      expect(
          cm.toJsonString(), '{"name":null,"email":null,"external_id":null}');
    });
    test('are loaded correctly', () {
      cm = CustomerMetadata(
          email: "test@test.com",
          externalId: "1234",
          name: "name",
          otherMetadata: {
            "Test": "string",
          });

      expect(cm.email, "test@test.com");
      expect(cm.externalId, "1234");
      expect(cm.name, "name");
      expect(cm.otherMetadata, {"Test": "string"});
      expect(cm.toJsonString(),
          '{"name":"name","email":"test@test.com","external_id":"1234","Test":"string"}');
    });
  });
  group('Theming', () {
    group("darken", () {
      test('throws assertion error when percent is not within 1 - 100 ', () {
        expect(() => darken(Colors.black, 0), throwsAssertionError);
      });

      test('Darkens the color by 10%', () {
        final color = Color.fromARGB(100, 100, 100, 100);
        final darkenedColor = darken(color, 10);
        expect(darkenedColor.alpha, equals(100));
        expect(darkenedColor.red, equals(90));
        expect(darkenedColor.blue, equals(90));
        expect(darkenedColor.green, equals(90));
      });
    });

    group("brighten", () {
      test('throws assertion error when percent is not within 1 - 100 ', () {
        expect(() => brighten(Colors.black, 101), throwsAssertionError);
      });

      test('Brightens the color by 10%', () {
        final color = Color.fromARGB(155, 155, 155, 155);
        final brightenedColor = brighten(color, 10);
        expect(brightenedColor.alpha, equals(155));
        expect(brightenedColor.red, equals(165));
        expect(brightenedColor.blue, equals(165));
        expect(brightenedColor.green, equals(165));
      });
    });
  });

  group('getConversationDetails', () {
    final conv = Conversation(
      accountId: 'account_id',
      asigneeId: 'asignee_id',
      createdAt: '2020-09-30',
      customerId: 'customer_id',
      id: 'id',
      priority: 'important',
      read: true,
    );

    test('returns Converation object on success', () async {
      final client = MockClient();
      final testResponse = jsonEncode({
        "data": {
          "id": conv.id,
          "customer_id": conv.customerId,
          "account_id": conv.accountId,
          "asignee_id": conv.asigneeId,
          "created_at": conv.createdAt,
          "read": conv.read,
        }
      });
      Conversation newConv;
      void sc(Conversation conv) {
        newConv = conv;
      }

      when(
        client.post(
          'https://${props.baseUrl}/api/conversations',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(testResponse, 200));

      final details = await getConversationDetails(
        props,
        Conversation(),
        customer,
        sc,
        client: client,
      );

      verify(
        client.post(
          'https://${props.baseUrl}/api/conversations',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).called(1);
      verify(client.close()).called(1);

      expect(newConv, equals(details),
          reason:
              'the conversation object returned should match the arguement passed to sc');
      expect(details.id, equals(conv.id));
      expect(details.accountId, equals(conv.accountId));
    });

    test("returns null when there's an error", () async {
      final client = MockClient();
      when(
        client.post(
          'https://${props.baseUrl}/api/conversations',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenThrow(HttpException('Request failed'));

      final details = await getConversationDetails(
        props,
        Conversation(),
        customer,
        () => {},
        client: client,
      );

      verify(
        client.post(
          'https://${props.baseUrl}/api/conversations',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).called(1);
      verify(client.close()).called(1);

      expect(details, equals(null));
    });
  });
}
