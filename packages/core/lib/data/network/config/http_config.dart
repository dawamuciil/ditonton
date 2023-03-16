import 'dart:io';

import 'package:flutter/services.dart';

Future<SecurityContext> get _securityContext async {
  final sslCert = await rootBundle.load('certificates/certificates.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  return securityContext;
}

Future<HttpClient> get httpClient async {
  HttpClient client = HttpClient(context: await _securityContext);
  client.badCertificateCallback =
      (cert, host, port) => cert.pem == 'PEM' ? true : false;

  return client;
}
