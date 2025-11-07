class TechnicalIndicator {
  final String name;
  final double value;
  final String signal; // 'bullish', 'bearish', 'neutral'
  final String? description;

  TechnicalIndicator({
    required this.name,
    required this.value,
    required this.signal,
    this.description,
  });

  factory TechnicalIndicator.fromJson(Map<String, dynamic> json) {
    return TechnicalIndicator(
      name: json['name'] ?? '',
      value: (json['value'] ?? 0).toDouble(),
      signal: json['signal'] ?? 'neutral',
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      'signal': signal,
      'description': description,
    };
  }

  bool get isBullish => signal.toLowerCase() == 'bullish';
  bool get isBearish => signal.toLowerCase() == 'bearish';
  bool get isNeutral => signal.toLowerCase() == 'neutral';
}

class MarketAnalysis {
  final String symbol;
  final String timeframe;
  final double currentPrice;
  final double priceChange24h;
  final double volume24h;
  final List<TechnicalIndicator> indicators;
  final SentimentAnalysis sentiment;
  final OnChainMetrics? onChain;
  final DateTime timestamp;

  MarketAnalysis({
    required this.symbol,
    required this.timeframe,
    required this.currentPrice,
    required this.priceChange24h,
    required this.volume24h,
    required this.indicators,
    required this.sentiment,
    this.onChain,
    required this.timestamp,
  });

  factory MarketAnalysis.fromJson(Map<String, dynamic> json) {
    return MarketAnalysis(
      symbol: json['symbol'] ?? 'BTC/USDT',
      timeframe: json['timeframe'] ?? '4h',
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      priceChange24h: (json['price_change_24h'] ?? 0).toDouble(),
      volume24h: (json['volume_24h'] ?? 0).toDouble(),
      indicators: (json['indicators'] as List<dynamic>)
          .map((i) => TechnicalIndicator.fromJson(i))
          .toList(),
      sentiment: SentimentAnalysis.fromJson(json['sentiment'] ?? {}),
      onChain: json['on_chain'] != null
          ? OnChainMetrics.fromJson(json['on_chain'])
          : null,
      timestamp: DateTime.parse(
          json['timestamp'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'symbol': symbol,
      'timeframe': timeframe,
      'current_price': currentPrice,
      'price_change_24h': priceChange24h,
      'volume_24h': volume24h,
      'indicators': indicators.map((i) => i.toJson()).toList(),
      'sentiment': sentiment.toJson(),
      'on_chain': onChain?.toJson(),
      'timestamp': timestamp.toIso8601String(),
    };
  }

  bool get isPriceUp => priceChange24h > 0;
}

class SentimentAnalysis {
  final double score; // -1 to 1 (negative to positive)
  final String label; // 'positive', 'neutral', 'negative'
  final int totalMentions;
  final Map<String, int>? sourceCounts; // Twitter, Reddit, News counts

  SentimentAnalysis({
    required this.score,
    required this.label,
    required this.totalMentions,
    this.sourceCounts,
  });

  factory SentimentAnalysis.fromJson(Map<String, dynamic> json) {
    return SentimentAnalysis(
      score: (json['score'] ?? 0).toDouble(),
      label: json['label'] ?? 'neutral',
      totalMentions: json['total_mentions'] ?? 0,
      sourceCounts: json['source_counts'] != null
          ? Map<String, int>.from(json['source_counts'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'score': score,
      'label': label,
      'total_mentions': totalMentions,
      'source_counts': sourceCounts,
    };
  }

  bool get isPositive => score > 0.2;
  bool get isNegative => score < -0.2;
  bool get isNeutral => score >= -0.2 && score <= 0.2;
}

class OnChainMetrics {
  final double activeAddresses;
  final double netFlow;
  final double whaleRatio;
  final String trend; // 'bullish', 'bearish', 'neutral'

  OnChainMetrics({
    required this.activeAddresses,
    required this.netFlow,
    required this.whaleRatio,
    required this.trend,
  });

  factory OnChainMetrics.fromJson(Map<String, dynamic> json) {
    return OnChainMetrics(
      activeAddresses: (json['active_addresses'] ?? 0).toDouble(),
      netFlow: (json['net_flow'] ?? 0).toDouble(),
      whaleRatio: (json['whale_ratio'] ?? 0).toDouble(),
      trend: json['trend'] ?? 'neutral',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'active_addresses': activeAddresses,
      'net_flow': netFlow,
      'whale_ratio': whaleRatio,
      'trend': trend,
    };
  }
}
