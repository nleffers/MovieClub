module.exports = {
  moduleFileExtensions: [
    'js',
    'vue'
  ],
  moduleNameMapper: {
    '^@/(.*)$': '<rootDir>/src/$1'
  },
  preset: '@vue/cli-plugin-unit-jest',
  transformIgnorePatterns: ['/node_modules/(?!vue|lodash|@jest|@babel)'],
  transform: {
    '^.+\\.(js|jsx)?$': 'babel-jest',
    '^.+\\.vue$': 'vue-jest'
  },
  testMatch: ['**/tests/unit/*.js?(x)'],
  testEnvironment: 'jsdom',
  globals: {
    '_': require('lodash')
  }
}
