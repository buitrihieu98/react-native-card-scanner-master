import * as React from 'react';

import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import { startScanner } from 'react-native-card-scanner';

interface CardScannerResult {
  cardNumber: string;
  cardExpiredDate?: string;
  cardValidDate?: string;
}

export default function App() {
  const [result, setResult] = React.useState<CardScannerResult | undefined>();

  return (
    <View style={styles.container}>
      <Text>Card Number: {result?.cardNumber}</Text>
      <Text>Card ex Date: {result?.cardExpiredDate}</Text>
      <Text>Card valid Date: {result?.cardValidDate}</Text>
      <TouchableOpacity
        style={{
          padding: 16,
          borderWidth: 1,
          borderColor: 'blue',
          marginTop: 16,
        }}
        onPress={async () => {
          try {
            const res = await startScanner();
            setResult(res);
          } catch (e) {
            console.log('DEBUG_APP: ', e);
          }
        }}
      >
        <Text>Start</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
