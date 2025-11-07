class SignalModel {
  final String id;
  final String headline;
  final String summary;
  final List<Signal> signals;
  final RiskManagement riskManagement;
  final String disclaimer;
  final DateTime timestamp;
  final String symbol;
  final String timeframe;

  SignalModel({
    required this.id,
    required this.headline,
    required this.summary,
    required this.signals,
    required this.riskManagement,
    required this.disclaimer,
    required this.timestamp,
    required this.symbol,
    required this.timeframe,
  });

  factory SignalModel.fromJson(Map<String, dynamic> json) {
    return SignalModel(
      id: json['id'] ?? '',
      headline: json['headline'] ?? '',
      summary: json['summary'] ?? '',
      signals: (json['signals'] as List<dynamic>)
          .map((s) => Signal.fromJson(s))
          .toList(),
      riskManagement: RiskManagement.fromJson(json['risk_management'] ?? {}),
      disclaimer: json['disclaimer'] ?? '',
      timestamp: DateTime.parse(json['timestamp'] ?? DateTime.now().toIso8601String()),
      symbol: json['symbol'] ?? 'BTC/USDT',
      timeframe: json['timeframe'] ?? '4h',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'headline': headline,
      'summary': summary,
      'signals': signals.map((s) => s.toJson()).toList(),
      'risk_management': riskManagement.toJson(),
      'disclaimer': disclaimer,
      'timestamp': timestamp.toIso8601String(),
      'symbol': symbol,
      'timeframe': timeframe,
    };
  }
}

class Signal {
  final String type; // 'long' or 'short'
  final Entry entry;
  final double stopLoss;
  final List<double> targets;
  final int confidence; // 0-100
  final String? reasoning;

  Signal({
    required this.type,
    required this.entry,
    required this.stopLoss,
    required this.targets,
    required this.confidence,
    this.reasoning,
  });

  factory Signal.fromJson(Map<String, dynamic> json) {
    return Signal(
      type: json['type'] ?? 'long',
      entry: Entry.fromJson(json['entry'] ?? {}),
      stopLoss: (json['stop_loss'] ?? 0).toDouble(),
      targets: (json['targets'] as List<dynamic>)
          .map((t) => (t as num).toDouble())
          .toList(),
      confidence: json['confidence'] ?? 0,
      reasoning: json['reasoning'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'entry': entry.toJson(),
      'stop_loss': stopLoss,
      'targets': targets,
      'confidence': confidence,
      'reasoning': reasoning,
    };
  }

  bool get isLong => type.toLowerCase() == 'long';
  bool get isShort => type.toLowerCase() == 'short';
}

class Entry {
  final double? limit;
  final double? market;

  Entry({this.limit, this.market});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      limit: json['limit']?.toDouble(),
      market: json['market']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'limit': limit,
      'market': market,
    };
  }

  double get price => limit ?? market ?? 0;
}

class RiskManagement {
  final double maxExposurePctOfPortfolio;
  final double? recommendedLeverage;
  final String? riskLevel; // 'low', 'medium', 'high'

  RiskManagement({
    required this.maxExposurePctOfPortfolio,
    this.recommendedLeverage,
    this.riskLevel,
  });

  factory RiskManagement.fromJson(Map<String, dynamic> json) {
    return RiskManagement(
      maxExposurePctOfPortfolio:
          (json['max_exposure_pct_of_portfolio'] ?? 0).toDouble(),
      recommendedLeverage: json['recommended_leverage']?.toDouble(),
      riskLevel: json['risk_level'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'max_exposure_pct_of_portfolio': maxExposurePctOfPortfolio,
      'recommended_leverage': recommendedLeverage,
      'risk_level': riskLevel,
    };
  }
}
