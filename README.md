# react-native-card-scanner

## Overview

A library for scanning atm and credit cards based on Vision (iOS) and Tensor Flow (Android).
Note: Reading card's expired, valid date is not supported on Android

## Demo:

### iOS

<img src="https://i.imgur.com/bK2JcUT.gif" alt="drawing" width="200"/>

### Android

<img src="https://i.imgur.com/PKYwDgX.gif" alt="drawing" width="200"/>

## Installation

```sh
npm install react-native-card-scanner
```

## Usage

```ts
import { startScanner } from 'react-native-card-scanner'

interface CardScannerResult {
  cardNumber: string;
  cardExpiredDate?: string;
  cardValidDate?: string;
}

const response: CardScannerResult = await startScanner()
```

## Contributing


See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
