import '../models/currency.dart';

final Map<String, Currency> currencies = {
  'ALL':
      Currency(currencyName: "Albanian Lek", currencySymbol: "Lek", id: "ALL"),
  'XCD': Currency(
      currencyName: "East Caribbean Dollar", currencySymbol: "\$", id: "XCD"),
  'EUR': Currency(currencyName: "Euro", currencySymbol: "€", id: "EUR"),
  'BBD': Currency(
      currencyName: "Barbadian Dollar", currencySymbol: "\$", id: "BBD"),
  'BTN': Currency(currencyName: "Bhutanese Ngultrum", id: "BTN"),
  'BND':
      Currency(currencyName: "Brunei Dollar", currencySymbol: "\$", id: "BND"),
  'XAF': Currency(currencyName: "Central African CFA Franc", id: "XAF"),
  'CUP': Currency(currencyName: "Cuban Peso", currencySymbol: "\$", id: "CUP"),
  'USD': Currency(
      currencyName: "United States Dollar", currencySymbol: "\$", id: "USD"),
  'FKP': Currency(
      currencyName: "Falkland Islands Pound", currencySymbol: "£", id: "FKP"),
  'GIP':
      Currency(currencyName: "Gibraltar Pound", currencySymbol: "£", id: "GIP"),
  'HUF': Currency(
      currencyName: "Hungarian Forint", currencySymbol: "Ft", id: "HUF"),
  'IRR': Currency(currencyName: "Iranian Rial", currencySymbol: "﷼", id: "IRR"),
  'JMD': Currency(
      currencyName: "Jamaican Dollar", currencySymbol: "J\$", id: "JMD"),
  'AUD': Currency(
      currencyName: "Australian Dollar", currencySymbol: "\$", id: "AUD"),
  'LAK': Currency(currencyName: "Lao Kip", currencySymbol: "₭", id: "LAK"),
  'LYD': Currency(currencyName: "Libyan Dinar", id: "LYD"),
  'MKD': Currency(
      currencyName: "Macedonian Denar", currencySymbol: "ден", id: "MKD"),
  'XOF': Currency(currencyName: "West African CFA Franc", id: "XOF"),
  'NZD': Currency(
      currencyName: "New Zealand Dollar", currencySymbol: "\$", id: "NZD"),
  'OMR': Currency(currencyName: "Omani Rial", currencySymbol: "﷼", id: "OMR"),
  'PGK': Currency(currencyName: "Papua New Guinean Kina", id: "PGK"),
  'RWF': Currency(currencyName: "Rwandan Franc", id: "RWF"),
  'WST': Currency(currencyName: "Samoan Tala", id: "WST"),
  'RSD': Currency(
      currencyName: "Serbian Dinar", currencySymbol: "Дин.", id: "RSD"),
  'SEK':
      Currency(currencyName: "Swedish Krona", currencySymbol: "kr", id: "SEK"),
  'TZS': Currency(
      currencyName: "Tanzanian Shilling", currencySymbol: "TSh", id: "TZS"),
  'AMD': Currency(currencyName: "Armenian Dram", id: "AMD"),
  'BSD': Currency(
      currencyName: "Bahamian Dollar", currencySymbol: "\$", id: "BSD"),
  'BAM': Currency(
      currencyName: "Bosnia And Herzegovina Konvertibilna Marka",
      currencySymbol: "KM",
      id: "BAM"),
  'CVE': Currency(currencyName: "Cape Verdean Escudo", id: "CVE"),
  'CNY': Currency(currencyName: "Chinese Yuan", currencySymbol: "¥", id: "CNY"),
  'CRC': Currency(
      currencyName: "Costa Rican Colon", currencySymbol: "₡", id: "CRC"),
  'CZK':
      Currency(currencyName: "Czech Koruna", currencySymbol: "Kč", id: "CZK"),
  'ERN': Currency(currencyName: "Eritrean Nakfa", id: "ERN"),
  'GEL': Currency(currencyName: "Georgian Lari", id: "GEL"),
  'HTG': Currency(currencyName: "Haitian Gourde", id: "HTG"),
  'INR': Currency(currencyName: "Indian Rupee", currencySymbol: "₹", id: "INR"),
  'JOD': Currency(currencyName: "Jordanian Dinar", id: "JOD"),
  'KRW': Currency(
      currencyName: "South Korean Won", currencySymbol: "₩", id: "KRW"),
  'LBP':
      Currency(currencyName: "Lebanese Lira", currencySymbol: "£", id: "LBP"),
  'MWK': Currency(currencyName: "Malawian Kwacha", id: "MWK"),
  'MRO': Currency(currencyName: "Mauritanian Ouguiya", id: "MRO"),
  'MZN': Currency(currencyName: "Mozambican Metical", id: "MZN"),
  'ANG': Currency(
      currencyName: "Netherlands Antillean Gulden",
      currencySymbol: "ƒ",
      id: "ANG"),
  'PEN': Currency(
      currencyName: "Peruvian Nuevo Sol", currencySymbol: "S/.", id: "PEN"),
  'QAR': Currency(currencyName: "Qatari Riyal", currencySymbol: "﷼", id: "QAR"),
  'STD': Currency(currencyName: "Sao Tome And Principe Dobra", id: "STD"),
  'SLL': Currency(currencyName: "Sierra Leonean Leone", id: "SLL"),
  'SOS':
      Currency(currencyName: "Somali Shilling", currencySymbol: "S", id: "SOS"),
  'SDG': Currency(currencyName: "Sudanese Pound", id: "SDG"),
  'SYP': Currency(currencyName: "Syrian Pound", currencySymbol: "£", id: "SYP"),
  'AOA': Currency(currencyName: "Angolan Kwanza", id: "AOA"),
  'AWG':
      Currency(currencyName: "Aruban Florin", currencySymbol: "ƒ", id: "AWG"),
  'BHD': Currency(currencyName: "Bahraini Dinar", id: "BHD"),
  'BZD': Currency(
      currencyName: "Belize Dollar", currencySymbol: "BZ\$", id: "BZD"),
  'BWP':
      Currency(currencyName: "Botswana Pula", currencySymbol: "P", id: "BWP"),
  'BIF': Currency(currencyName: "Burundi Franc", id: "BIF"),
  'KYD': Currency(
      currencyName: "Cayman Islands Dollar", currencySymbol: "\$", id: "KYD"),
  'COP':
      Currency(currencyName: "Colombian Peso", currencySymbol: "\$", id: "COP"),
  'DKK':
      Currency(currencyName: "Danish Krone", currencySymbol: "kr", id: "DKK"),
  'GTQ': Currency(
      currencyName: "Guatemalan Quetzal", currencySymbol: "Q", id: "GTQ"),
  'HNL': Currency(
      currencyName: "Honduran Lempira", currencySymbol: "L", id: "HNL"),
  'IDR': Currency(
      currencyName: "Indonesian Rupiah", currencySymbol: "Rp", id: "IDR"),
  'ILS': Currency(
      currencyName: "Israeli New Sheqel", currencySymbol: "₪", id: "ILS"),
  'KZT': Currency(
      currencyName: "Kazakhstani Tenge", currencySymbol: "лв", id: "KZT"),
  'KWD': Currency(currencyName: "Kuwaiti Dinar", id: "KWD"),
  'LSL': Currency(currencyName: "Lesotho Loti", id: "LSL"),
  'MYR': Currency(
      currencyName: "Malaysian Ringgit", currencySymbol: "RM", id: "MYR"),
  'MUR':
      Currency(currencyName: "Mauritian Rupee", currencySymbol: "₨", id: "MUR"),
  'MNT': Currency(
      currencyName: "Mongolian Tugrik", currencySymbol: "₮", id: "MNT"),
  'MMK': Currency(currencyName: "Myanma Kyat", id: "MMK"),
  'NGN':
      Currency(currencyName: "Nigerian Naira", currencySymbol: "₦", id: "NGN"),
  'PAB': Currency(
      currencyName: "Panamanian Balboa", currencySymbol: "B/.", id: "PAB"),
  'PHP':
      Currency(currencyName: "Philippine Peso", currencySymbol: "₱", id: "PHP"),
  'RON':
      Currency(currencyName: "Romanian Leu", currencySymbol: "lei", id: "RON"),
  'SAR': Currency(currencyName: "Saudi Riyal", currencySymbol: "﷼", id: "SAR"),
  'SGD': Currency(
      currencyName: "Singapore Dollar", currencySymbol: "\$", id: "SGD"),
  'ZAR': Currency(
      currencyName: "South African Rand", currencySymbol: "R", id: "ZAR"),
  'SRD': Currency(
      currencyName: "Surinamese Dollar", currencySymbol: "\$", id: "SRD"),
  'TWD': Currency(
      currencyName: "New Taiwan Dollar", currencySymbol: "NT\$", id: "TWD"),
  'TOP': Currency(currencyName: "Paanga", id: "TOP"),
  'VEF': Currency(currencyName: "Venezuelan Bolivar", id: "VEF"),
  'DZD': Currency(currencyName: "Algerian Dinar", id: "DZD"),
  'ARS':
      Currency(currencyName: "Argentine Peso", currencySymbol: "\$", id: "ARS"),
  'AZN': Currency(
      currencyName: "Azerbaijani Manat", currencySymbol: "ман", id: "AZN"),
  'BYR': Currency(
      currencyName: "Belarusian Ruble", currencySymbol: "p.", id: "BYR"),
  'BOB': Currency(
      currencyName: "Bolivian Boliviano", currencySymbol: "\$b", id: "BOB"),
  'BGN':
      Currency(currencyName: "Bulgarian Lev", currencySymbol: "лв", id: "BGN"),
  'CAD': Currency(
      currencyName: "Canadian Dollar", currencySymbol: "\$", id: "CAD"),
  'CLP':
      Currency(currencyName: "Chilean Peso", currencySymbol: "\$", id: "CLP"),
  'CDF': Currency(currencyName: "Congolese Franc", id: "CDF"),
  'DOP': Currency(
      currencyName: "Dominican Peso", currencySymbol: "RD\$", id: "DOP"),
  'FJD':
      Currency(currencyName: "Fijian Dollar", currencySymbol: "\$", id: "FJD"),
  'GMD': Currency(currencyName: "Gambian Dalasi", id: "GMD"),
  'GYD': Currency(
      currencyName: "Guyanese Dollar", currencySymbol: "\$", id: "GYD"),
  'ISK': Currency(
      currencyName: "Icelandic Króna", currencySymbol: "kr", id: "ISK"),
  'IQD': Currency(currencyName: "Iraqi Dinar", id: "IQD"),
  'JPY': Currency(currencyName: "Japanese Yen", currencySymbol: "¥", id: "JPY"),
  'KPW': Currency(
      currencyName: "North Korean Won", currencySymbol: "₩", id: "KPW"),
  'LVL':
      Currency(currencyName: "Latvian Lats", currencySymbol: "Ls", id: "LVL"),
  'CHF':
      Currency(currencyName: "Swiss Franc", currencySymbol: "Fr.", id: "CHF"),
  'MGA': Currency(currencyName: "Malagasy Ariary", id: "MGA"),
  'MDL': Currency(currencyName: "Moldovan Leu", id: "MDL"),
  'MAD': Currency(currencyName: "Moroccan Dirham", id: "MAD"),
  'NPR':
      Currency(currencyName: "Nepalese Rupee", currencySymbol: "₨", id: "NPR"),
  'NIO': Currency(
      currencyName: "Nicaraguan Cordoba", currencySymbol: "C\$", id: "NIO"),
  'PKR':
      Currency(currencyName: "Pakistani Rupee", currencySymbol: "₨", id: "PKR"),
  'PYG': Currency(
      currencyName: "Paraguayan Guarani", currencySymbol: "Gs", id: "PYG"),
  'SHP': Currency(
      currencyName: "Saint Helena Pound", currencySymbol: "£", id: "SHP"),
  'SCR': Currency(
      currencyName: "Seychellois Rupee", currencySymbol: "₨", id: "SCR"),
  'SBD': Currency(
      currencyName: "Solomon Islands Dollar", currencySymbol: "\$", id: "SBD"),
  'LKR': Currency(
      currencyName: "Sri Lankan Rupee", currencySymbol: "₨", id: "LKR"),
  'THB': Currency(currencyName: "Thai Baht", currencySymbol: "฿", id: "THB"),
  'TRY': Currency(currencyName: "Turkish New Lira", id: "TRY"),
  'AED': Currency(currencyName: "UAE Dirham", id: "AED"),
  'VUV': Currency(currencyName: "Vanuatu Vatu", id: "VUV"),
  'YER': Currency(currencyName: "Yemeni Rial", currencySymbol: "﷼", id: "YER"),
  'AFN':
      Currency(currencyName: "Afghan Afghani", currencySymbol: "؋", id: "AFN"),
  'BDT': Currency(currencyName: "Bangladeshi Taka", id: "BDT"),
  'BRL': Currency(
      currencyName: "Brazilian Real", currencySymbol: "R\$", id: "BRL"),
  'KHR':
      Currency(currencyName: "Cambodian Riel", currencySymbol: "៛", id: "KHR"),
  'KMF': Currency(currencyName: "Comorian Franc", id: "KMF"),
  'HRK':
      Currency(currencyName: "Croatian Kuna", currencySymbol: "kn", id: "HRK"),
  'DJF': Currency(currencyName: "Djiboutian Franc", id: "DJF"),
  'EGP':
      Currency(currencyName: "Egyptian Pound", currencySymbol: "£", id: "EGP"),
  'ETB': Currency(currencyName: "Ethiopian Birr", id: "ETB"),
  'XPF': Currency(currencyName: "CFP Franc", id: "XPF"),
  'GHS': Currency(currencyName: "Ghanaian Cedi", id: "GHS"),
  'GNF': Currency(currencyName: "Guinean Franc", id: "GNF"),
  'HKD': Currency(
      currencyName: "Hong Kong Dollar", currencySymbol: "\$", id: "HKD"),
  'XDR': Currency(currencyName: "Special Drawing Rights", id: "XDR"),
  'KES': Currency(
      currencyName: "Kenyan Shilling", currencySymbol: "KSh", id: "KES"),
  'KGS': Currency(
      currencyName: "Kyrgyzstani Som", currencySymbol: "лв", id: "KGS"),
  'LRD': Currency(
      currencyName: "Liberian Dollar", currencySymbol: "\$", id: "LRD"),
  'MOP': Currency(currencyName: "Macanese Pataca", id: "MOP"),
  'MVR': Currency(currencyName: "Maldivian Rufiyaa", id: "MVR"),
  'MXN':
      Currency(currencyName: "Mexican Peso", currencySymbol: "\$", id: "MXN"),
  'NAD': Currency(
      currencyName: "Namibian Dollar", currencySymbol: "\$", id: "NAD"),
  'NOK': Currency(
      currencyName: "Norwegian Krone", currencySymbol: "kr", id: "NOK"),
  'PLN':
      Currency(currencyName: "Polish Zloty", currencySymbol: "zł", id: "PLN"),
  'RUB':
      Currency(currencyName: "Russian Ruble", currencySymbol: "руб", id: "RUB"),
  'SZL': Currency(currencyName: "Swazi Lilangeni", id: "SZL"),
  'TJS': Currency(currencyName: "Tajikistani Somoni", id: "TJS"),
  'TTD': Currency(
      currencyName: "Trinidad and Tobago Dollar",
      currencySymbol: "TT\$",
      id: "TTD"),
  'UGX': Currency(
      currencyName: "Ugandan Shilling", currencySymbol: "USh", id: "UGX"),
  'UYU': Currency(
      currencyName: "Uruguayan Peso", currencySymbol: "\$U", id: "UYU"),
  'VND':
      Currency(currencyName: "Vietnamese Dong", currencySymbol: "₫", id: "VND"),
  'TND': Currency(currencyName: "Tunisian Dinar", id: "TND"),
  'UAH': Currency(
      currencyName: "Ukrainian Hryvnia", currencySymbol: "₴", id: "UAH"),
  'UZS': Currency(
      currencyName: "Uzbekistani Som", currencySymbol: "лв", id: "UZS"),
  'TMT': Currency(currencyName: "Turkmenistan Manat", id: "TMT"),
  'GBP':
      Currency(currencyName: "British Pound", currencySymbol: "£", id: "GBP"),
  'ZMW': Currency(currencyName: "Zambian Kwacha", id: "ZMW"),
  'BTC': Currency(currencyName: "Bitcoin", currencySymbol: "BTC", id: "BTC"),
  'BYN': Currency(
      currencyName: "New Belarusian Ruble", currencySymbol: "p.", id: "BYN"),
  'BMD': Currency(currencyName: "Bermudan Dollar", id: "BMD"),
  'GGP': Currency(currencyName: "Guernsey Pound", id: "GGP"),
  'CLF': Currency(currencyName: "Chilean Unit Of Account", id: "CLF"),
  'CUC': Currency(currencyName: "Cuban Convertible Peso", id: "CUC"),
  'IMP': Currency(currencyName: "Manx pound", id: "IMP"),
  'JEP': Currency(currencyName: "Jersey Pound", id: "JEP"),
  'SVC': Currency(currencyName: "Salvadoran Colón", id: "SVC"),
  'ZMK': Currency(currencyName: "Old Zambian Kwacha", id: "ZMK"),
  'XAG': Currency(currencyName: "Silver (troy ounce)", id: "XAG"),
  'ZWL': Currency(currencyName: "Zimbabwean Dollar", id: "ZWL")
};
