import '../models/signal_model.dart';
import '../models/technical_indicator.dart';
import 'dart:math';

class MockDataService {
  static final Random _random = Random();

  // Mock Signals
  static List<SignalModel> getMockSignals() {
    return [
      SignalModel(
        id: 'sig_001',
        headline: 'BTC/USDT 4h — Yükselen trend zayıflıyor, destek 61,200',
        summary:
            'Momentum zayıfladı, RSI 56. Orta vadeli yükseliş trendi korunuyor. Hacim düşük, volatilite orta seviyede.',
        signals: [
          Signal(
            type: 'long',
            entry: Entry(limit: 62000),
            stopLoss: 59500,
            targets: [65500, 70000],
            confidence: 62,
            reasoning:
                'RSI nötr bölgede, MACD pozitif, destek seviyesi güçlü. Hacim artışı beklendiğinde yukarı hareket olasılığı yüksek.',
          ),
        ],
        riskManagement: RiskManagement(
          maxExposurePctOfPortfolio: 10,
          recommendedLeverage: 2,
          riskLevel: 'medium',
        ),
        disclaimer: 'Bu sinyal yatırım tavsiyesi değildir. Risk yönetimi önemlidir.',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        symbol: 'BTC/USDT',
        timeframe: '4h',
      ),
      SignalModel(
        id: 'sig_002',
        headline: 'ETH/USDT 1h — Kısa vadeli düşüş sinyali, direnç 3,850',
        summary:
            'RSI 72 ile aşırı alım bölgesinde. MACD negatif kesişim gösterdi. Kısa vadeli düzeltme bekleniyor.',
        signals: [
          Signal(
            type: 'short',
            entry: Entry(limit: 3800),
            stopLoss: 3920,
            targets: [3650, 3500],
            confidence: 68,
            reasoning:
                'Aşırı alım bölgesinde, hacim azalıyor, direnç seviyesinde satış baskısı var.',
          ),
        ],
        riskManagement: RiskManagement(
          maxExposurePctOfPortfolio: 8,
          recommendedLeverage: 1.5,
          riskLevel: 'medium',
        ),
        disclaimer: 'Bu sinyal yatırım tavsiyesi değildir.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        symbol: 'ETH/USDT',
        timeframe: '1h',
      ),
      SignalModel(
        id: 'sig_003',
        headline: 'BNB/USDT 4h — Güçlü destek testinde, toparlanma sinyali',
        summary:
            'Fiyat 320 destek seviyesini test ediyor. RSI 38, aşırı satım yakın. Pozitif divergence mevcut.',
        signals: [
          Signal(
            type: 'long',
            entry: Entry(limit: 325),
            stopLoss: 310,
            targets: [345, 365],
            confidence: 74,
            reasoning:
                'Güçlü destek seviyesinde, pozitif RSI divergence, hacim artışı başladı.',
          ),
        ],
        riskManagement: RiskManagement(
          maxExposurePctOfPortfolio: 12,
          recommendedLeverage: 2.5,
          riskLevel: 'low',
        ),
        disclaimer: 'Risk yönetimi kurallarına uyunuz.',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        symbol: 'BNB/USDT',
        timeframe: '4h',
      ),
      SignalModel(
        id: 'sig_004',
        headline: 'SOL/USDT 2h — Breakout potansiyeli, direnç 145',
        summary:
            'Daralan üçgen formasyonu. Hacim artıyor, momentum güçleniyor. Yukarı kırılım beklenebilir.',
        signals: [
          Signal(
            type: 'long',
            entry: Entry(limit: 143),
            stopLoss: 138,
            targets: [152, 160],
            confidence: 71,
            reasoning:
                'Daralan üçgen formasyonu, hacim artışı, teknik göstergeler pozitif.',
          ),
        ],
        riskManagement: RiskManagement(
          maxExposurePctOfPortfolio: 10,
          recommendedLeverage: 2,
          riskLevel: 'medium',
        ),
        disclaimer: 'Kendi araştırmanızı yapınız.',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        symbol: 'SOL/USDT',
        timeframe: '2h',
      ),
    ];
  }

  // Mock Market Analysis
  static MarketAnalysis getMockMarketAnalysis(String symbol) {
    return MarketAnalysis(
      symbol: symbol,
      timeframe: '4h',
      currentPrice: symbol == 'BTC/USDT' ? 62150.50 : 3785.25,
      priceChange24h: _random.nextBool() ? _random.nextDouble() * 5 : -_random.nextDouble() * 5,
      volume24h: _random.nextDouble() * 1000000000,
      indicators: [
        TechnicalIndicator(
          name: 'RSI (14)',
          value: 56.3,
          signal: 'neutral',
          description: 'Momentum orta seviyede, nötr bölge',
        ),
        TechnicalIndicator(
          name: 'MACD',
          value: 0.45,
          signal: 'bullish',
          description: 'Pozitif momentum, yukarı yönlü',
        ),
        TechnicalIndicator(
          name: 'EMA (20)',
          value: 61800.0,
          signal: 'bullish',
          description: 'Fiyat EMA üzerinde',
        ),
        TechnicalIndicator(
          name: 'Bollinger Bands',
          value: 62500.0,
          signal: 'neutral',
          description: 'Orta band yakınında',
        ),
        TechnicalIndicator(
          name: 'Volume',
          value: 850000000,
          signal: 'neutral',
          description: 'Ortalama hacim seviyeleri',
        ),
      ],
      sentiment: SentimentAnalysis(
        score: 0.35,
        label: 'positive',
        totalMentions: 15420,
        sourceCounts: {
          'Twitter': 8500,
          'Reddit': 4200,
          'News': 2720,
        },
      ),
      onChain: OnChainMetrics(
        activeAddresses: 892450,
        netFlow: 1250.5,
        whaleRatio: 0.42,
        trend: 'bullish',
      ),
      timestamp: DateTime.now(),
    );
  }

  // Mock signal for detail screen
  static SignalModel getMockSignalDetail(String signalId) {
    final signals = getMockSignals();
    return signals.firstWhere(
      (signal) => signal.id == signalId,
      orElse: () => signals.first,
    );
  }

  // Generate random price for chart simulation
  static List<double> generateMockPriceData(int points, double basePrice) {
    List<double> prices = [];
    double currentPrice = basePrice;
    
    for (int i = 0; i < points; i++) {
      double change = (_random.nextDouble() - 0.5) * (basePrice * 0.02);
      currentPrice += change;
      prices.add(currentPrice);
    }
    
    return prices;
  }
}
