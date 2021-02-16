import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:papercups_flutter/models/models.dart';
import 'package:papercups_flutter/utils/utils.dart';

import 'package:flutter_test/flutter_test.dart';

import 'mocks.dart';

void main() {
  final props = Props(
    accountId: 'account_id',
    customer: CustomerMetadata(externalId: 'external_id'),
  );
  final customer = PapercupsCustomer(
    id: 'id',
    createdAt: parseDateFromUTC('2020-12-31T22:19:52.644532'),
    email: 'email@papercups.com',
    externalId: 'external_id',
    firstSeen: parseDateFromUTC('2021-01-08T22:19:52.644532'),
    lastSeen: parseDateFromUTC('2021-01-08T22:19:52.644532'),
    updatedAt: parseDateFromUTC('2021-01-08T22:19:52.644532'),
    name: 'name',
    phone: 'phone',
  );
  final message = PapercupsMessage(
    accountId: 'account_id',
    body: 'body',
    createdAt: parseDateFromUTC('2021-01-08T22:19:52.644532'),
    sentAt: parseDateFromUTC('2021-01-08T22:19:52.644532'),
  );

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
      final sc = MockSc();
      final res = jsonEncode({
        "data": {
          "id": conv.id,
          "customer_id": conv.customerId,
          "account_id": conv.accountId,
          "asignee_id": conv.asigneeId,
          "created_at": conv.createdAt,
          "read": conv.read,
        }
      });

      when(
        client.post(
          'https://${props.baseUrl}/api/conversations',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(res, 200));

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
      verify(sc(details)).called(1);

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

  group('getCustomerDetails', () {
    test('returns a Customer object on success', () async {
      final client = MockClient();
      final sc = MockSc();
      final res = jsonEncode({
        "data": {
          "id": customer.id,
          "email": customer.email,
          "external_id": customer.externalId,
          "created_at": customer.createdAt.toUtc().toIso8601String(),
          "first_seen": customer.firstSeen.toUtc().toIso8601String(),
          "last_seen": customer.lastSeen.toUtc().toIso8601String(),
          "updated_at": customer.updatedAt.toUtc().toIso8601String(),
          "name": customer.name,
          "phone": customer.phone,
        }
      });

      when(
        client.post(
          'https://${props.baseUrl}/api/customers',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenAnswer((_) async => http.Response(res, 200));

      final PapercupsCustomer c = await getCustomerDetails(
        props,
        customer,
        sc,
        client: client,
      );

      verify(
        client.post(
          'https://${props.baseUrl}/api/customers',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).called(1);
      verify(client.close()).called(1);

      expect(c.id, equals(customer.id));
      expect(c.lastSeen, equals(customer.lastSeen));
    });

    test("returns null when there's an error", () async {
      final client = MockClient();
      when(
        client.post(
          'https://${props.baseUrl}/api/customers',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).thenThrow(HttpException('Request failed'));

      final PapercupsCustomer c = await getCustomerDetails(
        props,
        customer,
        () => {},
        client: client,
      );

      verify(
        client.post(
          'https://${props.baseUrl}/api/customers',
          headers: anyNamed('headers'),
          body: anyNamed('body'),
        ),
      ).called(1);
      verify(client.close()).called(1);

      expect(c, equals(null));
    });
  });

  group('getCustomerDetailsFromMetadata', () {
    test('returns a Customer object on success', () async {
      final client = MockClient();
      final sc = MockSc();
      final res = jsonEncode({
        "data": {
          "customer_id": customer.id,
          "email": customer.email,
          "external_id": customer.externalId,
          "created_at": customer.createdAt.toIso8601String(),
          "first_seen": customer.firstSeen.toIso8601String(),
          "last_seen": customer.lastSeen.toIso8601String(),
          "updated_at": customer.updatedAt.toIso8601String(),
          "name": customer.name,
          "phone": customer.phone,
        }
      });

      when(
        client.get(
          Uri.https(
            props.baseUrl,
            "/api/customers/identify",
            {
              "external_id": customer.externalId,
              "account_id": props.accountId,
            },
          ),
        ),
      ).thenAnswer((_) async => http.Response(res, 200));

      final PapercupsCustomer c = await getCustomerDetailsFromMetadata(
        props,
        customer,
        sc,
        client: client,
      );

      verify(
        client.get(
          Uri.https(
            props.baseUrl,
            "/api/customers/identify",
            {
              "external_id": customer.externalId,
              "account_id": props.accountId,
            },
          ),
        ),
      ).called(1);
      verify(sc(c)).called(1);
      verify(client.close()).called(1);

      expect(c.id, equals(customer.id));
      expect(c.lastSeen, equals(customer.lastSeen));
    });

    test("returns null when there's an error", () async {
      final client = MockClient();
      final sc = MockSc();
      when(
        client.get(
          Uri.https(
            props.baseUrl,
            "/api/customers/identify",
            {
              "external_id": customer.externalId,
              "account_id": props.accountId,
            },
          ),
        ),
      ).thenThrow(HttpException('Request failed'));

      final PapercupsCustomer c = await getCustomerDetailsFromMetadata(
        props,
        customer,
        sc,
        client: client,
      );

      verify(
        client.get(
          Uri.https(
            props.baseUrl,
            "/api/customers/identify",
            {
              "external_id": customer.externalId,
              "account_id": props.accountId,
            },
          ),
        ),
      ).called(1);
      verify(client.close()).called(1);
      verify(sc(c)).called(1);

      expect(c, equals(null));
    });
  });

  group('getPastCustomerMessages', () {
    test('returns a list of Messages and a Customer', () async {
      List<PapercupsMessage> rMsgs = [];
      PapercupsCustomer c;
      final client = MockClient();
      final res = jsonEncode({
        "data": [
          {
            "messages": [
              {
                "account_id": message.accountId,
                "body": message.body,
                "created_at": message.createdAt.toIso8601String(),
                "sent_at": message.sentAt.toIso8601String(),
              },
              {
                "accound_id": message.accountId,
                "body": message.body,
                "created_at": message.createdAt.toIso8601String(),
                "sent_at": message.sentAt.toIso8601String(),
              }
            ],
            "customer": {
              "created_at": customer.createdAt.toIso8601String(),
              "email": customer.email,
              "external_id": customer.externalId,
              "first_seen": customer.firstSeen.toIso8601String(),
              "last_seen": customer.lastSeen.toIso8601String(),
              "updated_at": customer.updatedAt.toIso8601String(),
              "name": customer.name,
              "phone": customer.phone
            }
          }
        ]
      });

      when(
        client.get(
          Uri.https(props.baseUrl, "/api/conversations/customer", {
            "customer_id": customer.id,
            "account_id": props.accountId,
          }),
          headers: anyNamed('headers'),
        ),
      ).thenAnswer((_) async => http.Response(res, 200));

      final cm = await getPastCustomerMessages(
        props,
        customer,
        client: client,
      );
      rMsgs = cm['msgs'];
      c = cm['cust'];

      verify(
        client.get(
          Uri.https(props.baseUrl, "/api/conversations/customer", {
            "customer_id": customer.id,
            "account_id": props.accountId,
          }),
          headers: anyNamed('headers'),
        ),
      ).called(1);
      verify(client.close()).called(1);

      expect(rMsgs.length, equals(2));
      expect(c, isNot(null));
    });

    test("prints an error message when there's an error", () async {
      final client = MockClient();
      when(
        client.get(
          Uri.https(props.baseUrl, "/api/conversations/customer", {
            "customer_id": customer.id,
            "account_id": props.accountId,
          }),
          headers: anyNamed('headers'),
        ),
      ).thenThrow(HttpException('Request failed'));

      await getPastCustomerMessages(
        props,
        customer,
        client: client,
      );

      verify(
        client.get(
          Uri.https(props.baseUrl, "/api/conversations/customer", {
            "customer_id": customer.id,
            "account_id": props.accountId,
          }),
          headers: anyNamed('headers'),
        ),
      ).called(1);
      verify(client.close()).called(1);
      prints("An error ocurred while getting past customer data.");
    });
  });
}
