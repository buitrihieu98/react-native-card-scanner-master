import { NativeModules } from 'react-native';

interface CardScannerResult {
  cardNumber: string;
  cardExpiredDate?: string;
  cardValidDate?: string;
}

export function startScanner(): Promise<CardScannerResult> {
  return new Promise<CardScannerResult>(async (resolve, reject) => {
    try {
      const result = await NativeModules.CardScannerModules.startScanner();
      resolve({
        cardNumber: result.cardNumber,
        cardExpiredDate: result.cardExpiredDate ?? '',
        cardValidDate: result.cardValidDate ?? '',
      });
    } catch (e) {
      reject(e);
    }
  });
}
