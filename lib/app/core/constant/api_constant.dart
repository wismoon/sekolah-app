class BaseUrlConstants {
  static const String baseUrl = 'http://192.168.206.1:3350/api';
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

class InvoiceEndpoints {
  static const String invoicePembayaran = '/pembayaran/invoice';
  static const String invoiceBulkPembayaran = '/pembayaran/invoiceBulk';
  static const String paymentCreate = '/pembayaran/create';
  static const String paymentStatus = '/pembayaran/status';
}

class AuthConstants {
  static const String bearerToken = 'client-eBFdeAc2VRpFezqK';
  
}
