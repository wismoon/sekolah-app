class BaseUrlConstants {
  static const String baseUrl = 'http://192.168.1.10:3350/api';
  static const String contentTypeJson = 'application/json; charset=UTF-8';
}

class TransaksiEndpoints {
  static const String jenisPembayaran = '/transaksi/jenisPembayaran';
}

class PembayaranEndpoints {
  static const String biayaPembayaran = '/transaksi/biayaPembayaran';
}

class PeriodeEndpoints {
  static const String periodePembayaran = '/transaksi/periodePembayaran';
}

class AuthConstants {
  static const String bearerToken = 'client-eBFdeAc2VRpFezqK';
}

// class AuthEndpoints {
//   static const String login = '/auth/login';
//   static const String register = '/auth/register';
// }