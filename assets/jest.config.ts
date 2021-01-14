export default {
  preset: "ts-jest",
  clearMocks: true,
  coverageDirectory: "coverage",
  setupFilesAfterEnv: [
    "jest-enzyme",
    "<rootDir>/setupTests.ts"
  ],
  transform: {
    "\\.(gql|graphql)$": "jest-transform-graphql",
    "\\.tsx?$": "ts-jest",
    ".*": "babel-jest"
  },
  moduleNameMapper: {
    "~/(.*)": "<rootDir>/js/$1"
  },
  testEnvironment: "enzyme",
  testEnvironmentOptions: {
    enzymeAdapter: "react16"
  },
};
